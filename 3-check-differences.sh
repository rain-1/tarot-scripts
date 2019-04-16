#!/bin/bash
diff -r build/tarot-singlecream/ build/tarot-selfhost/ | grep -v tarot-singlecream | grep -v tarot-selfhost
