#!/bin/bash
make 2>&1 | grep error && exit
find ./tests/bin.little/ -name "test-*" -print0 | while read -d $'\0' i
do
	a=`pwd`
	sh -c "$a/sim-outorder $a/$i" || exit
done
