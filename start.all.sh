#!/bin/bash
set -a

## this script works on Linux, so it may also work on Mac/OS (Unix)
### this script will not work on windows
#### This script will target root of both projects and execute FE and BE as seperate proces in new terminal


export GOOGLE_APPLICATION_CREDENTIALS='./src/config/serviceAccount/firebase-key.dev.json'
## this is for local host only
## source https://stackoverflow.com/questions/46005374/how-to-configure-timeout-of-firebase-functions-on-local
export FUNCTIONS_EMULATOR_TIMEOUT_SECONDS=540s

## for linux in local entironment only
### source https://stackoverflow.com/questions/72104449/node-js-crypto-fails-to-sign-pem-key-string-from-file-with-error25066067dso-su#comment127440640_72104449
export OPENSSL_CONF=/dev/null

## Node options
### add more memory
#### example https://stackoverflow.com/questions/38558989/node-js-heap-out-of-memory#38560292
##export NODE_OPTIONS=--max_old_space_size=8192



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source ~/.bashrc

# Quick start functions

FORCE_COLOR=1
BACKEND_DIR=./FirebaseNodeJS/functions
## go back out to projects root
PROJECTS_ROOT=../
echo 'Starting localhost all/emulators including database'


# this will run all emulators best to use when working with localdatabase, to import database on localhost, read instructions on /readme.md, we need to import database from file every time
if [[ ! -d "./FirebaseNodeJS/db_dump_local" ]] ; then
    echo 'File "./FirebaseNodeJS/db_dump_local" doesnt exist, aborting.'
    exit
fi


nvm use 18.18
corepack enable
corepack yarn@3.0.0

## Execute BE project
echo '<< Execute BE project >>'


yarn kill-ports

cd $BACKEND_DIR


## Make sure we start project in dev
gcloud config set project kog-kos-konc-dev
firebase use dev


### before we run emulator make sure all the ports are not already running
## NOTE install kill-port package globally first
## you may need to execute /$ pkill node # to kill running precesses


## emulator ports
# npx kill-port 5001 # busy port
# npx kill-port 9090 # busy port
# npx kill-port 9000 # busy port
# npx kill-port 4200 # exit client proccess
# npx kill-port 9099
# npx kill-port 5000
# npx kill-port 8085
# npx kill-port 9199
# npx kill-port 9299



### kill all ports first
## npm --prefix functions run "emulators:stop"

echo '<< Start watch >>'
## open this comman in another ternimal as a new process
gnome-terminal -- bash -c 'yarn watch'




## we initially may need to call this to install missing dependancies from firebase
# firebase init emulators
#echo '<< Start server with remote database >>'
## start with remote database only if needed to test FCM need to connect to real database that works with mobile app


if [ "$1" == "db" ]; then
    ## start with local database
    
    echo '<< Start server with local database >>'
    yarn serve:db:debug&
    
else
    
    RED='\033[0;31m'
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}<< Start server with remote database >>"
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}-CAREFULL-----------------------------"
    echo -e "${RED}-CAREFULL-----------------------------"
    
    yarn serve:debug&
    
fi


### execute FE project
echo '<< Execute FE project >>'

## go back 3 dirs and into FE project
cd ../../../kog-kos-konc-frontend

#trap 'gnome-terminal' EXIT
## start FE project with local environment
gnome-terminal -- bash -c 'yarn start:local'

## Node options
### add more memory
#### example https://stackoverflow.com/questions/38558989/node-js-heap-out-of-memory#38560292
#export NODE_OPTIONS=--max_old_space_size=8192



set +a

