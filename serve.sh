#!/bin/bash

## this script works on Linux, so it may also work on Mac/OS (Unix)
### this script will not work on windows

export NVM_DIR="$HOME/.nvm"
export GOOGLE_APPLICATION_CREDENTIALS=''
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source ~/.bashrc

# Quick start functions

FORCE_COLOR=1
BACKEND_DIR=./FirebaseNodeJS/functions

echo '<< Serve firebase build >>'

nvm use 18.18
corepack enable
corepack yarn@3.5.0

cd $BACKEND_DIR
./node_modules/.bin/delay 2


firebase functions:config:unset env && firebase functions:config:set env.node_env="local" && firebase emulators:start --only functions:log
