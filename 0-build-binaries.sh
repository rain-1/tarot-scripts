#!/bin/bash

mkdir -p build/
(
	cd single_cream
	make
# XXX TODO
#	cp scheme ../build
#	cp init.scm ../build
)
(
	cd tarot-vm
	make
	cp vm ../build/
)

