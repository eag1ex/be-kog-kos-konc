#!/usr/bin/env bash

## This script is for deploy to environment, use it with care
### Only those with access token can deploy this project to environment

set -a


## nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source ~/.bashrc

FORCE_COLOR=1
ENV=$1
DEPLOY_TOKENS="deploy.firebase.tokens.sh"

dateTime=$(date +%Y_%m_%d_%H%M%S)
if [[ ! -f $DEPLOY_TOKENS ]] ; then
    echo "File $DEPLOY_TOKENS doesnt exist, aborting deployment to $ENV"
    exit 1
fi

source ./$DEPLOY_TOKENS

## swith to correct node version
nvm use 18.18
corepack enable
corepack yarn@3.5.0

BACKEND_DIR=./FirebaseNodeJS/functions
cd $BACKEND_DIR

runProjectLintCheck(){
    # this is the same order as in husky script
    
    
    
    text="Running predeploy lint checks"
    echo -e "\e[36m$text\e[0m"
    echo  "----------"
    echo  "-----"
    
    yarn prefix:deploy ||
    (
        echo 'pre deploy check error';
        exit 1
    )
    
    yarn husky:pretty:check ||
    (
        echo 'Its NOT GOOD - Your styling needs improvement';
        exit 1
    )
    
    yarn husky:lint ||
    (
        echo '🤡😂❌🤡 Failed Type check. 🤡😂❌🤡';
        exit 1
    )
    
}


text="Starting Firebase deployment"
echo  "----------"
echo  "-----"
echo -e "\e[1;33;4;44m$text\e[0m"
echo  "-----"
echo  "----------"

nvm current
firebase --version


if [ "$ENV" == "dev" ]; then
    
    NODE_ENV=development
    
    runProjectLintCheck
    
    text="Deploying to $ENV ($NODE_ENV)"
    echo -e "\e[36m$text\e[0m"
    echo  "----------"
    echo  "-----"
    
    yarn build
    
    
    text="Build for $ENV complete!"
    echo  "----------"
    echo  "-----"
    echo -e "\e[36m$text\e[0m"
    echo  "-----"
    echo  "----------"
    
    # deploy to firebase
    firebase use dev --token $FIREBASE_TOKEN
    firebase functions:config:unset env --token $FIREBASE_TOKEN
    firebase functions:config:set env.node_env="$NODE_ENV" --token $FIREBASE_TOKEN
    # to avoid firebase deploy issue
    
    firebase deploy -P dev --token $FIREBASE_TOKEN --message "Release: $dateTime"
    
    echo  " "
    echo  "----------"
    echo  "Deployment complete!"
    exit 1
    
else
    
    if [ "$ENV" == 'stg' ]; then
        
        NODE_ENV=staging
        
        runProjectLintCheck
        
        text="Deploying to $ENV ($NODE_ENV)"
        echo -e "\e[36m$text\e[0m"
        echo  "----------"
        echo  "-----"
        
        # cd  ./FirebaseNodeJS/functions
        
        yarn build
        
        text="Build for $ENV complete!"
        
        echo  "----------"
        echo  "-----"
        echo -e "\e[36m$text\e[0m"
        echo  "-----"
        echo  "----------"
        
        # deploy to firebase
        firebase use staging --token $FIREBASE_TOKEN
        firebase functions:config:unset env --token $FIREBASE_TOKEN
        firebase functions:config:set env.node_env="$NODE_ENV" --token $FIREBASE_TOKEN
        firebase deploy -P staging --token $FIREBASE_TOKEN --message "Release: $dateTime"
        
        echo  " "
        echo  "----------"
        echo  "Deployment complete!"
        exit 1
    fi
    
    if [ "$ENV" == 'prod' ]; then
        NODE_ENV=production
        
        runProjectLintCheck
        
        text="Deploying to $ENV ($NODE_ENV)"
        echo -e "\e[36m$text\e[0m"
        echo  "----------"
        echo  "-----"
        
        
        yarn build
        text="Build for $ENV complete!"
        
        echo  "----------"
        echo  "-----"
        echo -e "\e[36m$text\e[0m"
        echo  "-----"
        echo  "----------"
        
        firebase use prod --token $FIREBASE_TOKEN
        firebase functions:config:unset env --token $FIREBASE_TOKEN
        firebase functions:config:set env.node_env="$NODE_ENV" --token $FIREBASE_TOKEN
        firebase deploy -P prod --token $FIREBASE_TOKEN --message "Release: $dateTime"
        
        echo  " "
        echo  "----------"
        echo  "Deployment complete!"
        exit 1
        
    else
        text="Incorrect deployment: $ENV. Available options: dev, stg, prod"
        echo  "----------"
        echo  "-----"
        echo -e "\e[31m$text\e[0m"
        echo  "-----"
        echo  "----------"
        
        exit 1
    fi
fi


set +a