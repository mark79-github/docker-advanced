#!/bin/bash

DIR=bgapp
echo "*** Setup needed files from git reposiotry ..."
if [ -d $DIR ]; then
    echo "*** Pull repository ..."
    cd $DIR && git pull https://github.com/mark79-github/bgapp.git
else 
    echo "*** Clone repository ..."
    git clone https://github.com/mark79-github/bgapp.git
fi
