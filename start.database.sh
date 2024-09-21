#!/bin/bash
set -a

## this script works on Linux, so it may also work on Mac/OS (Unix)
### this script will not work on windows



export GOOGLE_APPLICATION_CREDENTIALS="./FirebaseNodeJS/functions/src/config/serviceAccount/firebase-key.dev.json"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source ~/.bashrc

# Quick start functions


FORCE_COLOR=1
BACKEND_DIR=./FirebaseNodeJS/functions

echo 'Starting localhost all/emulators including database'


# this will run all emulators best to use when working with localdatabase, to import database on localhost, read instructions on /readme.md, we need to import database from file every time
if [[ ! -d "./FirebaseNodeJS/db_dump_local" ]] ; then
    echo 'File "./FirebaseNodeJS/db_dump_local" doesnt exist, aborting.'
    exit
fi


nvm use 18.18
corepack enable
corepack yarn@3.5.0

cd $BACKEND_DIR

### before we run emulator make sure all the ports are not already running
## NOTE install kill-port package globally first
## you may need to execute /$ pkill node # to kill running precesses


## emulator ports
npx kill-port 5001 9090 9000 4200 9099 5000 8085 9199 9299

### kill all ports first
## npm --prefix functions run "emulators:stop"

echo '<< Start watch >>'
## open this comman in another ternimal as a new process
gnome-terminal -- bash -c 'yarn watch'



echo '<< Start server with database >>'
## we initially may need to call this to install missing dependancies from firebase
# firebase init emulators


yarn serve:db:debug

set +a

