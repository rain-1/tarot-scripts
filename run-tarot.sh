#!/bin/sh
set -e
set -x

# TAROTVM=./build/vm
# TAROTVM="lldb ./build/vm --"

# TAROT=./build/tinyscheme-bootstrap/
# TAROT=./build/tarot-selfhost/
# (the tree containing the .q files)

$TAROTVM \
    $TAROT/std/numbers.q \
    $TAROT/std/boxes.q \
    $TAROT/std/equal.q \
    $TAROT/std/lists.q \
    $TAROT/std/cxr.q \
    $TAROT/std/seq.q \
    $TAROT/std/display.q \
    $TAROT/std/queue.q \
    $TAROT/std/stack.q \
    $TAROT/std/string.q \
    $TAROT/std/timer.q \
    $TAROT/std/shapes.q \
    $TAROT/macros.q \
    $TAROT/passes/parser.q \
    $TAROT/passes/denest.q \
    $TAROT/passes/tmp-alloc.q \
    $TAROT/passes/desugar.q \
    $TAROT/passes/assembler.q \
    $TAROT/passes/flatten.q \
    $TAROT/passes/hoist.q \
    $TAROT/compiler.q \
    $TAROT/eval.q \
    "$@"
