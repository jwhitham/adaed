#!/bin/bash -xe

export PATH=$PWD:$PATH
make clean
make
adacomp -s -nl testlib -b test
adaexec testlib

