#include <stdio.h>
#include <assert.h>
#include "assem.h"
#include "util.h"
#include "symbol.h"
#include "temp.h"
#include "assemblock.h"
#include "llvm_assem.h"
#include "llvm_assemblock.h"

/* Make a block list */
LLVM_IR::llvm_AS_blockList_ *LLVM_IR::AS_BlockList(LLVM_IR::llvm_AS_block_ *head, LLVM_IR::llvm_AS_blockList_ *tail){ 
    LLVM_IR::llvm_AS_blockList_ *list = (LLVM_IR::llvm_AS_blockList_ *)checked_malloc (sizeof *list);
    list->head=head;
    list->tail=tail;
    return list;
}

/* given a list of instructions that's a basic block, i.e.,
   starts with a label and ends with a jump/ret
   make a AS_block, which consists of instrs, start_label, jump_to_labels
*/

LLVM_IR::llvm_AS_block_ *LLVM_IR::AS_Block(LLVM_IR::T_irList_ *irs){ 
    LLVM_IR::llvm_AS_block_ *b = (LLVM_IR::llvm_AS_block_ *)checked_malloc (sizeof *b);
    LLVM_IR::T_irList_ *last;
    b->irs = irs;
    if (irs->head->i->kind == AS_instr_::I_LABEL) 
        b->label = irs->head->i->u.LABEL.label;
    else 
        assert(0); //has to be a label!
    last=irs; 
    while (last->tail) last=last->tail;
    if (last->head->i->kind == AS_instr_::I_OPER) {
        if (last->head->i->u.OPER.jumps) 
            b->succs = last->head->i->u.OPER.jumps->labels;
        else
            b->succs = NULL;
    }
    else{
      assert(0); //has to be an OPER (can't be a label or move)!
    }
    return b;
}

AS_blockList irBlock_to_insBlock(LLVM_IR::llvm_AS_blockList_ * bl){
  AS_blockList bList = NULL;
  AS_blockList blast = NULL;
  AS_instrList iList = NULL;
  AS_instrList ilast = NULL;
  LLVM_IR::llvm_AS_blockList_ *l = bl;
  while(l){
    LLVM_IR::T_irList_ *irl = l->head->irs;

    iList = NULL;
    ilast = NULL;
    while(irl){
      if(ilast) ilast = ilast->tail = AS_InstrList(irl->head->i, NULL);
      else ilast = iList = AS_InstrList(irl->head->i, NULL);

      irl = irl->tail;
    }

    if(blast) blast = blast->tail = AS_BlockList(AS_Block(iList), NULL);
    else blast = bList = AS_BlockList(AS_Block(iList), NULL);

    l = l->tail;
  }
  
  return bList;
}

static LLVM_IR::llvm_AS_blockList_ *global_bl;
static S_table block_env;

static LLVM_IR::T_irList_ * getNext(LLVM_IR::T_irList_ * epilog, Bool optimize);

static LLVM_IR::T_irList_ * getLast(LLVM_IR::T_irList_ * list) 
  //list must leng>=2. sen'd to last! 
{   
  LLVM_IR::T_irList_ * last = list;
  while (last->tail->tail) last = last->tail;
  return last;
}  

static void trace(LLVM_IR::T_irList_ * list, LLVM_IR::T_irList_ * epilog, Bool optimize) //this list is a basic block
{
  LLVM_IR::T_irList_ *last = getLast(list); //second to the last before the br/ret
  LLVM_IR::T_ir_ *lab = list->head; //this must be a label instruction
  LLVM_IR::T_ir_ *s = last->tail->head; //the last (last) stm (jump/cjump)
                                //or a return
  S_enter(block_env, lab->i->u.LABEL.label, NULL);  //mark it already traced!

  if (!optimize) { //just pick up the next block and continue
    last->tail->tail=getNext(epilog, optimize);
    return;
  } 
  /* now try an optimized trace, as follows:
     if br to one label, then try to get the block
     with the label to follow, then eliminate the br instruction.
     if br to more than one label, do nothing
  */ 
  if (s->i->kind != AS_instr_::I_OPER ) assert(-1); // can't be a label of move!
  
  if ( !s->i->u.OPER.jumps || !s->i->u.OPER.jumps->labels) { 
				//jump to nowhwere! assume it's a ret 
    last->tail->tail=getNext(epilog, optimize);
    return;
  }

  /* now take a look a the target labels */
  Temp_labelList labellist=s->i->u.OPER.jumps->labels;
  if (labellist->tail) { // more than two labels! nothing to do again
    last->tail->tail=getNext(epilog, optimize);
    return;
  }

  Temp_label nn=labellist->head; //here to jump to

  LLVM_IR::llvm_AS_block_ *target = (LLVM_IR::llvm_AS_block_ *) S_look(block_env, nn);
    if (target) {
      last->tail = target->irs; 
		/* merge the 2 lists removing br instruction */
      trace(target->irs, epilog, optimize);
    }
    else 
      last->tail->tail = getNext(epilog, optimize); 
             /* can't find the jump-to block! 
                either it's a jumpt to nowhere (should be to the exit), 
                or the block has already been traced! */
}

/* get the next block from the list of stmLists, using only those that have
 * not been traced yet */

static LLVM_IR::T_irList_ *getNext(LLVM_IR::T_irList_ * epilog, Bool optimize)
{
  if (!global_bl)
    return epilog;

  LLVM_IR::llvm_AS_block_ * b = global_bl->head;
  global_bl = global_bl->tail;
  if (S_look(block_env, b->label)) {
		/* label exists in the table, i.e., not traced yet! */
    trace(b->irs, epilog, optimize);
    return b->irs;
  }
  else {
    return getNext(epilog, optimize);
  }
}

/* build the entire method from blockList: 1) put the prolog in the beginning,
 then 2) trace the blocks in the blocklist, and 3) put the epilog in the end,
 4) If optimize is true, try to eliminate jumps, otherwise, keep all the jumps */
LLVM_IR::T_irList_ * LLVM_IR::AS_traceSchedule(LLVM_IR::llvm_AS_blockList_ *bl, 
	LLVM_IR::T_irList_ *prolog, LLVM_IR::T_irList_ * epilog, Bool optimize){ 
  LLVM_IR::llvm_AS_blockList_ *blist;
  LLVM_IR::T_irList_ * ll;

  block_env = S_empty(); /* (re)start block env */
  global_bl = bl; /* give it to the global_bl */

  /* build a table: from label -> block */
  for (blist=bl; blist; blist=blist->tail) {
    S_enter(block_env, blist->head->label, blist->head);
  }
  if (!prolog) return getNext(epilog, optimize);
  ll=prolog;
  while (prolog->tail) prolog=prolog->tail;
  prolog->tail=getNext(epilog, optimize);
  return ll;
}
