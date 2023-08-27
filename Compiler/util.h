#ifndef _UTIL
#define _UTIL

// #include <assert.h>
// #include "treep.hpp"

#include <cstddef>
#define RESEVED_REG 40
#define REG_SIZE 4
#define ALLOCATION_INFO 0
#define INTRINSIC
#undef INTRINSIC

typedef char *string;
typedef char *my_string;
typedef char Bool;

#define TRUE 1
#define FALSE 0
#define MAX(a, b) ((a) > (b) ? (a) : (b))

void *checked_malloc(int);
string String(char *);
string String(const char *);
string Stringcat(char *a, char *b);
string makeASTfilename(const char *a);
string makeIRPfilename(const char *a);
string makeSTMfilename(const char *a);
string makeLIVfilename(const char *a);
string makeLLVMfilename(const char *a);
string makeARMfilename(const char *a);
string StringLabel(char *s);
string StringLabel_arm(char *s);
void Stringbrk(const char* raw, char **pa, char **pb);

typedef struct U_boolList_ *U_boolList;
struct U_boolList_ {Bool head; U_boolList tail;};
U_boolList U_BoolList(Bool head, U_boolList tail);


#define Stmax 105

typedef struct Stack{
    void* s[Stmax+1];
    int top;
}Stack;

void* Stpop(Stack*);
void* Sttop(Stack*);
void Stpush(Stack*, void*);
Bool Stempty(Stack*);
Bool Stfull(Stack*);
void Stinit(Stack*);

#define LStmax 10005

typedef struct LStack{
    void* s[LStmax+1];
    int top;
}LStack;

void* LStpop(LStack*);
void* LSttop(LStack*);
void LStpush(LStack*, void*);
Bool LStempty(LStack*);
Bool LStfull(LStack*);
void LStinit(LStack*);


// #define offset_of(type, member) ((unsigned long long)(&((type*)NULL)->member))
// assume `mptr` is a pointer to `member` inside struct `type`, this
// macro returns the pointer to the "container" struct `type`.
//
// this is useful for lists. We often embed a `ListNode` inside a struct:
//
// > typedef struct {
// >     u64 data;
// >     ListNode node;
// > } Container;
// > Container a;
// > ListNode b = &a.node;
//
// then `container_of(b, Container, node)` will be the same as `&a`.
// #define container_of(mptr, type, member) \
//     ({ \
//         const typeof(((type*)NULL)->member)* _mptr = (mptr); \
//         (type*)((char*)_mptr - offset_of(type, member)); \
//     })

template <typename T, typename M>
constexpr ptrdiff_t offset_of(M T::*member) {
    return reinterpret_cast<ptrdiff_t>(&(((T*)0)->*member));
}

#define container_of(mptr, type, member) \
    (reinterpret_cast<type*>((char*)(mptr) - offset_of(&type::member)))

string gen_edge_key(int u_num, int v_num);
void get_edge_by_key(const char *key, int *u_num, int *v_num);
string gen_ptr_key(void *p);
void *str_to_ptr(char* key);

void cat_used_memory();

#endif
