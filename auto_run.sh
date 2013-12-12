#!/bin/bash
options="-seed 1 -nice 0 -max:inst 0 -fastfwd 0 -fetch:ifqsize 4 -fetch:mplat 3 -fetch:speed 1 -bpred 2lev -bpred:bimod 2048 -bpred:2lev 1 4096 12 1 -bpred:comb 1024 -bpred:ras 8 -bpred:btb 512 4 -decode:width 4 -issue:width 4 -issue:inorder false -issue:wrongpath true -commit:width 4 -ruu:size 64 -lsq:size 8 -cache:dl1 dl1:128:32:4:l -cache:dl1lat 1 -cache:dl2 ul2:1024:64:4:l -cache:dl2lat 6 -cache:il1 il1:512:32:1:l -cache:il1lat 1 -cache:il2 dl2 -cache:il2lat 6 -cache:flush false -cache:icompress false -mem:lat 18 2 -mem:width 8 -tlb:itlb itlb:16:4096:4:l -tlb:dtlb dtlb:32:4096:4:l -tlb:lat 30 -res:ialu 4 -res:imult 2 -res:memport 2 -res:fpalu 4 -res:fpmult 2 -bugcompat false"

make 2>&1 | grep error && exit

find ./tests/bin.little/ -name "test-*" -print0 | while read -d $'\0' i
do
	a=`pwd`
	sh -c "$a/origin-outorder $options $a/$i"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	sh -c "$a/sim-outorder $options $a/$i" 
	echo "$a/sim-outorder $options $a/$i"
done
