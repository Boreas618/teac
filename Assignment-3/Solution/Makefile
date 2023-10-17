CXX = clang++
CXXFLAGS = -std=c++17 -g

TESTCASE_DIR := tests
TESTCASES = $(wildcard $(TESTCASE_DIR)/*.tea)
LLFILES = $(patsubst $(TESTCASE_DIR)/%.tea,$(TESTCASE_DIR)/%.ast,$(TESTCASES))

.astECONDARY: $(LLFILES)

run: $(patsubst $(TESTCASE_DIR)/%.tea,$(TESTCASE_DIR)/%.ast,$(TESTCASES))

$(TESTCASE_DIR)/%.ast: $(TESTCASE_DIR)/%.tea compiler
	./compiler $< $@

compiler: y.tab.o lex.yy.o TypeCheck.o TeaplAst.o TeaplaAst.o PrintTeaplaAst.o compiler.o 
	$(CXX) $(CXXFLAGS) -o compiler $^ 

TypeCheck.o: TypeCheck.cpp TypeCheck.h
	$(CXX) $(CXXFLAGS) -c $<

PrintTeaplaAst.o: PrintTeaplaAst.cpp PrintTeaplaAst.h
	$(CXX) $(CXXFLAGS) -c $<

compiler.o: compiler.cpp TypeCheck.o TeaplAst.o TeaplaAst.o PrintTeaplaAst.o y.tab.o lex.yy.o
	$(CXX) $(CXXFLAGS) -c $<
	
clean:
	rm TypeCheck.o compiler.o PrintTeaplaAst.o compiler tests/*.ast

