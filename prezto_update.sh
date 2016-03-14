#!/bin/bash
dir=$(pwd)
cd ~/.zprezto
git fetch upstream
git checkout master
git merge upstream/master
git pull && git submodule update --init --recursive
cd $dir
exit 0
