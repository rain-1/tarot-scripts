#!/bin/sh

mkdir -p build/
(
	cd tinyscheme
	cc -o ../build/scheme -lm scheme.c
	cp init.scm ../build
)
(
	cd vm
	make
	cp vm ../build/
)

