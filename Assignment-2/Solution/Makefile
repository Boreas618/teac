CXX = clang++
CXXFLAGS = -std=c++17 -g

TESTCASE_DIR := tests
TESTCASES = $(wildcard $(TESTCASE_DIR)/*.fmj)
LLFILES = $(patsubst $(TESTCASE_DIR)/%.fmj,$(TESTCASE_DIR)/%.S,$(TESTCASES))

.SECONDARY: $(LLFILES)

run: $(patsubst $(TESTCASE_DIR)/%.fmj,$(TESTCASE_DIR)/%.S,$(TESTCASES))

$(TESTCASE_DIR)/%.S: $(TESTCASE_DIR)/%.fmj compile.out
	./compile.out $< < $< > $@

compile.out: y.tab.o lex.yy.o TeaplAst.o compile.o 
	$(CXX) $(CXXFLAGS) -o compile.out $^ 

y.tab.c: parser.yacc fdmjast.h 
#	yacc --verbose --debug -d $< -o y.tab.cpp
	yacc -o y.tab.c -d $< -v --debug

y.tab.h: parser.yacc
#	yacc --verbose --debug -d $< -o y.tab.cpp
	yacc -o y.tab.c -d $< -v --debug

lex.yy.c: lexer.lex y.tab.h y.tab.cpp
	lex -o lex.yy.c $< 

y.tab.o: y.tab.c y.tab.h
	$(CXX) $(CXXFLAGS) -fpermissive -c $<

lex.yy.o: lex.yy.c y.tab.h
	$(CXX) $(CXXFLAGS) -fpermissive -c $<

TeaplAst.o: fdmjast.cpp fdmjast.h util.h
	$(CXX) $(CXXFLAGS) -fpermissive -c $<

compile.o: compile.cpp TeaplAst.o y.tab.h y.tab.o lex.yy.o
	$(CXX) $(CXXFLAGS) -fpermissive -c $<

clean:
	rm 
