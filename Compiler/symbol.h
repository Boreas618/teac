/*
 * symbol.h - Symbols and symbol-tables
 *
 */

#ifndef __SYMBOL
#define __SYMBOL

#include "util.h"

typedef struct S_symbol_ *S_symbol;

/* Make a unique symbol from a given string.  
 *  Different calls to S_Symbol("foo") will yield the same S_symbol
 *  value, even if the "foo" strings are at different locations. */
S_symbol S_Symbol(my_string);

/* Extract the underlying string from a symbol */
string S_name(S_symbol);

/* S_table is a mapping from S_symbol->any, where "any" is represented
 *     here by void*  */
typedef struct TAB_table_ *S_table;

/* Make a new table */
S_table S_empty(void);

/* Enter a binding "sym->value" into "t", shadowing but not deleting
 *    any previous binding of "sym". */
void S_enter(S_table t, S_symbol sym, void *value);

/* Look up the most recent binding of "sym" in "t", or return NULL
 *    if sym is unbound. */
void *S_look(S_table t, S_symbol sym);

/* Start a new "scope" in "t".  Scopes are nested. */
void S_beginScope(S_table t);

/* Remove any bindings entered since the current scope began,
   and end the current scope. */
void S_endScope(S_table t);

void S_dump(S_table t, void (*show)(S_symbol sym, void *binding));

/* check_copy bindings from table from to table dest,
   using function check_copy. */
void S_check_copy_Var(void* out, S_table from, S_table dest, void(*check_copy)(void* out, void *key, void *value, S_table dest));

void S_check_copy_Method(void* out, S_table from, S_table dest, void *class_entry, void(*check_copy)(void* out, void *key, void *value, S_table dest, void *class_entry));

void S_modify_Varoffset(void* out, S_table t, int *offset, void(*modify_offset)(void* out, void *key, void *value, int *offset));

void S_modify_Methodoffset(void* out, S_table parent_table, S_table child_table, int *offset, void(*modify_offset)(void* out, void *key, void *value, int *offset, S_table parent_table));


#endif
