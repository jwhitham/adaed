#!/bin/bash -xe

export PATH=$PWD:$PATH
make install
adacomp -s -nl testlib -b test
adaexec testlib

