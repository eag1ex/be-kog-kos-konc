## Logs

Write any important developer comments

### Reduce memory/instance allocation limits

to reduce issues with memory and instance allocation

resources:
https://cloud.google.com/functions/docs/configuring/max-instances#limits_best_practices
https://firebase.google.com/docs/functions/beta/manage-functions

### environment variable

https://firebase.google.com/docs/functions/config-env
https://firebase.blog/posts/2016/07/deploy-to-multiple-environments-with

### firebase interesting concepts

Build and Debug Firebase Functions in VSCode
https://medium.com/@david_shortman/build-and-debug-firebase-functions-in-vscode-73efb76166cf

### firebase setup local database

https://medium.com/rpdstartup/development-with-the-firebase-emulators-suite-f53bb7121442
https://medium.com/rpdstartup/setting-up-a-fully-functional-database-in-firebase-emulator-b0199fff0252

### nice symbols

https://coolsymbol.com/

### use of redis

https://asserted.io/posts/simplified-firestore-with-redis

redis with cloud functions
https://cloud.google.com/memorystore/docs/redis/connect-redis-instance-functions

### read write rules

security rules:
https://firebase.google.com/docs/firestore/security/overview
https://stackoverflow.com/questions/56487578/how-do-i-implement-a-write-rate-limit-in-cloud-firestore-security-rules

## listed to all firebase changes

## reduce the number of reads

https://medium.com/firebase-tips-tricks/how-to-drastically-reduce-the-number-of-reads-when-no-documents-are-changed-in-firestore-8760e2f25e9e

## how to run pubsub manually in local emulator

source: https://stackoverflow.com/questions/61253788/how-to-use-firebase-emulators-pubsub-to-test-timed-functions-locally

## to deploy function unauthenticated

cd to /functions location and call this code

```sh
gcloud functions deploy {functionName} \
  --trigger-http \
--allow-unauthenticated \
```

### firebase documentation

https://googleapis.dev/nodejs/google-gax/latest/interfaces/CallOptions.html

### Create diagrams in markdown

https://github.com/mermaid-js/mermaid

### release_10/staging

Some commented code has been removed due to request from other developer, we can access this code on this branch `git checkout release_11/staging` to review changes and undo's
https://bitbucket.org/.../pull-requests/315

### Maximum concurrent requests

When there is concurrency on cloud function triggers, it means the process can multiply when multiple requested are being issued, the down side if this is, if you have some logic stage persistance (local variable memory ) it will not keep shared scope in one place, so you need to send {maxInstances:1} to only one process, this is only best for small operations or operations being forwarded to the Cloud Tasks.

Remember that Cloud tasks should not run large processes, they should work like payload batches with chunks of data over multiple Cloud tasks in the que.

source: https://cloud.google.com/run/docs/about-concurrency

### useful typescript type assignments

https://stackoverflow.com/questions/55142177/how-to-build-a-type-from-enum-values-in-typescript
https://bobbyhadz.com/blog/typescript-create-type-from-object-keys

## Using yarn with firebase

`package.engine` rule for yarn should be set.

**source:** https://cloud.google.com/docs/buildpacks/nodejs#using_yarn
**source:** https://stackoverflow.com/questions/76427975/firebase-functions-deployment-error-cant-resolve-command-plugin-not-found

## Cloud tasks and 2nd gen functions

cloud tasks offer new options and performance solutions on 2nd gen functions, we are currently on 1st gen

source: https://firebase.google.com/docs/functions/task-functions?gen=2nd
