#!/bin/bash
compiler_src_dir=$(realpath $(dirname "$0")/../../src)
test_src_dir=$(realpath $(dirname "$0")/../src)
# func_testcase_dir=$(realpath $(dirname "$0")/../functional)
# func_testcase_dir=$(realpath $(dirname "$0")/tmp)
func_testcase_dir=$(realpath $(dirname "$0")/../final_performance)
# func_testcase_dir=$(realpath $(dirname "$0")/../pass_performance)
# func_testcase_dir=$(realpath $(dirname "$0")/../failtest)
build_dir=$(realpath $(dirname "$0")/../../build)
libsysy=$(realpath $(dirname "$0")/../../)/libsysy.a

compile() {
	cd $build_dir

	if [ $1 = "ast" ]; then
		clang++-10 $test_src_dir/test-ast.cpp $compiler_src_dir/*.cpp -o $build_dir/test-$1
	fi
}

test_single() {
	test_file=`realpath --relative-base=$func_testcase_dir $func_testcase_dir/$1.sy`	
	test_name=${test_file%.sy}
	#ref_output_file=$func_testcase_dir/$test_name.out
	
	echo -n $test_name
	echo ": "

	#cd $build_dir
	#cp $func_testcase_dir/$test_name.* $build_dir/
	./compiler  -S -o ./output/$test_name.output.s $func_testcase_dir/$test_name.sy
	if [ $? != 0 ]; then
		echo fail; exit -1
	fi
	arm-linux-gnueabihf-gcc -march=armv7 ./output/$test_name.output.s sylib.S --static -o ./output/$test_name
    # llvm-link-14 --opaque-pointers ./output/$test_name.output.s.ll sylib.ll -S -o ./output/$test_name.ll
	if [ $? != 0 ]; then
		echo "fail to link"; exit -1
	fi
	if [ -f $func_testcase_dir/$test_name.in ]; then
		# qemu-arm -B 0x100000000 $build_dir/$test_name < $func_testcase_dir/$test_name.in > $build_dir/$test_name.out
		qemu-arm -B 0x1000 ./output/$test_name < $func_testcase_dir/$test_name.in > output/$test_name.out
    	# lli-14 --opaque-pointers ./output/$test_name.ll < $func_testcase_dir/$test_name.in > output/$test_name.out
		# lli-14 --opaque-pointers ./output/$test_name.ll < $func_testcase_dir/$test_name.in
	else
		# qemu-arm -B 0x100000000 $build_dir/$test_name > $build_dir/$test_name.out
		qemu-arm -B 0x1000 ./output/$test_name > output/$test_name.out
    	# lli-14 --opaque-pointers ./output/$test_name.ll > ./output/$test_name.out
		# lli-14 --opaque-pointers ./output/$test_name.ll
	fi
	echo -e $? >> ./output/$test_name.out
	diff -Bb ./output/$test_name.out $func_testcase_dir/$test_name.out > /dev/null 2>/dev/null
	if [ $? == 0 ]; then
		# echo pass; mkdir -p $build_dir/build/; mv $build_dir/$test_name.s $build_dir/build/; rm $build_dir/$test_name $build_dir/$test_name.*

        echo pass; 
	else
		echo fail;\
		echo "Expect:";\
		cat $func_testcase_dir/$test_name.out;\
		echo "Got:";\
		cat ./output/$test_name.out;\
		exit -1
	fi
}

bin() {
	test_file=`realpath --relative-base=$func_testcase_dir $func_testcase_dir/$1.sy`	
	test_name=${test_file%.sy}
	#ref_output_file=$func_testcase_dir/$test_name.out
	
	echo -n $test_name
	echo ": "

	#cd $build_dir
	#cp $func_testcase_dir/$test_name.* $build_dir/
	./compiler  -S -o ./output/$test_name.output.s $func_testcase_dir/$test_name.sy
	if [ $? != 0 ]; then
		echo fail; exit -1
	fi
	arm-linux-gnueabihf-gcc -march=armv7 ./output/$test_name.output.s sylib.S --static -o ./output/$test_name
    # llvm-link-14 --opaque-pointers ./output/$test_name.output.ll sylib.ll -S -o ./output/$test_name.ll
	if [ $? != 0 ]; then
		echo "fail to link"; exit -1
	fi
	echo gen bin successfully;
}

main() {
	if [ $1 = 'ast' ]; then
		ast $2
	elif [ $1 = 'ir' ]; then
		ir $2
	elif [ $1 = 'bin' ]; then
		bin $2
	elif [ $1 = 'test_single' ]; then
		test_single $2
	fi
}

main $@
