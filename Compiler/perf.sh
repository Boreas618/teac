#!/bin/bash
compiler_src_dir=$(realpath $(dirname "$0")/../../src)
test_src_dir=$(realpath $(dirname "$0")/../src)
func_testcase_dir=$(realpath $(dirname "$0")/../functional)
# func_testcase_dir=$(realpath $(dirname "$0")/tmp)
# func_testcase_dir=$(realpath $(dirname "$0")/../pass_performance)
# func_testcase_dir=$(realpath $(dirname "$0")/./temptest)
build_dir=$(realpath $(dirname "$0")/../../build)
libsysy=$(realpath $(dirname "$0")/../../)/libsysy.a

compile() {
	cd $build_dir

	if [ $1 = "ast" ]; then
		clang++-10 $test_src_dir/test-ast.cpp $compiler_src_dir/*.cpp -o $build_dir/test-$1
	fi
}

ast() {
	#ast func_name
	#echo $2
	#compile ast

	if [ -z $1 ]; then
		# all test
		test_file_list=`realpath --relative-base=$func_testcase_dir $func_testcase_dir/*.sy`
		for x in $test_file_list
		do
			test_name=${x%.sy}
			
			$build_dir/test-ast < $func_testcase_dir/$x > $build_dir/$test_name.ast
		done

		# echo $test_name_list
	else
		test_file=`realpath --relative-base=$func_testcase_dir $func_testcase_dir/$1*.sy`
		
		test_name=${test_file%.sy}
		#ref_output_file=$func_testcase_dir/$test_name.out
		
		#echo $test_name

		#cd $build_dir
		$build_dir/test-ast < $func_testcase_dir/$test_file > $build_dir/$test_name.ast
	fi
}

ir() {
	#ast func_name
	#echo $2
	#compile ast

	if [ -z $1 ]; then
		# all test
		test_file_list=`realpath --relative-base=$func_testcase_dir $func_testcase_dir/*.sy`
		for x in $test_file_list
		do
			test_name=${x%.sy}
			echo $test_name
			$build_dir/test-ir < $func_testcase_dir/$x > $build_dir/$test_name.ast
		done

		# echo $test_name_list
	else
		test_file=`realpath --relative-base=$func_testcase_dir $func_testcase_dir/$1*.sy`
		
		test_name=${test_file%.sy}
		#ref_output_file=$func_testcase_dir/$test_name.out
		
		echo $test_name

		#cd $build_dir
		$build_dir/test-ir < $func_testcase_dir/$test_file > $build_dir/$test_name.s
	fi
}

asm() {
	#ast func_name
	#echo $2
	#compile ast

	if [ -z $1 ]; then
		# all test
		test_file_list=`realpath --relative-base=$func_testcase_dir $func_testcase_dir/*.sy`
		for x in $test_file_list
		do
			test_name=${x%.sy}
			echo -n $test_name
			echo -n ": "
			$build_dir/test-asm -S $func_testcase_dir/$test_name.sy -o $build_dir/$test_name.s -O1
			if [ $? != 0 ]; then
				echo fail; exit
			fi
			arm-linux-gnueabihf-gcc -march=armv7-a $build_dir/$test_name.s $libsysy -static -o $build_dir/$test_name
			if [ $? != 0 ]; then
				echo "fail to link"; exit
			fi
			if [ -f $func_testcase_dir/$test_name.in ]; then
				qemu-arm -B 0x100000000 $build_dir/$test_name < $func_testcase_dir/$test_name.in > $build_dir/$test_name.out
			else
				qemu-arm -B 0x100000000 $build_dir/$test_name > $build_dir/$test_name.out
			fi
			echo -e \\n$? >> $build_dir/$test_name.out
			diff -Bb  $build_dir/$test_name.out $func_testcase_dir/$test_name.out > /dev/null 2>/dev/null
			if [ $? == 0 ]; then
				echo pass; mv $build_dir/$test_name.s $build_dir/build/perf/;rm $build_dir/$test_name*
			else
				echo fail;\
				echo "Expect:";\
				cat $func_testcase_dir/$test_name.out;\
				echo "Got:";\
				cat $build_dir/$test_name.out;\
				cp $func_testcase_dir/$test_name.sy $build_dir/
				exit
			fi
		done

		# echo $test_name_list
	else
		test_file=`realpath --relative-base=$func_testcase_dir $func_testcase_dir/$1*.sy`
		
		test_name=${test_file%.sy}
		#ref_output_file=$func_testcase_dir/$test_name.out
		
		echo -n $test_name
		echo -n ": "

		#cd $build_dir
		$build_dir/test-asm -S $func_testcase_dir/$test_name.sy -o $build_dir/$test_name.s -O1
		if [ $? != 0 ]; then
			echo fail; exit
		fi
		arm-linux-gnueabihf-gcc -march=armv7-a $build_dir/$test_name.s $libsysy -static -o $build_dir/$test_name
		if [ $? != 0 ]; then
			echo "fail to link"; exit
		fi
		if [ -f $func_testcase_dir/$test_name.in ]; then
			time qemu-arm -B 0x100000000 $build_dir/$test_name < $func_testcase_dir/$test_name.in > $build_dir/$test_name.out
		else
			time qemu-arm -B 0x100000000 $build_dir/$test_name > $build_dir/$test_name.out
		fi
		echo -e \\n$? >> $build_dir/$test_name.out
		diff -Bb $build_dir/$test_name.out $func_testcase_dir/$test_name.out > /dev/null 2>/dev/null
		if [ $? == 0 ]; then
			echo pass; mv $build_dir/$test_name.s $build_dir/build/perf/; rm $build_dir/$test_name*
		else
			echo fail;\
			echo "Expect:";\
			cat $func_testcase_dir/$test_name.out;\
			echo "Got:";\
			cat $build_dir/$test_name.out;\
			cp $func_testcase_dir/$test_name.sy $build_dir/ ;\
			exit
		fi
	fi
}

test_single() {
	test_file=`realpath --relative-base=$func_testcase_dir $func_testcase_dir/$1.sy`	
	test_name=${test_file%.sy}
	#ref_output_file=$func_testcase_dir/$test_name.out
	mkdir -p ./output/perf-log

    echo -n $test_name >> ./output/perf-log/perf.log
	echo ": " >> ./output/perf-log/perf.log
	#cd $build_dir
	./compiler  -S -o ./output/$test_name.output.s $func_testcase_dir/$test_name.sy
	if [ $? != 0 ]; then
		echo fail >> ./output/perf-log/perf.log; exit -1
	fi
	# llvm-link-14 --opaque-pointers ./output/$test_name.output.s.ll sylib.ll -S -o ./output/$test_name.ll
	arm-linux-gnueabihf-gcc -march=armv7 ./output/$test_name.output.s sylib.S --static -o ./output/$test_name
	if [ $? != 0 ]; then
		echo "fail to link"; exit -1
	fi
	
	if [ -f $func_testcase_dir/$test_name.in ]; then
		# lli-14 --opaque-pointers ./output/$test_name.ll < $func_testcase_dir/$test_name.in > output/$test_name.out 2>>./output/perf-log/perf.log
		qemu-arm -B 0x1000 ./output/$test_name < $func_testcase_dir/$test_name.in > output/$test_name.out 2>>./output/perf-log/perf.log
	else
		# lli-14 --opaque-pointers ./output/$test_name.ll > ./output/$test_name.out 2>>./output/perf-log/perf.log
		qemu-arm -B 0x1000 ./output/$test_name > output/$test_name.out 2>>./output/perf-log/perf.log
	fi
	echo -e $? >> ./output/$test_name.out
	diff -Bb ./output/$test_name.out $func_testcase_dir/$test_name.out > /dev/null 2>/dev/null
	if [ $? == 0 ]; then
		echo pass >> ./output/perf-log/perf.log;
        echo "" >> ./output/perf-log/perf.log;
	else
		echo fail >>./output/perf-log/perf.log;\
		echo "Expect:" >>./output/perf-log/perf.log;\
		cat $func_testcase_dir/$test_name.out >>./output/perf-log/perf.log;\
		echo "Got:" >>./output/perf-log/perf.log;\
		cat ./output/$test_name.out >>./output/perf-log/perf.log;\
		exit -1
	fi
}

main() {
	if [ $1 = 'ast' ]; then
		ast $2
	elif [ $1 = 'ir' ]; then
		ir $2
	elif [ $1 = 'asm' ]; then
		asm $2
	elif [ $1 = 'test_single' ]; then
		test_single $2
	fi
}

main $@
