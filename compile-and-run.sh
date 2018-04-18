#!/bin/bash
set -e

export TAROTVM=./build/vm
export TAROT=./build/tarot-selfhost/

rm -f "${1/%.scm/.q}"
sh tarot-scripts/run-tarot.sh $TAROT/compile-file.q -- "$1"
sh tarot-scripts/run-tarot.sh "${1/%.scm/.q}" --
