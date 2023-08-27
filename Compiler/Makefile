# TESTCASE_DIR := ../functional
# TESTCASE_DIR := tmp
# TESTCASE_DIR := ../pass_performance
TESTCASE_DIR := ../final_performance
# TESTCASE_DIR := ../functional
# TESTCASE_DIR := ../failtest
OUTPUT_DIR := ./output
TESTCASES = $(wildcard $(TESTCASE_DIR)/*.sy)

parsertest: $(patsubst $(TESTCASE_DIR)/%.sy,$(OUTPUT_DIR)/%.output,$(TESTCASES))

$(OUTPUT_DIR)/%.output: compiler $(TESTCASE_DIR)/%.sy
	@ulimit -s 65536
	@echo TEST $*
#	@./$< $(TESTCASE_DIR)/$*.sy $@
	./test-functional.sh test_single $*
#	./test-functional.sh bin $*
#	./perf.sh test_single $*
	@echo 


compiler: compiler.o ast.o util.o lex.yy.o y.tab.o printast.o translate.o treep.o temp.o templabel.o prtreep.o oldtable.o symbol.o canon.o ssa.o liveness_llvm.o liveness.o graph.o gen_as.o flowgraph_llvm.o flowgraph.o bg_llvm.o bg.o assem.o llvm_assemblock.o assemblock.o llvm_assem.o deadce.o block_optimize.o regalloc.o ig.o gen_as_arm.o bg2.o looptree.o gcm.o data_chain.o domtree.o gvn.o naive_merge_ins.o fun_inline.o mem2reg.o elimilation_dc.o loopunroll.o remove_load.o tempdsu.o ins_schedule.o condition_exec.o liveness_color.o purecache.o
	@clang++ $^ -g -gdwarf-4 -std=c++17 -O2  -o compiler

compiler.o: compiler.cpp y.tab.hpp util.h util.cpp printast.h translate.hpp temp.h templabel.hpp oldtable.o symbol.o canon.h my_map.hpp
	@clang++  -g -gdwarf-4 -std=c++17 -O2  -c  compiler.cpp

ast.o: ast.cpp ast.h  util.h util.cpp
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c ast.cpp

translate.o: translate.cpp translate.hpp treep.cpp treep.hpp temp.cpp temp.h templabel.cpp templabel.hpp table.hpp
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c translate.cpp

treep.o:treep.cpp treep.hpp
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c treep.cpp

temp.o:temp.cpp temp.h
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c temp.cpp

templabel.o:templabel.cpp templabel.hpp
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c templabel.cpp

prtreep.o:prtreep.cpp prtreep.hpp
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c prtreep.cpp
#lex.yy.c: lexer.lex y.tab.h y.tab.c
#	@lex lexer.lex
	
#y.tab.c: parser.yacc ast.h 
#	@yacc -d -v --debug parser.yacc
	
#y.tab.h: parser.yacc
#	@yacc -d -v --debug parser.yacc

lex.yy.o: lex.yy.cpp y.tab.hpp
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c lex.yy.cpp

y.tab.o: y.tab.cpp
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c y.tab.cpp

util.o: util.cpp util.h
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c util.cpp

printast.o: printast.cpp printast.h
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c printast.cpp

symbol.o: symbol.cpp symbol.h oldtable.o util.o
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c $<

oldtable.o: oldtable.cpp oldtable.h util.o
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c $<

canon.o: canon.cpp canon.h temp.h treep.hpp templabel.hpp
	@clang++ -g -gdwarf-4 -std=c++17 -O2  -c $<

bg.o: bg.cpp bg.h oldtable.h util.h graph.h symbol.h temp.h assem.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

bg_llvm.o: bg_llvm.cpp bg_llvm.h oldtable.h util.h graph.h symbol.h temp.h assem.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

flowgraph.o: flowgraph.cpp flowgraph.h oldtable.h util.h graph.h symbol.h temp.h assem.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

flowgraph_llvm.o: flowgraph_llvm.cpp flowgraph_llvm.h oldtable.h util.h graph.h symbol.h temp.h assem.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

gen_as.o: gen_as.cpp gen_as.h treep.hpp util.h temp.h assem.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

graph.o: graph.cpp graph.h symbol.h util.h temp.h assem.h oldtable.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

liveness.o: liveness.cpp liveness.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

liveness_llvm.o: liveness_llvm.cpp liveness_llvm.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

ssa.o: ssa.cpp ssa.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

assem.o: assem.cpp assem.h temp.h symbol.h util.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

llvm_assem.o: llvm_assem.cpp llvm_assem.h temp.h symbol.h util.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

assemblock.o: assemblock.cpp assemblock.h assem.h temp.h symbol.h util.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

llvm_assemblock.o: llvm_assemblock.cpp assemblock.h assem.h temp.h symbol.h util.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

deadce.o: deadce.cpp deadce.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

block_optimize.o:block_optimize.cpp block_optimize.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

gen_as_arm.o: gen_as_arm.cpp gen_as_arm.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

purecache.o: purecache.cpp purecache.hpp
	@clang++ -g -fpermissive -std=c++17 -O2  -c  $<

ig.o: ig.cpp ig.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

regalloc.o: regalloc.cpp regalloc.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

bg2.o: bg2.cpp bg2.h assem.h temp.h symbol.h util.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c  $<

looptree.o: looptree.cpp looptree.h assem.h temp.h symbol.h util.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c  $<

data_chain.o: data_chain.cpp data_chain.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c  $<

gcm.o: gcm.cpp gcm.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c  $<

domtree.o: domtree.cpp domtree.h
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

gvn.o: gvn.cpp gvn.h
	@clang++  -g -fpermissive -std=c++17 -O2  -c $<

naive_merge_ins.o: naive_merge_ins.cpp naive_merge_ins.h
	@clang++  -g -fpermissive -std=c++17 -O2  -c $<
	
fun_inline.o:fun_inline.cpp fun_inline.h
	@clang++  -g -fpermissive -std=c++17 -O2  -c $<

elimilation_dc.o:elimilation_dc.cpp elimilation_dc.h
	@clang++  -g -fpermissive -std=c++17 -O2  -c $<
	
mem2reg.o: mem2reg.cpp mem2reg.h
	@clang++  -g -fpermissive -std=c++17 -O2  -c $<

loopunroll.o: loopunroll.cpp loopunroll.hpp
	@clang++ -g -fpermissive -std=c++17 -O2  -c $<

ins_schedule.o: ins_schedule.cpp ins_schedule.h
	@clang++  -g -fpermissive -std=c++17 -O2  -c $<

remove_load.o: remove_load.cpp remove_load.h
	@clang++  -g -fpermissive -std=c++17 -O2  -c $<

tempdsu.o: tempdsu.cpp tempdsu.h 
	@clang++  -g -fpermissive -std=c++17 -O2  -c $<

condition_exec.o:condition_exec.cpp condition_exec.h
	@clang++  -g -fpermissive -std=c++17 -O2  -c $<

liveness_color.o: liveness_color.cpp liveness_color.h
	@clang++  -g -fpermissive -std=c++17 -O2  -c $<

clean:
	rm -f *.o compiler $(TESTCASE_DIR)/*.s.output 
	rm -f `ls output/*|egrep -x -v perf-log`
