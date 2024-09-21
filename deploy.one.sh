#!/usr/bin/env bash

## This script is for deploy to environment, use it with care
### Only those with access token can deploy this project to environment

set -a

FORCE_COLOR=1
ENV=$1
DEPLOY_TOKENS="deploy.firebase.tokens.sh"

dateTime=$(date +%Y_%m_%d_%H%M%S)
if [[ ! -f $DEPLOY_TOKENS ]] ; then
    echo "File $DEPLOY_TOKENS doesnt exist, aborting deployment to $ENV"
    exit 1
fi
## provide comma seperated without spaces function list
FUNCTION_LIST="api"

source ./$DEPLOY_TOKENS

BACKEND_DIR=./FirebaseNodeJS/functions
cd $BACKEND_DIR
runProjectLintCheck(){

    # this is the same order as in husky script

    

    text="Running predeploy lint checks"
    echo -e "\e[36m$text\e[0m"
    echo  "----------"
    echo  "-----"

    yarn  prefix:deploy ||
    (   
        echo 'pre deploy check error';
        exit 1
    )

    yarn  husky:pretty:check ||
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
firebase --version 



if [ "$ENV" == "dev" ]; then

     NODE_ENV=development

     #runProjectLintCheck

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
     firebase deploy -P dev --token $FIREBASE_TOKEN --message "Release: $dateTime" --only functions:$FUNCTION_LIST
    
     echo  " "
     echo  "----------"
     echo  "Deployment complete!"
     exit 1
    fi
fi


set +a


