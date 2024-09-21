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
export GOOGLE_APPLICATION_CREDENTIALS=''
echo '<< Start backend server and watch listener >>'

nvm use 18.18
corepack enable
corepack yarn@3.5.0

cd $BACKEND_DIR
./node_modules/.bin/delay 2


echo '<< Start watch >>'
## open this comman in another ternimal as a new process
gnome-terminal -- bash -c 'yarn watch'


echo '<< Start server>>'
yarn serve:db:debug