// this instruction schedule is used to release register pressure
// only schedule instruction inside a basic block
#include "assem.h"
#include "regalloc.h"
#include "temp.h"
#include "liveness.h"
#include "liveness_color.h"
#include <cstdio>
#include <unordered_map>
#include <unordered_set>
#include <string.h>
#include <assert.h>
#include <utility>
#include <vector>
#include <set>
#include <stack>



using std::unordered_map;
using std::unordered_set;
using std::pair;
using std::make_pair;
using std::set;
using std::stack;


static bool isMemAccess(AS_instr ins){
    if(ins->kind == AS_instr_::I_OPER){
        if((ins->u.OPER.assem[0] == 'l' && ins->u.OPER.assem[1] == 'd' && ins->u.OPER.assem[2] == 'r')
        || (ins->u.OPER.assem[0] == 's' && ins->u.OPER.assem[1] == 't' && ins->u.OPER.assem[2] == 'r')
        || (ins->u.OPER.assem[0] == 'p' && ins->u.OPER.assem[1] == 'o' && ins->u.OPER.assem[2] == 'p')
        || (ins->u.OPER.assem[0] == 'v' && ins->u.OPER.assem[1] == 'l' && ins->u.OPER.assem[2] == 'd' && ins->u.OPER.assem[3] == 'r')
        || (ins->u.OPER.assem[0] == 'v' && ins->u.OPER.assem[1] == 's' && ins->u.OPER.assem[2] == 't' && ins->u.OPER.assem[3] == 'r')
        || (ins->u.OPER.assem[0] == 'p' && ins->u.OPER.assem[1] == 'u' && ins->u.OPER.assem[2] == 's' && ins->u.OPER.assem[3] == 'h')){
            return true;
        }else{
            return false;
        }
    }else{
        return false;
    }
}

static bool isCond(AS_instr ins){
    std::string cond;
    if(ins->kind == AS_instr_::I_OPER){
        int len = strlen(ins->u.OPER.assem);
        int i=0;
        for(; i<len; ++i){
            if(ins->u.OPER.assem[i] == ' ' || ins->u.OPER.assem[i] == '.'){
                break;
            }
        }

        assert(ins->u.OPER.assem[i] == ' ' || ins->u.OPER.assem[i] == '.');

        if((ins->u.OPER.assem[i-2] == 'e' && ins->u.OPER.assem[i-1] == 'q')
        || (ins->u.OPER.assem[i-2] == 'n' && ins->u.OPER.assem[i-1] == 'e')
        || (ins->u.OPER.assem[i-2] == 'l' && ins->u.OPER.assem[i-1] == 't')
        || (ins->u.OPER.assem[i-2] == 'g' && ins->u.OPER.assem[i-1] == 't')
        || (ins->u.OPER.assem[i-2] == 'l' && ins->u.OPER.assem[i-1] == 'e')
        || (ins->u.OPER.assem[i-2] == 'g' && ins->u.OPER.assem[i-1] == 'e')
        || (ins->u.OPER.assem[i-2] == 'c' && ins->u.OPER.assem[i-1] == 's')
        || (ins->u.OPER.assem[i-2] == 'p' && ins->u.OPER.assem[i-1] == 'l')){
            if(ins->u.OPER.assem[0] == 'b' && ins->u.OPER.assem[1] == 'i' && ins->u.OPER.assem[2] == 'c' && ins->u.OPER.assem[3] == 's'){
                return false;
            }else{
                return true;
            }
        }

    }else if(ins->kind == AS_instr_::I_MOVE){
        int len = strlen(ins->u.MOVE.assem);
        int i=0;
        for(; i<len; ++i){
            if(ins->u.MOVE.assem[i] == ' ' || ins->u.MOVE.assem[i] == '.'){
                break;
            }
        }

        assert(ins->u.MOVE.assem[i] == ' ' || ins->u.MOVE.assem[i] == '.');

        if((ins->u.MOVE.assem[i-2] == 'e' && ins->u.MOVE.assem[i-1] == 'q')
        || (ins->u.MOVE.assem[i-2] == 'n' && ins->u.MOVE.assem[i-1] == 'e')
        || (ins->u.MOVE.assem[i-2] == 'l' && ins->u.MOVE.assem[i-1] == 't')
        || (ins->u.MOVE.assem[i-2] == 'g' && ins->u.MOVE.assem[i-1] == 't')
        || (ins->u.MOVE.assem[i-2] == 'l' && ins->u.MOVE.assem[i-1] == 'e')
        || (ins->u.MOVE.assem[i-2] == 'g' && ins->u.MOVE.assem[i-1] == 'e')
        || (ins->u.OPER.assem[i-2] == 'c' && ins->u.OPER.assem[i-1] == 's')
        || (ins->u.OPER.assem[i-2] == 'p' && ins->u.OPER.assem[i-1] == 'l')){
            return true;
        }
        
    }

    return false;
}

static bool isS(AS_instr ins){
    std::string cond;
    if(ins->kind == AS_instr_::I_OPER){
        int len = strlen(ins->u.OPER.assem);
        int i=0;
        for(; i<len; ++i){
            if(ins->u.OPER.assem[i] == ' ' || ins->u.OPER.assem[i] == '.'){
                break;
            }
        }

        assert(ins->u.OPER.assem[i] == ' ' || ins->u.OPER.assem[i] == '.');

        if(ins->u.OPER.assem[i-1] == 's'){
            return true;
        }
    }
    return false;
}

static bool UDFlagSpecial(AS_instr ins){
    if(ins->kind == AS_instr_::I_OPER){
        if(!strcmp(ins->u.OPER.assem, "rsbs `d0, `s0, #0")
        || !strcmp(ins->u.OPER.assem, "rsbpl `d0, `s0, #0")
        || !strcmp(ins->u.OPER.assem, "bics `d0, `s0, `s1, asr #32")
        || !strcmp(ins->u.OPER.assem, "movcs `d0, `s0")){
            return true;
        }else{
            return false;
        }
    }else{
        return false;
    }
}

static bool isUDFlag(AS_instr ins){
    if(ins->kind == AS_instr_::I_OPER){
        if(ins->u.OPER.assem[0] == 'c' && ins->u.OPER.assem[1] == 'm' && ins->u.OPER.assem[2] == 'p'
        || ins->u.OPER.assem[0] == 'v' && ins->u.OPER.assem[1] == 'c' && ins->u.OPER.assem[2] == 'm' && ins->u.OPER.assem[3] == 'p'
        || ins->u.OPER.assem[0] == 'b' && ins->u.OPER.assem[1] == 'l'){
            return true;
        }
    }
    if(isCond(ins) || isS(ins) || UDFlagSpecial(ins)){
        return true;
    }else{
        return false;
    }
}

static bool isDFlag(AS_instr ins){
    if(ins->kind == AS_instr_::I_OPER){
        if(ins->u.OPER.assem[0] == 'c' && ins->u.OPER.assem[1] == 'm' && ins->u.OPER.assem[2] == 'p'
        || ins->u.OPER.assem[0] == 'v' && ins->u.OPER.assem[1] == 'c' && ins->u.OPER.assem[2] == 'm' && ins->u.OPER.assem[3] == 'p'
        || ins->u.OPER.assem[0] == 'b' && ins->u.OPER.assem[1] == 'l'){
            return true;
        }
    }
    if(isS(ins) || UDFlagSpecial(ins)){
        return true;
    }else{
        return false;
    }
}

static bool isCall(AS_instr ins){
    if(ins->kind == AS_instr_::I_OPER){
        if(ins->u.OPER.assem[0] == 'b' && ins->u.OPER.assem[1] == 'l'){
            return true;
        }else{
            return false;
        }
    }else{
        return false;
    }
}

// data dependency graph
// key is ins
// value is edge set (to other ins (key should after the ins in edge set))
static unordered_map<AS_instr, unordered_set<AS_instr>> DDG;

// reversed data dependency graph
static unordered_map<AS_instr, unordered_set<AS_instr>> RDDG;

// key is temp num
// value is the last ins def this temp
static unordered_map<int, AS_instr> LastDef;

// key is temp num
// value is ins that use the temp after last define
static unordered_map<int, unordered_set<AS_instr>> ActiveUse;

static AS_instr LastMemAccess;

// the last ins def cmp's flag reg
static AS_instr LastFlagDef;

// LastCall and ActiveMemAccess is dependent
// cause call may modify memory
static AS_instr LastCall;
// ActiveMemAccess is MemAccess ins between two call
static unordered_set<AS_instr> ActiveMemAccess;

void buildDDG(AS_instrList il){
    
    DDG.clear();
    RDDG.clear();
    LastDef.clear();
    ActiveUse.clear();
    ActiveMemAccess.clear();
    LastMemAccess = nullptr;
    LastFlagDef = nullptr;
    LastCall = nullptr;

    for(AS_instrList til=il; til; til=til->tail){
        AS_instr this_instr = til->head;
        if(this_instr->kind == AS_instr_::I_LABEL){
            continue;
        }else{
            // 1. add edge by use temps
            // and by def temps
            // use to last def
            Temp_tempList useList = getTempList(GetSrc(this_instr));
            for(Temp_tempList ttl=useList; ttl; ttl=ttl->tail){
                if(LastDef.find(ttl->head->num) != LastDef.end()){
                    AS_instr lastDefIns = LastDef.find(ttl->head->num)->second;
                    DDG[this_instr].emplace(lastDefIns);
                    RDDG[lastDefIns].emplace(this_instr);
                }
            }
            // def to last def and active use
            Temp_tempList defList = getTempList(GetDst(this_instr));
            for(Temp_tempList ttl=defList; ttl; ttl=ttl->tail){
                if(LastDef.find(ttl->head->num) != LastDef.end()){
                    AS_instr lastDefIns = LastDef.find(ttl->head->num)->second;
                    DDG[this_instr].emplace(lastDefIns);
                    RDDG[lastDefIns].emplace(this_instr);
                }
                if(ActiveUse.find(ttl->head->num) != ActiveUse.end()){
                    for(auto &it : ActiveUse.find(ttl->head->num)->second){
                        DDG[this_instr].emplace(it);
                        RDDG[it].emplace(this_instr);
                    }
                }
            }
            // 2. if this_instr access memory
            // add edge by LastMemAccess and lastCall
            if(isMemAccess(this_instr)){
                if(LastMemAccess){
                    DDG[this_instr].emplace(LastMemAccess);
                    RDDG[LastMemAccess].emplace(this_instr);
                }
                if(LastCall){
                    DDG[this_instr].emplace(LastCall);
                    RDDG[LastCall].emplace(this_instr);
                }
            }
            // 3. if this_instr use or def flag reg
            // add edge by LastFlagDef
            if(isUDFlag(this_instr) && LastFlagDef){
                DDG[this_instr].emplace(LastFlagDef);
                RDDG[LastFlagDef].emplace(this_instr);
            }
            // 4. if this_instr is Call
            // add edge by ActiveMemAccess and lastCall
            if(isCall(this_instr)){
                for(auto &it : ActiveMemAccess){
                    DDG[this_instr].emplace(it);
                    RDDG[it].emplace(this_instr);
                }
                if(LastCall){
                    DDG[this_instr].emplace(LastCall);
                    RDDG[LastCall].emplace(this_instr);
                }
            }
            // 5. update LastFlagDef and LastMemAccess and LastDef and ActiveUse
            // and LastCall and ActiveMemAccess
            if(isDFlag(this_instr)){
                LastFlagDef = this_instr;
            }
            if(isMemAccess(this_instr)){
                LastMemAccess = this_instr;
                ActiveMemAccess.emplace(this_instr);
            }
            if(isCall(this_instr)){
                LastCall = this_instr;
                ActiveMemAccess.clear();
            }
            for(Temp_tempList ttl=useList; ttl; ttl=ttl->tail){
                ActiveUse[ttl->head->num].emplace(this_instr);
            }
            for(Temp_tempList ttl=defList; ttl; ttl=ttl->tail){
                LastDef[ttl->head->num] = this_instr;
                if(ActiveUse.find(ttl->head->num) != ActiveUse.end()){
                    ActiveUse[ttl->head->num].clear();
                }
            }
        }
    }
}

void dumpDDG(AS_instrList il){
    for(AS_instrList til=il; til; til=til->tail){
        printf("\t");
        AS_print(stdout, til->head, Temp_name());
        printf("\tdepend:\n");
        if(DDG.find(til->head) != DDG.end()){
            unordered_set<AS_instr> edgeSet = DDG.find(til->head)->second;
            for(auto &it1 : edgeSet){
                printf("\t\t");
                AS_print(stdout, it1, Temp_name());
            }
        }else{
            printf("\t\t(nil)\n");
        }
        printf("\tenddepend:\n");
    }
}

static inline bool isRetrun(AS_instr ins){
	if(ins->kind == AS_instr_::I_OPER
	&& !strcmp(ins->u.OPER.assem, "pop {`d0, `d1}")){
		return true;
	}else{
		return false;
	}
}

static inline bool isEntry(AS_instr ins){
	if(ins->kind == AS_instr_::I_OPER
	&& !strcmp(ins->u.OPER.assem, "push {`s0, `s1}")){
		return true;
	}else{
		return false;
	}
}

static inline bool isGpStr(AS_instr ins){
	if(ins->kind == AS_instr_::I_OPER){
        if(ins->u.OPER.assem[0] == 's' 
        && ins->u.OPER.assem[1] == 't' 
        && ins->u.OPER.assem[2] == 'r'){
		    return true;
        }else{
            return false;
        }
	}else{
		return false;
	}
}

static inline bool isStr(AS_instr ins){
	if(ins->kind == AS_instr_::I_OPER){
        if(ins->u.OPER.assem[0] == 's' 
        && ins->u.OPER.assem[1] == 't' 
        && ins->u.OPER.assem[2] == 'r'){
		    return true;
        }else if(ins->u.OPER.assem[0] == 'v' 
        && ins->u.OPER.assem[1] == 's' 
        && ins->u.OPER.assem[2] == 't'
        && ins->u.OPER.assem[3] == 'r'){
            return true;
        }else{
            return false;
        }
	}else{
		return false;
	}
}

static inline bool isGpLdr(AS_instr ins){
	if(ins->kind == AS_instr_::I_OPER){
        if(ins->u.OPER.assem[0] == 'l' 
        && ins->u.OPER.assem[1] == 'd' 
        && ins->u.OPER.assem[2] == 'r'){
		    return true;
        }else{
            return false;
        }
	}else{
		return false;
	}
}

static inline bool isLdr(AS_instr ins){
	if(ins->kind == AS_instr_::I_OPER){
        if(ins->u.OPER.assem[0] == 'l' 
        && ins->u.OPER.assem[1] == 'd' 
        && ins->u.OPER.assem[2] == 'r'){
		    return true;
        }else if(ins->u.OPER.assem[0] == 'v' 
        && ins->u.OPER.assem[1] == 'l' 
        && ins->u.OPER.assem[2] == 'd'
        && ins->u.OPER.assem[3] == 'r'){
            return true;
        }else{
            return false;
        }
	}else{
		return false;
	}
}

static inline bool addrSame(AS_instr strIns, AS_instr ldrIns){
    assert(isStr(strIns)); 
    assert(isLdr(ldrIns));
    AS_operandList strSrcList = GetSrc(strIns);
    AS_operandList ldrSrcList = GetSrc(ldrIns);
    AS_operandList strAddr = strSrcList->tail;
    AS_operandList ldrAddr = ldrSrcList;
    for(; strAddr && ldrAddr; strAddr=strAddr->tail, ldrAddr=ldrAddr->tail){
        if(strAddr->head->kind == AS_operand_::T_TEMP 
        && ldrAddr->head->kind == AS_operand_::T_TEMP){
            if(strAddr->head->u.TEMP->num == ldrAddr->head->u.TEMP->num){
                continue;
            }else{
                return false;
            }
        }else if(strAddr->head->kind == AS_operand_::T_ICONST 
        && ldrAddr->head->kind == AS_operand_::T_ICONST){
            if(strAddr->head->u.ICONST == ldrAddr->head->u.ICONST){
                continue;
            }else{
                return false;
            }
        }else{
            return false;
        }
    }
    if(strAddr || ldrAddr){
        return false;
    }else{
        return true;
    }
}

static inline bool addrSame_color(AS_instr strIns, AS_instr ldrIns){
    assert(isStr(strIns)); 
    assert(isLdr(ldrIns));
    AS_operandList strSrcList = GetSrc(strIns);
    AS_operandList ldrSrcList = GetSrc(ldrIns);
    AS_operandList strAddr = strSrcList->tail;
    AS_operandList ldrAddr = ldrSrcList;
    for(; strAddr && ldrAddr; strAddr=strAddr->tail, ldrAddr=ldrAddr->tail){
        if(strAddr->head->kind == AS_operand_::T_TEMP 
        && ldrAddr->head->kind == AS_operand_::T_TEMP){
            assert(strAddr->head->u.TEMP->color != -1);
            assert(ldrAddr->head->u.TEMP->color != -1);
            if(strAddr->head->u.TEMP->color == ldrAddr->head->u.TEMP->color){
                continue;
            }else{
                return false;
            }
        }else if(strAddr->head->kind == AS_operand_::T_ICONST 
        && ldrAddr->head->kind == AS_operand_::T_ICONST){
            if(strAddr->head->u.ICONST == ldrAddr->head->u.ICONST){
                continue;
            }else{
                return false;
            }
        }else{
            return false;
        }
    }
    if(strAddr || ldrAddr){
        return false;
    }else{
        return true;
    }
}

static inline bool isVmov(AS_instr ins){
    // only do Oper type
	if(ins->kind == AS_instr_::I_OPER){
        if(ins->u.OPER.assem[0] == 'v' 
        && ins->u.OPER.assem[1] == 'm' 
        && ins->u.OPER.assem[2] == 'o'
        && ins->u.OPER.assem[3] == 'v'){
            return true;
        }else{
            return false;
        }
	}else{
		return false;
	}
}

static inline bool isPrecolor(int num){
	return num < 100;
}

static AS_instr tryPick(AS_instr top_ins, 
                    TempSet BBInSet, 
                    TempSet BBOutSet, 
                    unordered_map<int, AS_instr>& defIns, 
                    set<pair<int, AS_instr>>& readyIns,
                    unordered_map<AS_instr, int>& upsideValMap){
    if(!isRetrun(top_ins)){
        Temp_tempList useList = getTempList(GetSrc(top_ins));
        for(Temp_tempList ttl=useList; ttl; ttl=ttl->tail){
            if(BBInSet->find(ttl->head) == BBInSet->end() 
            && BBOutSet->find(ttl->head) == BBOutSet->end()){
            // neither live in nor live out
                if(defIns.find(ttl->head->num) != defIns.end()){
                    // find the def ins
                    AS_instr candidate = defIns.find(ttl->head->num)->second;
                    if(readyIns.find(make_pair(upsideValMap.find(candidate)->second, candidate)) != readyIns.end()){
                    // def ins is ready
                        return candidate;
                    }
                }
            }
        }
        return nullptr;
    }else{
        return nullptr;
    }
}

static void tryPipelineMov(AS_instr last_top_ins, AS_instr top_ins){
    if((!last_top_ins) || (!top_ins)){
        return;
    }
    if((!(last_top_ins->kind == AS_instr_::I_MOVE)) || (!(top_ins->kind == AS_instr_::I_MOVE))){
        return;
    }
    // both ins are mov
    assert(last_top_ins->u.MOVE.src && last_top_ins->u.MOVE.src->head->kind == AS_operand_::T_TEMP);
    assert(top_ins->u.MOVE.src && top_ins->u.MOVE.src->head->kind == AS_operand_::T_TEMP);
    if(last_top_ins->u.MOVE.src->head->u.TEMP->num == top_ins->u.MOVE.src->head->u.TEMP->num){
        // if src are same, then modify to pipeline mov
        last_top_ins->u.MOVE.src->head->u.TEMP = top_ins->u.MOVE.dst->head->u.TEMP;
    }else{
        // src are not same, do nothing
        ;
    }
}

AS_instrList scheduleIns(AS_instrList il){
    assert(il->head->kind == AS_instr_::I_LABEL);

    AS_instr label_ins = il->head;
    Temp_label label = label_ins->u.LABEL.label;
    TempSet BBInSet = BB_In(label);
    TempSet BBOutSet = BB_Out(label);
    AS_instr last_ins = nullptr;

    // pair->first is upside value
    // pair->seccond is ins
    // begin is the most upside ins (upside value is minimum)
    set<pair<int, AS_instr>> readyIns;

    unordered_map<AS_instr, int> upsideValMap;

    unordered_map<int, AS_instr> defIns;

    // skip the first ins(i.e. the label)
    // calculate upside value for every ins
    // and init the readyIns set
    for(AS_instrList til=il->tail; til; til=til->tail){
        AS_instr this_instr = til->head;
        assert(this_instr->kind != AS_instr_::I_LABEL);
        last_ins = this_instr;

        // calculate upside value for every ins
        int upsideVal = 0;
        Temp_tempList useList = getTempList(GetSrc(this_instr));
        for(Temp_tempList ttl=useList; ttl; ttl=ttl->tail){
            if(BBInSet->find(ttl->head) != BBInSet->end() && BBOutSet->find(ttl->head) == BBOutSet->end()){
                // live in but not live out
                // should move up
                upsideVal++;
            }else if(BBOutSet->find(ttl->head) != BBOutSet->end() && BBInSet->find(ttl->head) == BBInSet->end()){
                // live out but not live in
                // should move down
                upsideVal--;
            }else{
                // if both live in and live out
                // no need to move
                // if neither live in nor live out
                // put them together
                ;
            }
        }
        Temp_tempList defList = getTempList(GetDst(this_instr));
        for(Temp_tempList ttl=defList; ttl; ttl=ttl->tail){
            if(BBInSet->find(ttl->head) != BBInSet->end() && BBOutSet->find(ttl->head) == BBOutSet->end()){
                upsideVal++;
            }else if(BBOutSet->find(ttl->head) != BBOutSet->end() && BBInSet->find(ttl->head) == BBInSet->end()){
                upsideVal--;
            }else{
                ;
            }
            if(!isPrecolor(ttl->head->num)){
                // printf("here\n");
                // printf("temp num %d\n", ttl->head->num);
                // AS_print(stdout, this_instr, Temp_name());
                
                // assert(defIns.emplace(ttl->head->num, this_instr).second);
                defIns[ttl->head->num] = this_instr;
            }
        }

        upsideValMap.emplace(this_instr, upsideVal);
        
        // init the readyIns set
        if(RDDG.find(this_instr) == RDDG.end()){
            assert(upsideValMap.find(this_instr) != upsideValMap.end());
            readyIns.emplace(upsideValMap.find(this_instr)->second, this_instr);
        }else{
            assert(!RDDG.find(til->head)->second.empty());
        }
    }

    assert(last_ins);
    // last_ins must in readyIns
    assert(readyIns.find(make_pair(upsideValMap.find(last_ins)->second, last_ins)) != readyIns.end());

    // if last_ins is return or second_ins is push
    // do not schedule (cause it may destory callee reg's save and recover)
    if(isRetrun(last_ins) || isEntry(il->tail->head)){
        return il;
    }

    // schedule from last_ins (cause last_ins is pinned)
    AS_instr last_top_ins = nullptr;
    AS_instr top_ins = last_ins;
    AS_instr candidate = nullptr;
    AS_instrList sil = AS_InstrList(top_ins, nullptr);
    readyIns.erase(make_pair(upsideValMap.find(top_ins)->second, top_ins));

    // delte ins from DDG (and RDDG) 
    // and update readyIns (delete top_ins and add new ready ins)
    if(DDG.find(top_ins) != DDG.end()){
        for(auto &it : DDG.find(top_ins)->second){
            assert(RDDG.find(it)->second.erase(top_ins));
            if(RDDG.find(it)->second.empty()){
                readyIns.emplace(upsideValMap.find(it)->second, it);
            }
        }
        assert(DDG.erase(top_ins));
    }
    
    
    while(!readyIns.empty()){
        last_top_ins = top_ins;

        candidate = tryPick(top_ins, BBInSet, BBOutSet, defIns, readyIns, upsideValMap);
        if(!candidate){
            top_ins = readyIns.begin()->second;
        }else{
            top_ins = candidate;
        }

        tryPipelineMov(last_top_ins, top_ins);
        sil = AS_InstrList(top_ins, sil);
        readyIns.erase(make_pair(upsideValMap.find(top_ins)->second, top_ins));

        // delte ins from DDG (and RDDG) 
        // and update readyIns (delete top_ins and add new ready ins)
        if(DDG.find(top_ins) != DDG.end()){
            for(auto &it : DDG.find(top_ins)->second){
                assert(RDDG.find(it)->second.erase(top_ins));
                if(RDDG.find(it)->second.empty()){
                    readyIns.emplace(upsideValMap.find(it)->second, it);
                }
            }
            assert(DDG.erase(top_ins));
        }
    }

    // do not forget the label
    sil = AS_InstrList(label_ins, sil);
    return sil;
}


static unordered_map<AS_instr, TempSet> InBBLiveOut;

static void makeInBBLiveOut(AS_instrList il){
    assert(il->head->kind == AS_instr_::I_LABEL);
    AS_instr label_ins = il->head;
    Temp_label label = label_ins->u.LABEL.label;
    TempSet BBInSet = BB_In(label);
    TempSet BBOutSet = BB_Out(label);
    InBBLiveOut.clear();

    TempSet_ liveOut = *BBOutSet;

    std::stack<AS_instr> workSet;
    for(AS_instrList tl=il; tl; tl=tl->tail){
        workSet.push(tl->head);
    }

    while(!workSet.empty()){
        AS_instr down_ins = workSet.top();
        workSet.pop();
        TempSet down_liveout = new TempSet_;
        *down_liveout = liveOut;
        InBBLiveOut.emplace(down_ins, down_liveout);
        
        Temp_tempList defList = getTempList(GetDst(down_ins));
        for(Temp_tempList ttl=defList; ttl; ttl=ttl->tail){
            liveOut.erase(ttl->head);
        }
        Temp_tempList useList = getTempList(GetSrc(down_ins));
        for(Temp_tempList ttl=useList; ttl; ttl=ttl->tail){
            liveOut.emplace(ttl->head);
        }
    }
}

void dumpInBBLiveOut(AS_instrList il){
    for(AS_instrList til=il; til; til=til->tail){
        AS_print(stdout, til->head, Temp_name());
        printf("live out:\n");
        assert(InBBLiveOut.find(til->head) != InBBLiveOut.end());
        TempSet ts = InBBLiveOut.find(til->head)->second;
        for(auto &it1 : *ts){
            printf("%d ", it1->num);
        }
        printf("\nend live out\n");
    }
}

static bool isRedundantMoveUse(AS_instr movIns, AS_instr useIns){
    if((!movIns) || (!useIns)){
        return false;
    }
    if(movIns->kind != AS_instr_::I_MOVE){
        return false;
    }
    assert(movIns->u.MOVE.dst);
    assert(!movIns->u.MOVE.dst->tail);

    // printf("isRedundantMoveUse\n");
    // AS_print(stdout, movIns, Temp_name());
    // printf("movdst %d\n", movIns->u.MOVE.dst->head->u.TEMP->num);
    // AS_print(stdout, useIns, Temp_name());
    // printf("usesrcList: ");
    // printTempList(getTempList(GetSrc(useIns)));

    assert(movIns->u.MOVE.dst->head->kind == AS_operand_::T_TEMP);
    Temp_temp movdst = movIns->u.MOVE.dst->head->u.TEMP;
    TempSet useInsLiveOut = InBBLiveOut.find(useIns)->second;
    if(useInsLiveOut->find(movdst) == useInsLiveOut->end()
    && TempList_contains(getTempList(GetSrc(useIns)), movdst)){
        // movdst not live out at useIns
        // and movdst in useIns's useList
        return true;
    }else{
        return false;
    }
}

static void optRedundantMoveUse(AS_instrList il, AS_instrList *prev, AS_instrList *curr, AS_instrList *next){
    // curr->head is movIns
    // next->head is useIns
    AS_instr movIns = (*curr)->head;
    AS_instr useIns = (*next)->head;

    // printf("opt:\n");
    // AS_print(stdout, movIns, Temp_name());
    // AS_print(stdout, useIns, Temp_name());

    assert(movIns->kind == AS_instr_::I_MOVE);
    assert(movIns->u.MOVE.src);
    assert(!movIns->u.MOVE.src->tail);
    assert(movIns->u.MOVE.src->head->kind == AS_operand_::T_TEMP);
    Temp_temp movsrc = movIns->u.MOVE.src->head->u.TEMP;
    assert(movIns->u.MOVE.dst);
    assert(!movIns->u.MOVE.dst->tail);
    assert(movIns->u.MOVE.dst->head->kind == AS_operand_::T_TEMP);
    Temp_temp movdst = movIns->u.MOVE.dst->head->u.TEMP;

    AS_Opl_replace_temp(GetSrc(useIns), movdst, movsrc);
    // remove movIns
    il = AS_instrList_replace_opt(il, prev, curr, nullptr);
}

static bool isRedundantDefMove(AS_instr defIns, AS_instr movIns){
    if((!defIns) || (!movIns)){
        return false;
    }
    if(movIns->kind != AS_instr_::I_MOVE){
        return false;
    }
    AS_operandList defOpList = GetDst(defIns);
    if(!(defOpList && !defOpList->tail)){
        // not single define
        return false;
    }
    assert(defOpList->head->kind == AS_operand_::T_TEMP);
    Temp_temp defdst = defOpList->head->u.TEMP;

    TempSet movInsLiveOut = InBBLiveOut.find(movIns)->second;
    if(movInsLiveOut->find(defdst) == movInsLiveOut->end()
    && TempList_contains(getTempList(GetSrc(movIns)), defdst)){
        // defdst not live out at movIns
        // and defdst in movIns's useList
        return true;
    }else{
        return false;
    }
}

static void optRedundantDefMove(AS_instrList il, AS_instrList *prev, AS_instrList *curr, AS_instrList *next){
    // curr->head is defIns
    // next->head is movIns
    AS_instr defIns = (*curr)->head;
    AS_instr movIns = (*next)->head;

    // printf("opt:\n");
    // AS_print(stdout, defIns, Temp_name());
    // AS_print(stdout, movIns, Temp_name());

    assert(movIns->kind == AS_instr_::I_MOVE);
    assert(movIns->u.MOVE.src);
    assert(!movIns->u.MOVE.src->tail);
    assert(movIns->u.MOVE.src->head->kind == AS_operand_::T_TEMP);
    Temp_temp movsrc = movIns->u.MOVE.src->head->u.TEMP;
    assert(movIns->u.MOVE.dst);
    assert(!movIns->u.MOVE.dst->tail);
    assert(movIns->u.MOVE.dst->head->kind == AS_operand_::T_TEMP);
    Temp_temp movdst = movIns->u.MOVE.dst->head->u.TEMP;

    AS_Opl_replace_temp(GetDst(defIns), movsrc, movdst);
    // remove movIns
    il = AS_instrList_replace_opt(il, curr, next, nullptr);
}

static bool isAddZero(AS_instr addIns){
    if(!addIns){
        return false;
    }
    if(addIns->kind != AS_instr_::I_OPER){
        return false;
    }
    if((!addIns->u.OPER.src) || (!addIns->u.OPER.src->tail)){
        return false;
    }

    if(addIns->u.OPER.assem[0] == 'a'
    && addIns->u.OPER.assem[1] == 'd'
    && addIns->u.OPER.assem[2] == 'd'
    && addIns->u.OPER.src->tail->head->kind == AS_operand_::T_ICONST
    && addIns->u.OPER.src->tail->head->u.ICONST == 0){
        return true;
    }else{
        return false;
    }
}

static void optAddZero(AS_instrList il, AS_instrList *prev, AS_instrList *curr){
    // curr->head is movIns
    AS_instr addIns = (*curr)->head;

    // printf("optSelfMove_color\n");
    // printf("prev %p prev->tail %p curr %p \n", *prev, (*prev)->tail, *curr);
    // printf("opt:\n");
    // AS_print(stdout, addIns, Temp_name());

    assert(addIns->u.OPER.src->head->kind == AS_operand_::T_TEMP);
    AS_operand addSrc1 = addIns->u.OPER.src->head;
    AS_operand addDst = addIns->u.OPER.dst->head;
    // addIns to mov
    int loopDepth = addIns->nest_depth;
    AS_instr movIns = AS_Move((string) "mov `d0, `s0", AS_OperandList(addDst, NULL), AS_OperandList(addSrc1, NULL), loopDepth);
    (*curr)->head = movIns;
}

static bool isSubZero(AS_instr subIns){
    if(!subIns){
        return false;
    }
    if(subIns->kind != AS_instr_::I_OPER){
        return false;
    }
    if((!subIns->u.OPER.src) || (!subIns->u.OPER.src->tail)){
        return false;
    }

    if(subIns->u.OPER.assem[0] == 's'
    && subIns->u.OPER.assem[1] == 'u'
    && subIns->u.OPER.assem[2] == 'b'
    && subIns->u.OPER.src->tail->head->kind == AS_operand_::T_ICONST
    && subIns->u.OPER.src->tail->head->u.ICONST == 0){
        return true;
    }else{
        return false;
    }
}

static void optSubZero(AS_instrList il, AS_instrList *prev, AS_instrList *curr){
    // curr->head is movIns
    AS_instr subIns = (*curr)->head;

    // printf("optSelfMove_color\n");
    // printf("prev %p prev->tail %p curr %p \n", *prev, (*prev)->tail, *curr);
    // printf("opt:\n");
    // AS_print(stdout, subIns, Temp_name());

    assert(subIns->u.OPER.src->head->kind == AS_operand_::T_TEMP);
    AS_operand subSrc1 = subIns->u.OPER.src->head;
    AS_operand subDst = subIns->u.OPER.dst->head;
    // subIns to mov
    int loopDepth = subIns->nest_depth;
    AS_instr movIns = AS_Move((string) "mov `d0, `s0", AS_OperandList(subDst, NULL), AS_OperandList(subSrc1, NULL), loopDepth);
    (*curr)->head = movIns;
}

static bool isRedundantLdr(AS_instr strIns, AS_instr ldrIns){
    if((!strIns) || (!ldrIns)){
        return false;
    }
    if((!isStr(strIns)) || (!isLdr(ldrIns))){
        return false;
    }
    if(addrSame(strIns, ldrIns)){
        return true;
    }else{
        return false;
    }
}

static void optRedundantLdr(AS_instrList il, AS_instrList *prev, AS_instrList *curr, AS_instrList *next){
    // curr->head is strIns
    // next->head is ldrIns
    AS_instr strIns = (*curr)->head;
    AS_instr ldrIns = (*next)->head;

    // printf("opt:\n");
    // AS_print(stdout, strIns, Temp_name());
    // AS_print(stdout, ldrIns, Temp_name());

    AS_operand strSrc = strIns->u.OPER.src->head;
    AS_operand ldrDst = ldrIns->u.OPER.dst->head;

    // modify ldrIns to move
    AS_instr movIns = nullptr;
    int loopDepth = strIns->nest_depth;
    assert(ldrDst->kind == AS_operand_::T_TEMP);
    if(ldrDst->u.TEMP->type == FLOAT_TEMP){
        movIns = AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(ldrDst, NULL), AS_OperandList(strSrc, NULL), loopDepth);
    }else{
        movIns = AS_Move((string) "mov `d0, `s0", AS_OperandList(ldrDst, NULL), AS_OperandList(strSrc, NULL), loopDepth);
    }
    (*next)->head = movIns;
    // remove ldrIns
    // il = AS_instrList_replace_opt(il, curr, next, nullptr);
}

// you should call makeBBInOut first
void insCombine(AS_instrList il){
    // this function do not use liveness infomation now
    // makeInBBLiveOut(il);
    // dumpInBBLiveOut(il);
    AS_instrList prev = nullptr;
    AS_instrList til = nullptr;
    AS_instrList next = il;
    for(; next; prev=til, til=next,next=next->tail){
        if(!til){
            continue;
        }else if(isAddZero(til->head)){
            optAddZero(il, &prev, &til);
        }else if(isSubZero(til->head)){
            optSubZero(il, &prev, &til);
        }else if(isRedundantLdr(til->head, next->head)){
            optRedundantLdr(il, &prev, &til, &next);
        }

        // adjust these pointer
        if(next == til){
            next = next->tail;
        }
        if(prev == til){
            til = next;
            next = next->tail;
        }
    }
}


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

static bool isRedundantMoveUse_color(AS_instr movIns, AS_instr useIns){
    if((!movIns) || (!useIns)){
        return false;
    }
    if(movIns->kind != AS_instr_::I_MOVE){
        return false;
    }
    if(isCall(useIns) || isCond(useIns)){
        return false;
    }
    assert(movIns->u.MOVE.dst);
    assert(!movIns->u.MOVE.dst->tail);

    // printf("isRedundantMoveUse\n");
    // AS_print(stdout, movIns, Temp_name());
    // printf("movdst %d\n", movIns->u.MOVE.dst->head->u.TEMP->num);
    // AS_print(stdout, useIns, Temp_name());
    // printf("usesrcList: ");
    // printTempList(getTempList(GetSrc(useIns)));

    assert(movIns->u.MOVE.dst->head->kind == AS_operand_::T_TEMP);
    Temp_temp movdst = movIns->u.MOVE.dst->head->u.TEMP;
    // RegSet useInsLiveOut = InBBLiveOut_color.find(useIns)->second;
    RegSet useInsLiveOut = getInsLiveOut(useIns);
    if(useInsLiveOut->find(movdst->color) == useInsLiveOut->end()
    && TempList_contains_color(getTempList(GetSrc(useIns)), movdst)){
        // movdst not live out at useIns
        // and movdst in useIns's useList
        return true;
    }else{
        return false;
    }
}

static void optRedundantMoveUse_color(AS_instrList il, AS_instrList *prev, AS_instrList *curr, AS_instrList *next){
    // curr->head is movIns
    // next->head is useIns
    AS_instr movIns = (*curr)->head;
    AS_instr useIns = (*next)->head;

    // printf("opt:\n");
    // AS_print(stdout, movIns, Temp_name());
    // AS_print(stdout, useIns, Temp_name());

    assert(movIns->kind == AS_instr_::I_MOVE);
    assert(movIns->u.MOVE.src);
    assert(!movIns->u.MOVE.src->tail);
    assert(movIns->u.MOVE.src->head->kind == AS_operand_::T_TEMP);
    Temp_temp movsrc = movIns->u.MOVE.src->head->u.TEMP;
    assert(movIns->u.MOVE.dst);
    assert(!movIns->u.MOVE.dst->tail);
    assert(movIns->u.MOVE.dst->head->kind == AS_operand_::T_TEMP);
    Temp_temp movdst = movIns->u.MOVE.dst->head->u.TEMP;

    AS_Opl_replace_color(GetSrc(useIns), movdst, movsrc);
    // remove movIns
    il = AS_instrList_replace_opt(il, prev, curr, nullptr);
}

static bool isRedundantDefMove_color(AS_instr defIns, AS_instr movIns){
    if((!defIns) || (!movIns)){
        return false;
    }
    if(movIns->kind != AS_instr_::I_MOVE){
        return false;
    }
    if(isCall(defIns) || isCond(defIns)){
        return false;
    }
    AS_operandList defOpList = GetDst(defIns);
    if(!(defOpList && !defOpList->tail)){
        // not single define
        return false;
    }
    assert(defOpList->head->kind == AS_operand_::T_TEMP);
    Temp_temp defdst = defOpList->head->u.TEMP;

    // RegSet movInsLiveOut = InBBLiveOut_color.find(movIns)->second;
    RegSet movInsLiveOut = getInsLiveOut(movIns);
    if(movInsLiveOut->find(defdst->color) == movInsLiveOut->end()
    && TempList_contains_color(getTempList(GetSrc(movIns)), defdst)){
        // defdst not live out at movIns
        // and defdst in movIns's useList
        return true;
    }else{
        return false;
    }
}

static void optRedundantDefMove_color(AS_instrList il, AS_instrList *prev, AS_instrList *curr, AS_instrList *next){
    // curr->head is defIns
    // next->head is movIns
    AS_instr defIns = (*curr)->head;
    AS_instr movIns = (*next)->head;

    // printf("opt:\n");
    // AS_print(stdout, defIns, Temp_name());
    // AS_print(stdout, movIns, Temp_name());

    assert(movIns->kind == AS_instr_::I_MOVE);
    assert(movIns->u.MOVE.src);
    assert(!movIns->u.MOVE.src->tail);
    assert(movIns->u.MOVE.src->head->kind == AS_operand_::T_TEMP);
    Temp_temp movsrc = movIns->u.MOVE.src->head->u.TEMP;
    assert(movIns->u.MOVE.dst);
    assert(!movIns->u.MOVE.dst->tail);
    assert(movIns->u.MOVE.dst->head->kind == AS_operand_::T_TEMP);
    Temp_temp movdst = movIns->u.MOVE.dst->head->u.TEMP;

    AS_Opl_replace_color(GetDst(defIns), movsrc, movdst);
    // remove movIns
    il = AS_instrList_replace_opt(il, curr, next, nullptr);
}

static bool isSelfMove_color(AS_instr movIns){
    if(!movIns){
        return false;
    }
    if(movIns->kind != AS_instr_::I_MOVE){
        return false;
    }

    assert(movIns->kind == AS_instr_::I_MOVE);
    assert(movIns->u.MOVE.src);
    assert(!movIns->u.MOVE.src->tail);
    assert(movIns->u.MOVE.src->head->kind == AS_operand_::T_TEMP);
    Temp_temp movsrc = movIns->u.MOVE.src->head->u.TEMP;
    assert(movIns->u.MOVE.dst);
    assert(!movIns->u.MOVE.dst->tail);
    assert(movIns->u.MOVE.dst->head->kind == AS_operand_::T_TEMP);
    Temp_temp movdst = movIns->u.MOVE.dst->head->u.TEMP;

    assert(movsrc->color != -1);
    assert(movdst->color != -1);
    return movsrc->color == movdst->color;
}

static void optSelfMove_color(AS_instrList il, AS_instrList *prev, AS_instrList *curr){
    // curr->head is movIns
    AS_instr movIns = (*curr)->head;

    // printf("optSelfMove_color\n");
    // printf("prev %p prev->tail %p curr %p \n", *prev, (*prev)->tail, *curr);
    // printf("opt:\n");
    // AS_print(stdout, movIns, Temp_name());

    assert(movIns->kind == AS_instr_::I_MOVE);
    assert(movIns->u.MOVE.src);
    assert(!movIns->u.MOVE.src->tail);
    assert(movIns->u.MOVE.src->head->kind == AS_operand_::T_TEMP);
    Temp_temp movsrc = movIns->u.MOVE.src->head->u.TEMP;
    assert(movIns->u.MOVE.dst);
    assert(!movIns->u.MOVE.dst->tail);
    assert(movIns->u.MOVE.dst->head->kind == AS_operand_::T_TEMP);
    Temp_temp movdst = movIns->u.MOVE.dst->head->u.TEMP;
    // remove movIns
    il = AS_instrList_replace_opt(il, prev, curr, nullptr);
}

static bool isRedundantLdr_color(AS_instr strIns, AS_instr ldrIns){
    if((!strIns) || (!ldrIns)){
        return false;
    }
    if((!isStr(strIns)) || (!isLdr(ldrIns))){
        return false;
    }
    if(addrSame_color(strIns, ldrIns)){
        return true;
    }else{
        return false;
    }
}

static void optRedundantLdr_color(AS_instrList il, AS_instrList *prev, AS_instrList *curr, AS_instrList *next){
    // curr->head is strIns
    // next->head is ldrIns
    AS_instr strIns = (*curr)->head;
    AS_instr ldrIns = (*next)->head;

    // printf("opt:\n");
    // AS_print(stdout, strIns, Temp_name());
    // AS_print(stdout, ldrIns, Temp_name());

    AS_operand strSrc = strIns->u.OPER.src->head;
    AS_operand ldrDst = ldrIns->u.OPER.dst->head;

    // modify ldrIns to move
    AS_instr movIns = nullptr;
    int loopDepth = strIns->nest_depth;
    assert(ldrDst->kind == AS_operand_::T_TEMP);
    if(ldrDst->u.TEMP->type == FLOAT_TEMP){
        movIns = AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(ldrDst, NULL), AS_OperandList(strSrc, NULL), loopDepth);
    }else{
        movIns = AS_Move((string) "mov `d0, `s0", AS_OperandList(ldrDst, NULL), AS_OperandList(strSrc, NULL), loopDepth);
    }
    (*next)->head = movIns;
    // remove ldrIns
    // il = AS_instrList_replace_opt(il, curr, next, nullptr);
}

static bool isRedundantVmovVmov_color(AS_instr vmov1, AS_instr vmov2){
    if((!vmov1) || (!vmov2)){
        return false;
    }
    if((!isVmov(vmov1)) || (!isVmov(vmov2))){
        return false;
    }

    AS_operand mov1Src = vmov1->u.OPER.src->head;
    AS_operand mov1Dst = vmov1->u.OPER.dst->head;
    AS_operand mov2Src = vmov2->u.OPER.src->head;
    AS_operand mov2Dst = vmov2->u.OPER.dst->head;

    assert(mov1Dst->u.TEMP->color != -1);
    assert(mov2Src->u.TEMP->color != -1);

    if(isFloat(mov1Dst) && isFloat(mov2Src) && (!isFloat(mov1Src)) && (!isFloat(mov2Dst))
    && mov1Dst->u.TEMP->color == mov2Src->u.TEMP->color){
        return true;
    }else{
        return false;
    }
}

static void optRedundantVmovVmov_color(AS_instrList il, AS_instrList *prev, AS_instrList *curr, AS_instrList *next){
    // here opt vmov for spill
    // I do not know if fp for spill is live 
    // (cause this instr not exsit when do liveness)
    // curr->head is vmov1
    // next->head is vmov2
    AS_instr vmov1 = (*curr)->head;
    AS_instr vmov2 = (*next)->head;

    // printf("opt:\n");
    // AS_print_colored(stdout, vmov1, Temp_name());
    // AS_print_colored(stdout, vmov2, Temp_name());

    AS_operand mov1Src = vmov1->u.OPER.src->head;
    AS_operand mov1Dst = vmov1->u.OPER.dst->head;
    AS_operand mov2Src = vmov2->u.OPER.src->head;
    AS_operand mov2Dst = vmov2->u.OPER.dst->head;

    int loopDepth = vmov1->nest_depth;
    assert(mov2Dst->kind == AS_operand_::T_TEMP);
    assert(mov1Src->kind == AS_operand_::T_TEMP);
    assert(mov2Dst->u.TEMP->type != FLOAT_TEMP);

    // mov1Dst live out at vmov2
    // modify vmov2 to move
    AS_instr movIns = AS_Move((string) "mov `d0, `s0", AS_OperandList(mov2Dst, NULL), AS_OperandList(mov1Src, NULL), loopDepth);
    (*next)->head = movIns;
    
}

static bool isRedundantMovMov_color(AS_instr mov1, AS_instr mov2){
    if((!mov1) || (!mov2)){
        return false;
    }
    if((!(mov1->kind == AS_instr_::I_MOVE)) 
    || (!(mov2->kind == AS_instr_::I_MOVE))){
        return false;
    }

    AS_operand mov1Src = mov1->u.OPER.src->head;
    AS_operand mov1Dst = mov1->u.OPER.dst->head;
    AS_operand mov2Src = mov2->u.OPER.src->head;
    AS_operand mov2Dst = mov2->u.OPER.dst->head;

    assert(mov1Dst->u.TEMP->color != -1);
    assert(mov2Src->u.TEMP->color != -1);

    if((((!isFloat(mov1Dst)) && (!isFloat(mov2Src)) && (!isFloat(mov1Src)) && (!isFloat(mov2Dst)))
        || (isFloat(mov1Dst) && isFloat(mov2Src) && isFloat(mov1Src) && isFloat(mov2Dst)))
    && mov1Dst->u.TEMP->color == mov2Src->u.TEMP->color){
        return true;
    }else{
        return false;
    }
}

static void optRedundantMovMov_color(AS_instrList il, AS_instrList *prev, AS_instrList *curr, AS_instrList *next){
    // curr->head is mov1
    // next->head is mov2
    AS_instr mov1 = (*curr)->head;
    AS_instr mov2 = (*next)->head;

    // printf("opt:\n");
    // AS_print_colored(stdout, mov1, Temp_name());
    // AS_print_colored(stdout, mov2, Temp_name());

    AS_operand mov1Src = mov1->u.OPER.src->head;
    AS_operand mov1Dst = mov1->u.OPER.dst->head;
    AS_operand mov2Src = mov2->u.OPER.src->head;
    AS_operand mov2Dst = mov2->u.OPER.dst->head;

    int loopDepth = mov1->nest_depth;
    assert(mov2Dst->kind == AS_operand_::T_TEMP);
    assert(mov1Src->kind == AS_operand_::T_TEMP);
    assert(mov2Dst->u.TEMP->type != FLOAT_TEMP);

    RegSet mov2LiveOut = getInsLiveOut(mov2);
    if(mov2LiveOut->find(mov1Dst->u.TEMP->color) == mov2LiveOut->end()){
        // mov1Dst not live out at mov2
        // modify mov1
        AS_instr movIns = nullptr;
        if(isFloat(mov2Dst)){
            movIns = AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(mov2Dst, NULL), AS_OperandList(mov1Src, NULL), loopDepth);
        }else{
            movIns = AS_Move((string) "mov `d0, `s0", AS_OperandList(mov2Dst, NULL), AS_OperandList(mov1Src, NULL), loopDepth);
        }
        
        (*curr)->head = movIns;
        // remove mov2
        il = AS_instrList_replace_opt(il, curr, next, nullptr);
    }else{
        // mov1Dst live out at mov2
        // modify mov2 src to mov1 src (may opt by other pattern)
        AS_instr movIns = nullptr;
        if(isFloat(mov2Dst)){
            movIns = AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(mov2Dst, NULL), AS_OperandList(mov1Src, NULL), loopDepth);
        }else{
            movIns = AS_Move((string) "mov `d0, `s0", AS_OperandList(mov2Dst, NULL), AS_OperandList(mov1Src, NULL), loopDepth);
        }
        (*next)->head = movIns;
    }    
}

static bool isAddZero_color(AS_instr addIns){
    if(!addIns){
        return false;
    }
    if(addIns->kind != AS_instr_::I_OPER){
        return false;
    }
    if((!addIns->u.OPER.src) || (!addIns->u.OPER.src->tail)){
        return false;
    }

    if(addIns->u.OPER.assem[0] == 'a'
    && addIns->u.OPER.assem[1] == 'd'
    && addIns->u.OPER.assem[2] == 'd'
    && addIns->u.OPER.src->tail->head->kind == AS_operand_::T_ICONST
    && addIns->u.OPER.src->tail->head->u.ICONST == 0){
        return true;
    }else{
        return false;
    }
}

static void optAddZero_color(AS_instrList il, AS_instrList *prev, AS_instrList *curr){
    // curr->head is movIns
    AS_instr addIns = (*curr)->head;

    // printf("optSelfMove_color\n");
    // printf("prev %p prev->tail %p curr %p \n", *prev, (*prev)->tail, *curr);
    // printf("opt:\n");
    // AS_print(stdout, addIns, Temp_name());

    assert(addIns->u.OPER.src->head->kind == AS_operand_::T_TEMP);
    AS_operand addSrc1 = addIns->u.OPER.src->head;
    AS_operand addDst = addIns->u.OPER.dst->head;
    // addIns to mov
    int loopDepth = addIns->nest_depth;
    AS_instr movIns = AS_Move((string) "mov `d0, `s0", AS_OperandList(addDst, NULL), AS_OperandList(addSrc1, NULL), loopDepth);
    (*curr)->head = movIns;
}

static bool isSubZero_color(AS_instr subIns){
    if(!subIns){
        return false;
    }
    if(subIns->kind != AS_instr_::I_OPER){
        return false;
    }
    if((!subIns->u.OPER.src) || (!subIns->u.OPER.src->tail)){
        return false;
    }

    if(subIns->u.OPER.assem[0] == 's'
    && subIns->u.OPER.assem[1] == 'u'
    && subIns->u.OPER.assem[2] == 'b'
    && subIns->u.OPER.src->tail->head->kind == AS_operand_::T_ICONST
    && subIns->u.OPER.src->tail->head->u.ICONST == 0){
        return true;
    }else{
        return false;
    }
}

static void optSubZero_color(AS_instrList il, AS_instrList *prev, AS_instrList *curr){
    // curr->head is movIns
    AS_instr subIns = (*curr)->head;

    // printf("optSelfMove_color\n");
    // printf("prev %p prev->tail %p curr %p \n", *prev, (*prev)->tail, *curr);
    // printf("opt:\n");
    // AS_print(stdout, subIns, Temp_name());

    assert(subIns->u.OPER.src->head->kind == AS_operand_::T_TEMP);
    AS_operand subSrc1 = subIns->u.OPER.src->head;
    AS_operand subDst = subIns->u.OPER.dst->head;
    // subIns to mov
    int loopDepth = subIns->nest_depth;
    AS_instr movIns = AS_Move((string) "mov `d0, `s0", AS_OperandList(subDst, NULL), AS_OperandList(subSrc1, NULL), loopDepth);
    (*curr)->head = movIns;
}

static bool isMul_color(AS_instr mulIns){
    if(!mulIns){
        return false;
    }
    if(mulIns->kind != AS_instr_::I_OPER){
        return false;
    }
    if((!mulIns->u.OPER.src) || (!mulIns->u.OPER.src->tail)){
        return false;
    }

    if(mulIns->u.OPER.assem[0] == 'm'
    && mulIns->u.OPER.assem[1] == 'u'
    && mulIns->u.OPER.assem[2] == 'l'){
        return true;
    }else{
        return false;
    }
}

static bool isAddReg_color(AS_instr addIns){
    if(!addIns){
        return false;
    }
    if(addIns->kind != AS_instr_::I_OPER){
        return false;
    }
    if((!addIns->u.OPER.src) || (addIns->u.OPER.src->head->kind != AS_operand_::T_TEMP) 
    || (!addIns->u.OPER.src->tail) || (addIns->u.OPER.src->tail->head->kind != AS_operand_::T_TEMP)){
        return false;
    }

    if(!strcmp(addIns->u.OPER.assem, "add `d0, `s0, `s1")){
        return true;
    }else{
        return false;
    }
}

static bool isMulAdd_color(AS_instr mulIns, AS_instr addIns){
    if((!mulIns) || (!addIns)){
        return false;
    }
    
    if(isMul_color(mulIns) && isAddReg_color(addIns)){
        return true;
    }else{
        return false;
    }
}

static void optMulAdd_color(AS_instrList il, AS_instrList *prev, AS_instrList *curr, AS_instrList *next){
    // curr->head is mulIns
    // next->head is addIns
    AS_instr mulIns = (*curr)->head;
    AS_instr addIns = (*next)->head;

    // printf("opt:\n");
    // AS_print_colored(stdout, vmov1, Temp_name());
    // AS_print_colored(stdout, vmov2, Temp_name());

    AS_operand mulSrc1 = mulIns->u.OPER.src->head;
    AS_operand mulSrc2 = mulIns->u.OPER.src->tail->head;
    AS_operand mulDst = mulIns->u.OPER.dst->head;
    AS_operand addSrc1 = addIns->u.OPER.src->head;
    AS_operand addSrc2 = addIns->u.OPER.src->tail->head;
    AS_operand addDst = addIns->u.OPER.dst->head;

    int loopDepth = mulIns->nest_depth;
    
    // muldst and addsrc is same
    // and muldst does not live out at add
    RegSet addInsLiveOut = getInsLiveOut(addIns);
    if(mulDst->u.TEMP->color == addSrc1->u.TEMP->color
    && addInsLiveOut->find(mulDst->u.TEMP->color) == addInsLiveOut->end()){
        AS_instr mlaIns = AS_Oper((string) "mla `d0, `s0, `s1, `s2", AS_OperandList(addDst, NULL), AS_OperandList(mulSrc1, AS_OperandList(mulSrc2, AS_OperandList(addSrc2, NULL))), NULL, loopDepth);
        // modify mul to mla
        (*curr)->head = mlaIns;
        // remove addIns
        il = AS_instrList_replace_opt(il, curr, next, nullptr);
    }else if(mulDst->u.TEMP->color == addSrc2->u.TEMP->color
    && addInsLiveOut->find(mulDst->u.TEMP->color) == addInsLiveOut->end()){
        AS_instr mlaIns = AS_Oper((string) "mla `d0, `s0, `s1, `s2", AS_OperandList(addDst, NULL), AS_OperandList(mulSrc1, AS_OperandList(mulSrc2, AS_OperandList(addSrc1, NULL))), NULL, loopDepth);
        // modify mul to mla
        (*curr)->head = mlaIns;
        // remove addIns
        il = AS_instrList_replace_opt(il, curr, next, nullptr);
    }else{
        // do nothing
        ;
    }
}

static bool isDoubleStr_color(AS_instr str1, AS_instr str2){
    if((!str1) || (!str2)){
        return false;
    }

    if((!isGpStr(str1)) || (!isGpStr(str2))){
        return false;
    }

    AS_operand str1Src1 = str1->u.OPER.src->head;
    AS_operand str1Src2 = str1->u.OPER.src->tail->head;
    AS_operand str1Src3 = str1->u.OPER.src->tail->tail->head;
    AS_operand str2Src1 = str2->u.OPER.src->head;
    AS_operand str2Src2 = str2->u.OPER.src->tail->head;
    AS_operand str2Src3 = str2->u.OPER.src->tail->tail->head;

    if(str1Src1->u.TEMP->color == str2Src1->u.TEMP->color-1
    && (str1Src2->u.TEMP->color == str2Src2->u.TEMP->color && str1Src2->u.TEMP->color == 11)
    && (str1Src3->kind == AS_operand_::T_ICONST && str2Src3->kind == AS_operand_::T_ICONST && str1Src3->u.ICONST == str2Src3->u.ICONST-4)
    && abs(str1Src3->u.ICONST) <= 254){
        return true;
    }else{
        return false;
    }
}

static void optDoubleStr_color(AS_instrList il, AS_instrList *prev, AS_instrList *curr, AS_instrList *next){
    // curr->head is str1
    // next->head is str2
    AS_instr str1 = (*curr)->head;
    AS_instr str2 = (*next)->head;

    // printf("opt:\n");
    // AS_print_colored(stdout, vmov1, Temp_name());
    // AS_print_colored(stdout, vmov2, Temp_name());

    AS_operand str1Src1 = str1->u.OPER.src->head;
    AS_operand str2Src1 = str2->u.OPER.src->head;
    AS_operand str1Src2 = str1->u.OPER.src->tail->head;
    AS_operand str2Src2 = str2->u.OPER.src->tail->head;
    AS_operand str1Src3 = str1->u.OPER.src->tail->tail->head;
    AS_operand str2Src3 = str2->u.OPER.src->tail->tail->head;

    int loopDepth = str1->nest_depth;
    
    assert((str1Src2->u.TEMP->color == str2Src2->u.TEMP->color && str1Src2->u.TEMP->color == 11));
    assert((str1Src3->kind == AS_operand_::T_ICONST && str2Src3->kind == AS_operand_::T_ICONST && str1Src3->u.ICONST == str2Src3->u.ICONST-4));

    AS_instr strdIns = AS_Oper((string)"strd `s0, [`s1, `s2]", NULL, AS_OperandList(str1Src1, AS_OperandList(str1Src2, AS_OperandList(str1Src3, AS_OperandList(str2Src1, NULL)))), NULL, loopDepth);
    // modify str1 to strd
    (*curr)->head = strdIns;
    // remove str2
    il = AS_instrList_replace_opt(il, curr, next, nullptr);
}

static bool isDoubleLdr_color(AS_instr ldr1, AS_instr ldr2){
    if((!ldr1) || (!ldr2)){
        return false;
    }

    if((!isGpLdr(ldr1)) || (!isGpLdr(ldr2))){
        return false;
    }

    AS_operand ldr1Dst = ldr1->u.OPER.dst->head;
    AS_operand ldr1Src1 = ldr1->u.OPER.src->head;
    AS_operand ldr1Src2 = ldr1->u.OPER.src->tail->head;
    AS_operand ldr2Dst = ldr2->u.OPER.dst->head;
    AS_operand ldr2Src1 = ldr2->u.OPER.src->head;
    AS_operand ldr2Src2 = ldr2->u.OPER.src->tail->head;

    if(ldr1Dst->u.TEMP->color == ldr2Dst->u.TEMP->color-1
    && (ldr1Src1->u.TEMP->color == ldr2Src1->u.TEMP->color && ldr1Src1->u.TEMP->color == 11)
    && (ldr1Src2->kind == AS_operand_::T_ICONST && ldr2Src2->kind == AS_operand_::T_ICONST && ldr1Src2->u.ICONST == ldr2Src2->u.ICONST-4)
    && abs(ldr1Src2->u.ICONST) <= 254){
        return true;
    }else{
        return false;
    }
}

static void optDoubleLdr_color(AS_instrList il, AS_instrList *prev, AS_instrList *curr, AS_instrList *next){
    // curr->head is ldr1
    // next->head is ldr2
    AS_instr ldr1 = (*curr)->head;
    AS_instr ldr2 = (*next)->head;

    // printf("opt:\n");
    // AS_print_colored(stdout, vmov1, Temp_name());
    // AS_print_colored(stdout, vmov2, Temp_name());

    AS_operand ldr1Dst = ldr1->u.OPER.dst->head;
    AS_operand ldr1Src1 = ldr1->u.OPER.src->head;
    AS_operand ldr1Src2 = ldr1->u.OPER.src->tail->head;
    AS_operand ldr2Dst = ldr2->u.OPER.dst->head;
    AS_operand ldr2Src1 = ldr2->u.OPER.src->head;
    AS_operand ldr2Src2 = ldr2->u.OPER.src->tail->head;

    int loopDepth = ldr1->nest_depth;
    
    assert((ldr1Src1->u.TEMP->color == ldr2Src1->u.TEMP->color && ldr1Src1->u.TEMP->color == 11));
    assert((ldr1Src2->kind == AS_operand_::T_ICONST && ldr2Src2->kind == AS_operand_::T_ICONST && ldr1Src2->u.ICONST == ldr2Src2->u.ICONST-4));

    AS_instr ldrdIns = AS_Oper((string)"ldrd `d0, [`s0, `s1]", AS_OperandList(ldr1Dst, AS_OperandList(ldr2Dst, NULL)), AS_OperandList(ldr1Src1, AS_OperandList(ldr1Src2, NULL)), NULL, loopDepth);
    // modify ldr1 to ldrd
    (*curr)->head = ldrdIns;
    // remove ldr2
    il = AS_instrList_replace_opt(il, curr, next, nullptr);
}


// you should call makeBBInOut first
void insCombine_color(AS_instrList il){
    // makeInBBLiveOut_color(il);
    // dumpInBBLiveOut_color(il);
    AS_instrList prev = nullptr;
    AS_instrList til = nullptr;
    AS_instrList next = il;
    for(; next; prev=til,til=next,next=next->tail){
        // can not do multi match
        // cause delete ins will crash
        // you should repeat some times
        if(!til){
            continue;
        }else if(isRedundantMoveUse_color(til->head, next->head)){
            optRedundantMoveUse_color(il, &prev, &til, &next);
        }else if(isRedundantDefMove_color(til->head, next->head)){
            optRedundantDefMove_color(il, &prev, &til, &next);
        }else if(isSelfMove_color(til->head)){
            optSelfMove_color(il, &prev, &til);
        }else if(isRedundantLdr_color(til->head, next->head)){
            optRedundantLdr_color(il, &prev, &til, &next);
        }else if(isRedundantVmovVmov_color(til->head, next->head)){
            optRedundantVmovVmov_color(il, &prev, &til, &next);
        }else if(isRedundantMovMov_color(til->head, next->head)){
            optRedundantMovMov_color(il, &prev, &til, &next);
        }else if(isMulAdd_color(til->head, next->head)){
            optMulAdd_color(il, &prev, &til, &next);
        }else if(isDoubleStr_color(til->head, next->head)){
            optDoubleStr_color(il, &prev, &til, &next);
        }else if(isDoubleLdr_color(til->head, next->head)){
            optDoubleLdr_color(il, &prev, &til, &next);
        }else if(isAddZero_color(til->head)){
            optAddZero_color(il, &prev, &til);
        }else if(isSubZero_color(til->head)){
            optSubZero_color(il, &prev, &til);
        }
        //TODO: other window size two ins opt

        // if(prev){
        //     printf("prev %p prev->tail %p curr %p next %p\n", prev, prev->tail, til, next);
        // }

        // adjust these pointer
        if(next == til){
            next = next->tail;
        }
        if(prev == til){
            til = next;
            next = next->tail;
        }
    }
}
