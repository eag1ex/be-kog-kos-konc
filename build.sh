#!/bin/bash

## this script works on Linux, so it may also work on Mac/OS (Unix)
### this script will not work on windows

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source ~/.bashrc

# Quick start functions

FORCE_COLOR=1
BACKEND_DIR=./FirebaseNodeJS/functions

echo '<< Build firebase server >>'

nvm use v16.20.0
corepack enable
corepack yarn@3.0.0

cd $BACKEND_DIR
./node_modules/.bin/delay 2


yarn build
