#!/bin/bash -xe

export PATH=$PWD:$PATH
make clean
make install
adacomp -s -nl testlib -b test
adaexec testlib

