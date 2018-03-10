#!/bin/sh
set -e
set -x

export TAROTVM=./build/vm
export TAROT=build/tinyscheme-bootstrap
export TAROTOUT=build/tarot-selfhost

function tarot_compile() {
        echo '###' building "$@"
        sh tarot-scripts/run-tarot.sh $TAROT/compile-file.q -- "$@"
}

echo '###' setting up a clean build directory
rm -rf "$TAROTOUT"
cp -r tarot-compiler/ "$TAROTOUT"

tarot_compile "$TAROTOUT/std/numbers.scm"

echo '###' compiling std
tarot_compile "$TAROTOUT/std/cxr.scm"
tarot_compile "$TAROTOUT/macros.scm"
tarot_compile "$TAROTOUT/std/boxes.scm"
tarot_compile "$TAROTOUT/std/numbers.scm"
tarot_compile "$TAROTOUT/std/equal.scm"
tarot_compile "$TAROTOUT/std/lists.scm"
tarot_compile "$TAROTOUT/std/display.scm"
tarot_compile \
	"$TAROTOUT/std/queue.scm" \
	"$TAROTOUT/std/seq.scm" \
	"$TAROTOUT/std/shapes.scm" \
	"$TAROTOUT/std/stack.scm" \
	"$TAROTOUT/std/string.scm" \
	"$TAROTOUT/std/timer.scm"

echo '###' compiling passes
tarot_compile \
        "$TAROTOUT/passes/parser.scm" \
        "$TAROTOUT/passes/desugar.scm" \
        "$TAROTOUT/passes/hoist.scm" \
        "$TAROTOUT/passes/denest.scm" \
        "$TAROTOUT/passes/flatten.scm" \
        "$TAROTOUT/passes/tmp-alloc.scm" \
        "$TAROTOUT/passes/assembler.scm"

echo '###' compiling compiler
tarot_compile "$TAROTOUT/compiler.scm"
tarot_compile "$TAROTOUT/eval.scm"
tarot_compile "$TAROTOUT/compile-file.scm"
