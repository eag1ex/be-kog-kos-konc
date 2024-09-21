## Cloud Tasks and permissions

#### IAM Cloud Tasks and permissions for production

When deploying we need to make preparation of rules and actions to be performed when dealing with **Cloud Tasks** - these only have to be done once on every environment.

1. To enable Cloud task services, go to https://console.cloud.google.com/ and search for Cloud Tasks, then enable it.

- Next search for **Compute Engine** and enable it as well, finlay couple more steps, go to this https://cloud.google.com/tasks/docs/tutorial-gcf follow prompts and enable Apis.
  ![Scheme](https://i.imgur.com/dzhlYkE.png)

2. Create some **Cloud Task Queues** then go to console panel and see the result
   ![Scheme](https://i.imgur.com/Xd6hdCY.png)

- To create task queues you need to execute these calls according to `./config.ts`

```sh
# log in to gcloud
gcloud auth login


## this needs to run only 1 time per project environment
### cloudtasks.enqueuer
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member=serviceAccount:${PROJECT_ID}@appspot.gserviceaccount.com \
  --role=roles/cloudtasks.enqueuer


# select the project name
## list projects and set to desired one
### refer to : FirebaseNodeJS/.firebaserc
gcloud config set project kog-kos-konc-dev

## then create new que

gcloud tasks queues create {que-name}
## should display something like: Created queue [us-central1/example-que]

```

3. Each task queue is assigned to cloud function with some specific permissions in order to be triggered.

- First create general cloud function distinguished from normal functions, best you put them in different location just like in our current setup ( `./src/cloud.tasks` ), then you need to deploy the function and assign it permissions.

```sh
## each new exported and deployed function needs to be executed with this script, also permissions for **allAuthenticatedUsers** need to be added, per explanation from ./cloud.tasks/readme.md

gcloud functions add-iam-policy-binding $FUNCTION_NAME \
  --region=us-central1 \
  --member=serviceAccount:${PROJECT_ID}@appspot.gserviceaccount.com \
  --role=roles/cloudfunctions.invoker
```

4. You need to set permissions on individual functions at https://console.cloud.google.com/ under Cloud Functions find the function you deployed-and-assigned to Cloud Task Queue then update its permissions

   - Remove **allUsers** and replace it with **allAuthenticatedUsers**
     - grant new permission and choose Principal called: **allAuthenticatedUsers** , `Role > Cloud functions > cloud function invoker`.
       ![Scheme](https://i.imgur.com/IUBmdZP.png)
       ![Scheme](https://i.imgur.com/LKrg39j.png)

5. Setting strict rules to Cloud Tasks, you dont want everyone to be able to delete anything under Cloud Task Queue especially on production, only few people should have this privilege to avoid any incidents. Read more about user product-level predefined roles at
   https://firebase.google.com/docs/projects/iam/roles-predefined-product

- For **production** you need to limit editor rules and downgrade some users to **Viewer** level, search IAM from cloud.google.com then select `VIEW BY ROLES > EDITORS >` then downgrade permissions, this will ultimately remove access to delete anything.
  ![Scheme](https://i.imgur.com/QTDN0P3.png)
  - To undo the change go to `VIEW BY ROLES > VIEWERS` and change it back.
