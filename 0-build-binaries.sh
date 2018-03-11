#!/bin/bash

mkdir -p build/
(
	cd tinyscheme
	make
	cp init.scm ../build
)
(
	cd tarot-vm
	make
	cp vm ../build/
)

