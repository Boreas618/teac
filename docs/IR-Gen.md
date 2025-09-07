# 从 AST 到 LLVM IR 的生成过程

> 本系列博客旨在记录复旦大学 COMP130014 《编译》课程中，关于 [Teapl 语言](https://github.com/hxuhack/course_compiler/tree/main/teapl) 编译器的相关设计思考与实现。该编译器名为 Teaplc-rs，使用 Rust 编写，参考了 LLVM 等成熟开源编译器的实现方式，并作为本课程实验部分的框架代码。

本文将首先梳理 Clang 编译器从 AST（Abstract Syntax Tree）生成 LLVM IR（Intermediate Representation）的整体流程，随后对比分析 Teaplc-rs 在该阶段的实现与 Clang 的异同，并探讨 Teaplc-rs 在从 AST 到 LLVM IR 转换过程中的设计思想与实现细节。

## Clang 从 AST 生成 LLVM IR 的流程

Clang 从抽象语法树（AST）生成 LLVM IR 的核心在于 `CodeGen` 组件。该组件作为编译流程中的中间层，位于语义分析（`Sema`）和 LLVM 后端之间，负责将高级抽象的 AST 节点转化为底层、面向机器的中间表示（IR）。`CodeGen` 的核心类包括 `CodeGenModule` 和 `CodeGenFunction`，分别处理模块级和函数级的 IR 生成任务。

在编译过程中，Clang 通过如下代码创建并执行 `FrontendAction`。如果用户配置了只输出 LLVM IR 的编译选项 `-S -emit-llvm`，对应的 `FrontendAction` 就是 `EmitLLVMOnlyAction`。

```c++
// clang/lib/FrontendTool/ExecuteCompilerInvocation.cpp: ExecuteCompilerInvocation 

// 创建并执行前端动作。
std::unique_ptr<FrontendAction> Act(CreateFrontendAction(*Clang));
if (!Act)
    return false;
bool Success = Clang->ExecuteAction(*Act);
```

`EmitLLVMOnlyAction` 是 `CodeGenAction` 的派生类（他们都是 `FrontendAction` 的派生类）。这里有一个非常巧妙的设计：Clang 中所有针对不同后端输出（如只生成 LLVM IR 的 `EmitLLVMOnlyAction`、生成汇编的 `EmitAssemblyAction` 等）的 `FrontendAction` 均派生自 `CodeGenAction`。这些派生类共享 `CodeGenAction` 的核心逻辑，唯一的区别在于其初始化基类 `CodeGenAction` 的 `Act` 参数不同。`CodeGenAction` 会根据该参数调整行为。这种集中式的设计带来了两个显著优势：

1. 避免了不同输出形式的生成逻辑散落在代码库的各个角落；
2. 使得通用逻辑得以集中管理，易于维护与拓展。

在 `CodeGenAction` 中，以下两个成员变量与 LLVM IR 的生成密切相关：

| 成员名      | 类型                            | 功能说明                                                     |
| ----------- | ------------------------------- | ------------------------------------------------------------ |
| `TheModule` | `std::unique_ptr<llvm::Module>` | 表示完整的 LLVM 模块，包含所有函数、全局变量等内容。由 `CodeGenModule` 负责构建并填充，是最终 IR 输出的主体。 |
| `VMContext` | `llvm::LLVMContext`             | 表示 LLVM 的上下文对象，用于管理类型、常量等全局状态。当多个模块共享同一个上下文时，可实现资源复用与线程安全。 |

上述核心逻辑主要在 `CodeGenAction::ExecuteAction` 中实现。我们主要关心其中 `EmitLLVMOnlyAction` 对应的逻辑，在此过程中，如果当前源文件不是 LLVM IR 文件（例如是 C/C++ 源码），`ExecuteAction` 仅调用基类 `ASTFrontendAction` 的实现：

```c++
if (getCurrentFileKind().getLanguage() != Language::LLVM_IR) {
    this->ASTFrontendAction::ExecuteAction();
    return;
}
```



// TODO



```
class CodeGenAction : public ASTFrontendAction
```

