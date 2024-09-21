#!/usr/bin/env bash

# This script is for updating gcloud permissions on kog-kos-konc project
## In order for cloud tasks to work you first need to enable: Cloud Task product and the App Engine, then follow instructions here: https://cloud.google.com/tasks/docs/tutorial-gcf
### Please read more documentation at FirebaseNodeJS/functions/src/cloud.tasks/readme.md
### run this script from same directiory



set -a



FORCE_COLOR=1
ENV=$1
BACKEND_DIR=./FirebaseNodeJS/functions



text="Starting gcloud"
echo  "----------"
echo  "-----"
echo -e "\e[1;33;4;44m$text\e[0m"
echo  "-----"
echo  "----------"


#### - update cloud task permissions
#### - update cloud task function permissions 
runGcloudSetup(){
    
    ## project id must exist before this function is executed!
    gcloud config set project $PROJECT_ID

    ## cloudtasks.enqueuer
    gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com \
  --role=roles/cloudtasks.enqueuer    

    # list of available cloud task ques
    ## NOTE if any of these change to need to update the list here
    ### the list here cooresponds to FirebaseNodeJS/functions/src/cloud.tasks/config.ts settings
    gcloud tasks queues create update-available-dates-que
    gcloud tasks queues create create-booking-que
    gcloud tasks queues create update-available-coach
    gcloud tasks queues create notifications-que
    gcloud tasks queues create create-general-notification-que
    

    # all the functions need to be deployed already before we can execute this list
    ## setting permissions to be allowed execution via cloud task
    ### cloudfunctions.invoker

    gcloud functions add-iam-policy-binding notificationsFunction \
  --region=us-central1 \
   --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com  \
  --role=roles/cloudfunctions.invoker

    # gcloud functions add-iam-policy-binding notificationsTwoFunction \
    # --region=us-central1 \
    # --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com  \
    # --role=roles/cloudfunctions.invoker

   gcloud functions add-iam-policy-binding generalNotificationCreateFunction \
    --region=us-central1 \
    --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com  \
    --role=roles/cloudfunctions.invoker

    gcloud functions add-iam-policy-binding notificationsThreeFunction \
    --region=us-central1 \
    --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com  \
    --role=roles/cloudfunctions.invoker

    gcloud functions add-iam-policy-binding updateAvailableDateFunction \
    --region=us-central1 \
    --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com  \
    --role=roles/cloudfunctions.invoker

    gcloud functions add-iam-policy-binding updateAvailableDateTwoFunction \
    --region=us-central1 \
    --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com  \
    --role=roles/cloudfunctions.invoker

     gcloud functions add-iam-policy-binding updateAvailableDateThreeFunction \
    --region=us-central1 \
    --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com  \
    --role=roles/cloudfunctions.invoker


     gcloud functions add-iam-policy-binding updateAvailableDateFourFunction \
    --region=us-central1 \
    --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com  \
    --role=roles/cloudfunctions.invoker


    # gcloud functions add-iam-policy-binding createBookingFunction \
    # --region=us-central1 \
    # --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com  \
    # --role=roles/cloudfunctions.invoker

    gcloud functions add-iam-policy-binding updateAvailableCoachFunction \
    --region=us-central1 \
    --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com  \
    --role=roles/cloudfunctions.invoker

    gcloud functions add-iam-policy-binding generalNotificationCreateFunction \
    --region=us-central1 \
    --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com  \
    --role=roles/cloudfunctions.invoker

}


if [ "$ENV" == "dev" ]; then

     NODE_ENV=development
     PROJECT_ID=kog-kos-konc-dev

     text="Updating on $PROJECT_ID ($NODE_ENV)"
     echo -e "\e[36m$text\e[0m"
     echo  "----------"
     echo  "-----"

     cd $BACKEND_DIR

     runGcloudSetup


     text="Update on $PROJECT_ID complete!"
     echo  "----------"
     echo  "-----"
     echo -e "\e[36m$text\e[0m"
     echo  "-----"
     echo  "----------"
     exit 1
     
else

    if [ "$ENV" == 'stg' ]; then

        NODE_ENV=staging
        PROJECT_ID=kog-kos-konc-test

        text="Updating on $PROJECT_ID ($NODE_ENV)"
        echo -e "\e[36m$text\e[0m"
        echo  "----------"
        echo  "-----"

        cd $BACKEND_DIR

        runGcloudSetup

        text="Update on $PROJECT_ID complete!"
        echo  "----------"
        echo  "-----"
        echo -e "\e[36m$text\e[0m"
        echo  "-----"
        echo  "----------"
        exit 1

    fi

     if [ "$ENV" == 'prod' ]; then

            NODE_ENV=production
            PROJECT_ID=kog-kos-konc

            text="Updating on $PROJECT_ID ($NODE_ENV)"
            echo -e "\e[36m$text\e[0m"
            echo  "----------"
            echo  "-----"

            cd $BACKEND_DIR

            runGcloudSetup

            text="Update on $PROJECT_ID complete!"
            echo  "----------"
            echo  "-----"
            echo -e "\e[36m$text\e[0m"
            echo  "-----"
            echo  "----------"
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