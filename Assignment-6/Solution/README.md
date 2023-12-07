# 编译原理实验 LAB6 实验指南

`LAB6` 为两个主体部分：1️⃣ **指令选择**和 2️⃣ **寄存器分配**。

> 提醒：`LAB6` 与 `LAB5` **完全脱钩**，不使用 `SSA` 版本的 `LLVM IR` 。从架构上看，`LAB6` 在 `LAB4` 的基础上构建，并考虑到工作量进行**部分难度简化**。

## 指令选择
`LAB6` 的指令选择为**直接翻译**，在本篇文档内不涉及复杂的指令选择算法和优化。但是，课程参与者需要对 `LAB4` 翻译出的 `LLVM IR` 的数据结构以及 `LLVM IR` 的合法语法有清晰的认识，尤其是操作数的枚举。

> 我们翻译的目标机器为ARMv8-AArch64，实验环境在本篇文档最后给出。

## 翻译指南
在文件 `llvm_ir.h` 中定义了数据结构 `L_stm` 用于抽象 `LLVM IR` ：
```cpp
struct L_stm {
    L_StmKind type;
    union {
        L_binop *BINOP;
        L_load *LOAD;
        L_store *STORE;
        L_label *LABEL;
        L_jump *JUMP;
        L_cmp *CMP;
        L_cjump *CJUMP;
        L_move *MOVE;
        L_call *CALL;
        L_voidcall *VOID_CALL;
        L_ret *RET;
        L_phi *PHI;
        L_alloca *ALLOCA;
        L_gep *GEP;
    } u;
};
```

其中指令 `PHI`, `MOV` 在 `LAB4` 内无直接操作，在此不予考虑。自上而下，联合体中这些不同类型的域指针对应以下 `LLVM IR` 指令：

`add, sub, mul sdiv` `load` `store` `bb1: (label)` `icmp` `br` `call` `ret` `alloca` `getelementptr`

> 在 `ARMV8` 架构下，我们精心选择了最简单指令翻译方案，将以上 `LLVM IR` 指令翻译成 `ARM` 指令，实验可以直接使用我们给出的指令集合。在下文中，我们会给出每个指令的示例。

### ADD
`ADD` 指令的格式为：

`ADD 目的寄存器，操作数1，操作数2`

`ADD` 把两个操作数相加，将结果存放到 `目的寄存器`。`操作数1` 应是一个寄存器，`操作数2` 可以是一个寄存器，或一个立即数。

> 指令示例：
> ```x86
> ADD     R0，R1，R2        ； R0 = R1 + R2
> ADD     R0，R1，#256      ； R0 = R1 + 256
> ```

### SUB
`SUB` 指令的格式为：

`SUB 目的寄存器，操作数1，操作数2`

`SUB` 用于把 `操作数1` 减去 `操作数2` ，将结果存放到 `目的寄存器`。`操作数1` 应是一个寄存器，`操作数2` 可以是一个寄存器，或一个立即数。

> 指令示例：
> ```x86
> SUB     R0，R1，R2     ； R0 = R1 - R2
> SUB     R0，R1，#256   ； R0 = R1 - 256
> ```
### MUL
`MUL` 指令的格式为：

`MUL 目的寄存器，操作数1，操作数2`

`MUL` 将 `操作数1` 与 `操作数2` 相乘，把结果放置到 `目的寄存器`，其中，`操作数1` 和 `操作数2` 均为32位的有符号数或无符号数。

> 指令示例：
> ```x86
> MUL R0，R1，R2         ；R0 = R1 × R2
> ```
### SDIV
`SDIV` 指令的格式为：

`SDIV 目的寄存器，操作数1，操作数2`

`SDIV` 将 `操作数1` 与 `操作数2` 相除，把结果放置到 `目的寄存器`，其中，`操作数1` 和 `操作数2` 均为32位的有符号数（本实验不涉及无符号操作 `UDIV` ）。

> 指令示例：
> ```x86
> MUL R0，R1，R2         ；R0 = R1 × R2
> ```
### LDR
`LDR` 指令的格式为：

`LDR 目的寄存器，<存储器地址>`

`LDR` 从 `存储器` 中将一个 `32位字数据` 传送到 `目的寄存器中`。通常用于从存储器中读取32位的字数据到通用寄存器，然后对数据进行处理。

> 指令示例：
> ```x86
> LDR R0，[R1]           ；将存储器地址为R1的字数据读入寄存器R0
> ```
### STR
`STR` 指令的格式为：

`STR 源寄存器，<存储器地址>`

`STR` 从 `源寄存器` 中将一个 `32位字数据` 传送到 `存储器` 中。

> 指令示例：
> ```x86
> STR R0，[R1]            ；将R0中的字数据写入以R1为地址的存储器中
> ```
### B
`B` 指令的格式为：

`B{条件}  目标地址`

`B` 是最简单的跳转指令，一旦遇到 `B` 指令，ARM 处理器将立即跳转到给定的目标地址。

> 指令示例：
> ```x86
> B     Label             ；程序无条件跳转到标号Label处执行
> ```
### B.
`B.{条件}` 指令的格式为：

`B.{条件}  目标地址`

`B` 是有条件跳转，判断系统标志位满足条件后，跳转到给定标号处，条件包含 `EQ` `NE` `LT` `GT` `LE` `GE`。

> 指令示例：
> ```x86
> B.EQ  Label             ；系统标志位满足EQ，跳转到标号Label处执行
> ```
### CMP
`MOV` 指令的格式为：

`MOV 目的寄存器，源操作数`

`MOV` 从 `一个寄存器` 或将 `一个立即数` 加载到 `目的寄存器`。

> 指令示例：
> ```x86
> MOV R1，R0              ；将寄存器R0的值传送到寄存器R1
> MOV R1，#12             ；将立即数12传送到寄存器R1
> ```
### MOV
`MOV` 指令的格式为：

`MOV 目的寄存器，源操作数`

`MOV` 从 `一个寄存器` 或将 `一个立即数` 加载到 `目的寄存器`。

> 指令示例：
> ```x86
> MOV R1，R0              ；将寄存器R0的值传送到寄存器R1
> MOV R1，#12             ；将立即数12传送到寄存器R1
> ```
### ADPR
`adpr`
### LABEL
`ARMV8` 的 `LABEL` 和 `LLVM IR` 一致，这里不再赘述。

### BL/RET

## 实验代码的数据结构
### `asm\_arm.h & asm\_arm.cpp`
文件 `asm_arm.h` 涵盖了所有需要翻译的 `ARMV8` 指令的抽象定义，理论上此部分在实验过程中无需改动，我们对比较重要的定义处给予解释。

整体上，数据结构定义和使用上延续了 `LAB4` 的代码风格。

`AS_reg` 具有两个域，分别是寄存器编号和偏移量，抽象为所有的寄存器表示方法。

**【重要】：**

`reg > 0` 代表通用寄存器，`reg=1 -> x1`, 指令翻译出的寄存器都是虚拟寄存器 `reg>=100` ，和 `LLVM IR` 保持一致。

`reg = -3` 代表立即数，此时 `offset` 代表立即数大小，`reg = -3, offset = 1 => #1`

`reg = -3` 代表 `sp` 保存的栈上地址内存，此时 `offset` 代表偏移，`reg = -1, offset=1 => [sp, #1]`
```cpp
struct AS_reg {
    int reg;
    int offset;
    AS_reg(int _reg, int _offset);
};
```

`AS_label` 是汇编代码内标签的抽闲，只储存一个 `string` 作为 `label` 名称。
```cpp
struct AS_label {
    std::string name;
    AS_label(const std::string _name);
};
```

`AS_global` 是汇编代码内全局变量的抽象，在全局有一个 `label` 作为标签，同时对于 `int` 类型，存储初始化的整型值（缺省为 `0` ），对于数组或结构体，全部初始化为 `0` 。
```cpp
struct AS_global {
    AS_label *label;
    int init;
    int len;
    AS_global(AS_label *_label, int _init, int _len);
};
```

`AS_binop` 是汇编代码内二元运算符的抽象，存储两个操作数，同时保存一个枚举类型 `AS_binopkind ` 决定具体使用哪个二元运算符。
```cpp
struct AS_binop {
    AS_binopkind op;
    AS_reg *left, *right, *dst;
    AS_binop(AS_binopkind _op, AS_reg *_left, AS_reg *_right, AS_reg *_dst);
};
```

类似的，`AS_bcond` 是汇编代码内有条件跳转的抽象，存储一个跳转地址，同时保存一个枚举类型 `AS_relopkind` 决定具体使用哪个判断条件。
```cpp
struct AS_bcond {
    AS_relopkind op;
    AS_label *jump;
    AS_bcond(AS_relopkind _op, AS_label *_jump);
};
```

其他的指令都大同小异，这里不再赘述。

`AS_stm` 是汇编代码内每条语句的抽象，存储了一个语句的枚举类型和对应的指针。
```cpp
struct AS_stm {
    AS_stmkind type;
    union {
        AS_binop *BINOP;
        AS_mov *MOV;
        AS_ldr *LDR;
        AS_str *STR;
        AS_adrp *ADRP;
        AS_label *LABEL;
        AS_b *B;
        AS_bcond *BCOND;
        AS_bl *BL;
        AS_cmp *CMP;
        AS_ret *RET;
    } u;
};
```

在代码中，我们封装了一些构造语句的函数，例如 `AS_Binop` ，这个函数调用 `AS_binop` 的构造函数，然后返回一个 `AS_stm*` 指针（注意函数名的大小写区别）。
```cpp
AS_stm* AS_Binop(AS_binopkind op, AS_reg* left, AS_reg *right, AS_reg *dst);
AS_stm* AS_Mov(AS_reg *src, AS_reg *dst);
```

对于 `ARMV8` 函数，一个函数 `AS_func` 由语句 `AS_stm* ` 的 `list` 组成。
```cpp
struct AS_func {
    std::list<AS_stm*> stms;
    AS_func(const std::list<AS_stm*> &stms);
};
```

对于 `ARMV8` 程序，一个程序 `AS_prog` 由一系列函数 `AS_func` 和一系列全局变量构成 `AS_global* ` 的 `vector` 组成。
```cpp
struct AS_prog {
    std::vector<AS_global*> globals;
    std::vector<AS_func*> funcs;
    AS_prog(const std::vector<AS_global*> &_globals, const std::vector<AS_func*> &_funcs);
};
```

### `printASM.h & printASM.cpp`
在文件 `printASM.h` 中定义了需要打印 `ARMV8 ASM` 的函数，`printASM.cpp` 部分的函数体需要参与实验的同学自己补充完整。
```cpp
namespace ASM
{
    void printAS_global(std::ostream &os, ASM::AS_global *global);
    void printAS_stm(std::ostream &os, ASM::AS_stm *stm);
    void printAS_reg(std::ostream &os, ASM::AS_reg *reg);
    void printAS_func(std::ostream &os, ASM::AS_func *func);
    void printAS_prog(std::ostream &os, ASM::AS_prog *prog);
}
```
在帮助文档中，我们给出函数 `ASM::printAS_global` 的实现范例，课程参与者可依据范例实现其他内容，工作量在 `150 loc` 左右。
```cpp
// @b = global [ 2 x i32 ] zeroinitializer
// b:
//        .word   0
//        .word   0
//        .word   0
void ASM::printAS_global(std::ostream &os, ASM::AS_global *global) {
    os << global->label->name << ":\n";
    for (int i = 0; i < global->len; i++) {
        os << "        .word   " << global->init << "\n";
    }
}
```

### `llvm2asm.h & llvm2asm.cpp`
在 `llvm2asm.cpp` 内，实现了完整的翻译任务，对于每个语句的翻译流程，我们在此处给出提示。

以下定义对应将不同种语句翻译，从 `LLVM IR` 至 `AMRV8ASM` :
```cpp
void llvm2asmBinop(list<AS_stm*> &as_list, L_stm* binop_stm);
void llvm2asmLoad(list<AS_stm*> &as_list, L_stm* load_stm);
void llvm2asmStore(list<AS_stm*> &as_list, L_stm* store_stm);
void llvm2asmCmp(list<AS_stm*> &as_list, L_stm* cmp_stm);
void llvm2asmVoidCall(list<AS_stm*> &as_list, L_stm* call_stm);
void llvm2asmCall(list<AS_stm*> &as_list, L_stm* call_stm);
void llvm2asmRet(list<AS_stm*> &as_list, L_stm* ret_stm);
void llvm2asmGep(list<AS_stm*> &as_list, L_stm* gep_stm);
void llvm2asmStm(list<AS_stm*> &as_list, L_stm &stm);
void llvm2asmGlobal(vector<AS_global*> &globals, L_def &def);
```
---- 
对于整个程序，我们需要翻译 `LLVM IR` 的一系列声明和函数体。
```cpp
AS_func* llvm2asmFunc(L_func &func);
AS_prog* llvm2asm(L_prog &p);
```
---- 
全局变量 `stack_frame` 记录了一个函数的栈大小，需要对每个函数处理独立计算，**ARM 中 SP 申请的空间一定是 16byte 的倍数，需要一次性遍历一个函数体的 alloca 指令后，计算所需的SP大小**。
```cpp
static int stack_frame;
```
---- 
映射 `spOffsetMap` 记录了所有栈上变量的映射，例如 `x100 -> 48`, 本质上对应的是 `x100 -> [sp + #48]` 的内存位置。这个结构需要记录所有 `alloca` 分配的寄存器位置，同时也需要记录可以通过计算获得的偏移地址，例如通过 `getelementptr` 获得的偏移后的地址。

**难度降低 1: 所有的索引访问都为常数类型，即不存在`a[n]`的情况**
```cpp
static unordered_map<int, int> spOffsetMap;
```
---- 
映射 `condMap` 记录了 `icmp` 的 `目的操作数` 和他下一个语句中 `跳转条件` 的 pair，因为翻译到 `ASM` 的过程中，我们不需要存 `icmp` 的返回值，仅需要通过`b.{状态}` 就可以完成跳转。
```cpp
static unordered_map<int, AS_relopkind> condMap;
```
---- 
映射 `structLayout`，记录了一个结构题的静态大小，即占用多大空间。

**难度降低 2: 所有结构的体的定义，每个域只有整形，不考虑数组和嵌套定义**
```cpp
static unordered_map<string, int> structLayout;
```
---- 
提示：在 `LLVM IR` 中，左右操作数都可能为立即数。但对于汇编指令，加法和减法，左操作数不能为立即数；乘法和除法，右操作数不能是立即数。

**难度降低 3: `LAB6` 预留了`x2` `x3` 两个寄存器来暂存立即数。**
```cpp
void llvm2asmBinop(list<AS_stm*> &as_list, L_stm* binop_stm) 
```
---- 
提示：`load` 的 源操作数存在三种可能：存储在栈上的直接地址 `[sp + #N]`， 存储在寄存器中 `%rn` ，以及全局变量 `@a` 。
```cpp
void llvm2asmLoad(list<AS_stm*> &as_list, L_stm* load_stm) 
```
---- 
提示：`store` 的 源操作数存在三种可能：立即数 `#N`， 存储在寄存器中 `%rn` 。目的操作数请课程实验同学自行思考。
```cpp
void llvm2asmStore(list<AS_stm*> &as_list, L_stm* store_stm)
```
---- 
提示：在 `LLVM IR` 中，操作数都可能为立即数。但对于汇编指令，操作数必须在寄存器内。这个操作需要记录返回的寄存器对应的跳转条件。
```cpp
void llvm2asmCmp(list<AS_stm*> &as_list, L_stm* cmp_stm)
```
---- 
**实验内最复杂的指令翻译**。
提示：需要考虑对象是结构题数组、整形数组还是普通结构体。

对于数组需要考虑索引的大小以及单个成员占的空间，对于结构体还要考虑具体是哪个域。

同时，也要考虑源操作数指针是哪种类型，包含全局变量、栈上变量还是寄存器。
```cpp
void llvm2asmGep(list<AS_stm*> &as_list, L_stm* gep_stm)
```
