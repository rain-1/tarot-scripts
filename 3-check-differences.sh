#!/bin/sh
diff -r build/tinyscheme-bootstrap/ build/tarot-selfhost/ | grep -v tinyscheme-bootstrap | grep -v tarot-selfhost
