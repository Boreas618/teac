# 实验三：类型检查

### 实验介绍

在生成AST后，对程序进行类型检查。这次实验需要做的只是类型检查，程序运行时的正确性并不需要保证。

### 实验环境

```
gcc 11.4.0
bison 3.8.2
flex 2.6.4
```
如果你在实验二中已经搭建好了环境，那么理应可以直接运行。在本目录下运行

```
make
```

即可编译所有文件，并对所有 testcase 进行测试。在你开始编写本作业的代码之前，可以运行 make 测试你的环境是否可以运行。本次实验工程提供了实验二 Solution 的 `.o` 文件，你可以直接在本工程里进行编写；你也可以copy 本次实验提供的新文件，然后在你自己编写的实验二的基础上继续开发，但可能需要对 makefile 进行调整。需要调整的编译命令是：

```
compiler: y.tab.o lex.yy.o TypeCheck.o TeaplAst.o TeaplaAst.o PrintTeaplaAst.o compiler.o 
	$(CXX) $(CXXFLAGS) -o compiler $^ 

TypeCheck.o: TypeCheck.cpp TypeCheck.h
	$(CXX) $(CXXFLAGS) -c $<

compiler.o: compiler.cpp TypeCheck.o TeaplAst.o TeaplaAst.o PrintTeaplaAst.o y.tab.o lex.yy.o
	$(CXX) $(CXXFLAGS) -c $<
```

### 上手

在 `compiler.cpp` 里可以看到，生成 AST 后调用 `check_Prog` 进行类型检查，你在 `check_Prog` 函数中拿到的即是整个程序的 AST 的 root。`TypeCheck.h` 和 `TypeCheck.cpp` 是本次实验需要编辑的文件，里面已经定义了一些数据结构和函数，给出了类型检查的整体框架。如果出现了类型检查错误，请输出错误的位置和原因。`TypeCheck.cpp` 里提供了一个 `error_print` 函数，你可以使用它输出错误信息然后退出程序。

如果需要额外的数据结构或者函数定义，可以自行设计。

### 测试

测试样例在 `tests/` 文件中，其中每个文件的末尾都以注释的形式提供了参考输出。直接在工程目录下运行 `make` 即可测试所有测试用例。

### 提交和评分

以学号命名提交压缩包，如 `22110240012.zip`。评分时会使用更多测试用例进行测试，按通过的测试数量进行评分。
