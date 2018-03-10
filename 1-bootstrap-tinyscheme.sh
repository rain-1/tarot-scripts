#!/bin/sh
set -e
set -x

TAROT=build/tinyscheme-bootstrap

function tinyscheme() {
	TINYSCHEMEINIT=./build/init.scm ./build/scheme "$@"
}

function tinyscheme_tarot_compile() {
	echo '###' building "$@"
	tinyscheme -1 "tarot-scripts/tinyscheme-compat.scm" "$@"
	update_standard_functions
}

function update_standard_functions() {
	echo '###' updating standard-functions.sch
	cat $TAROT/builtin-functions.scm > build/standard-functions.sch
	find "$TAROT" -name "*.sch" -exec cat {} \; >> build/standard-functions.sch
}

echo '###' setting up a clean build directory
rm -rf build/tinyscheme-bootstrap/
cp -r tarot-compiler/ build/tinyscheme-bootstrap/

update_standard_functions

echo '###' compiling std
tinyscheme_tarot_compile "$TAROT/std/cxr.scm"
tinyscheme_tarot_compile "$TAROT/macros.scm"
tinyscheme_tarot_compile "$TAROT/std/boxes.scm"
tinyscheme_tarot_compile "$TAROT/std/numbers.scm"
tinyscheme_tarot_compile "$TAROT/std/equal.scm"    # wants cond from macros.scm
tinyscheme_tarot_compile "$TAROT/std/lists.scm"    # wants not from numbers.scm, and equal?
tinyscheme_tarot_compile "$TAROT/std/display.scm"  # wants for-each from lists.scm
tinyscheme_tarot_compile "$TAROT/std/queue.scm" "$TAROT/std/seq.scm" "$TAROT/std/shapes.scm" "$TAROT/std/stack.scm" "$TAROT/std/string.scm" "$TAROT/std/timer.scm"
# build those all at once to save a bit of time, if there is some problem from this you can split it up

echo '###' compiling passes
tinyscheme_tarot_compile \
	"$TAROT/passes/parser.scm"
tinyscheme_tarot_compile \
	"$TAROT/passes/desugar.scm" \
	"$TAROT/passes/hoist.scm" \
	"$TAROT/passes/denest.scm" \
	"$TAROT/passes/flatten.scm" \
	"$TAROT/passes/tmp-alloc.scm" \
	"$TAROT/passes/assembler.scm"

echo '###' compiling compiler
tinyscheme_tarot_compile "$TAROT/compiler.scm"
tinyscheme_tarot_compile "$TAROT/eval.scm"
tinyscheme_tarot_compile "$TAROT/compile-file.scm"

echo '###' showing results
ls $TAROT/std/
ls $TAROT/passes/
ls $TAROT/

