#!/bin/bash
set -e

export TAROTVM=./build/vm
export TAROT=./build/tarot-selfhost/

for test in tarot-tests/t/*scm
do
	rm -f "${test/%.scm/.q}"
	rm -f "${test/%.scm/.sch}"

	echo "compiling test '$test\'"
	sh tarot-scripts/run-tarot.sh $TAROT/compile-file.q -- "$test"

	echo "running test '$test\'"
	sh tarot-scripts/run-tarot.sh "${test/%.scm/.q}" -- > "$test.expect"
done
