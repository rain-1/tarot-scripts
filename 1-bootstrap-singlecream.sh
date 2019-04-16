#!/bin/bash
set -e
set -x

TAROT=build/tarot-singlecream

echo '###' setting up a clean build directory

rm -rf single_cream/tarot-compiler/
cp -r tarot-compiler/ single_cream/tarot-compiler/

( cd single_cream ; sh ./t/tarot/go.sh )

rm -rf "$TAROT"
cp -r single_cream/tarot-compiler "$TAROT"
cp single_cream/standard-functions.sch build/standard-functions.sch
