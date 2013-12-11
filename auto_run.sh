#!/bin/bash
make 2>&1 | grep error && exit
options="-seed 1 -nice 0 -max:inst 0 -fastfwd 0 -fetch:ifqsize 4 -fetch:mplat 3 -fetch:speed 1 -bpred 2lev -bpred:bimod 2048 -bpred:2lev 1 4096 12 1 -bpred:comb 1024 -bpred:ras 8 -bpred:btb 512 4 -decode:width 4 -issue:width 4 -issue:inorder false -issue:wrongpath true -commit:width 4 -ruu:size 64 -lsq:size 8 -cache:dl1 dl1:128:32:4:l -cache:dl1lat 1 -cache:dl2 ul2:1024:64:4:l"
find ./tests/bin.little/ -name "test-*" -print0 | while read -d $'\0' i
do
	a=`pwd`
	echo "=================================="
	echo "=================================="
	sh -c "$a/origin-outorder $options $a/$i" || exit
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	sh -c "$a/sim-outorder $options $a/$i" || echo "$a/sim-outorder $options $a/$i" && exit
done
