# ATTENTION

This is a top level overview of the project, without client source files

## kog-kos-konc-Backend

### About

More description coming soon

### Environment

He use environment files, you can find under /functions/\*

- `.env.dev`, `.env.staging`, `.env.prod`
- each developer use `.env.local` on their own machine its an identical copy of dev file `.env.dev === .env.local` but you can add or change any settings there without effecting other environments
- `.env.local` > runs locally on your machine.

### Running firebase emulator with local database

1. To run backend project with local database emulator, we need to make sure that emulator starts with
   `firestore,database`, and the emulator ports are configured in `FirebaseNodeJS/firebase.json`

2. You need to place the `db_dump_local` folder in `/FirebaseNodeJS/db_dump_local` , or it wont work and database will be empty!

3. the script executing firebase with local database

- `/$ yarn serve:db` # _from /functions folder_
- you can also run with bash: `bash start.database.sh` from project root.

4. Now when you start the FE/hosting application it will connect to local database

- any changes you make you also we remembered only on your local database.
- follow instructions on how to run on FE/hosting from that project `readme.md`

**In additional**

- You may also need to install correct Java version
- On Linux and possibly on IOS you can run this script from project root : `./start.database.sh`
- If you experience issue with port being taken you need to kill it with `npx kill-port`, each port is the emulator running on your system

```sh
# npx kill-port {portNumber}
npx kill-port 9099
```

### Micro-services

We use many services in this project, but there are 3 particular we need in order to fix the project scalability issue, this fix has been implemented by new team, after project was released to production.

**current issue**

- current issues (in process of fixing, date:02/03/2022)
  - firebase triggers are not handled very well as they are called loosely and un/managed, meaning we dont control when and how many times they can execute and by who
  - database queries are quite big and frequent inside loop iterations causing overload to database and issues with performance, when calling to database by admin app and mobile app

**current solution**
we provided 3 microservice

- `GlobalNodeProcessCacheService`, to cache database queries.
  - please refer to readme.md at `FirebaseNodeJS/functions/src/services/microservice/node.cache.service/readme.md`
- `TakeRelease` Data enqueuing service that will consume all requests and release them at time intervals

  - please refer to readme.md at `FirebaseNodeJS/functions/src/services/microservices/take-release/readme.md`

- `CollectionsService`, act as a central location to all database queries, so we control it from just one please
  - please refer to readme.md at `FirebaseNodeJS/functions/src/services/collections.query.service/index.ts` (_work in progress)_

### Cloud Tasks

This project now supports cloud tasks to efficiently scale and perform more synchronous actions, without overloading
for more information please read from **readme.md** at: `FirebaseNodeJS/functions/src/cloud.tasks/readme.md`

### Database

We use Firebase Firestore database _(not to be confused with realtime database!)_

There are 2 ways of using database in local development:

1. Point to remote Firestore database and run functions without all other emulators: `firebase emulators:start --only functions`

   - you can see in `firebase.app.ts` file `{databaseURL}` is pointing to remote database > (alias)/DEV, (project)/lunch-nao-dev

2. Run all emulators `firebase emulators:start` using imported database from (project)/lunch-nao-dev

- How to import and use database locally, so you can test all CRUD operations, such as: create, update, delete, follow this tutorial: https://medium.com/firebase-developers/how-to-import-production-data-from-cloud-firestore-to-the-local-emulator-e82ae1c6ed8
- this is only one time operation, and you do not import everytime you run local emulator, unless you want fresh database again!

```sh
# will list all available projects from firebase
gcloud projects list

# this is optional, it will default to whatever is your default project alias (DEV)
gcloud config set project your-project-name

# export database to Google Cloud Storage bucket, for extraction in next part
gcloud firestore export gs://your-project-name.appspot.com/your-choosen-folder-name


## your-project-name > lunch-nao-dev
## your-choosen-folder-name > lunch-nao-dev.dump
# this will export database to your your-choosen-folder-name
gcloud firestore export gs://{your-project-name.appspot}.com/{your-choosen-folder-name}


# navigate to where you want to import your database, usually, the project directory
cd /backend
mkdir db_dump_local
cd /db_dump_local
# export/copy to your local machine, database name will be copied to > db_dump_local
gsutil -m cp -r gs://{your-project-name}.appspot.com/{your-choosen-folder-name} .

# to import database to local database emulator
firebase emulators:start --import ./db_dump_local/{your-project-database-folder}

```

**db_dump_local**

- we use ./FirebaseNodeJS/db_dump_local as location for local database, if you dont run the above script, you can request this file from another developer who already got the database dump

- _example:_
  ![db_dump_local](https://mp-xyz.tinytake.com/media/1277b67?"db_dump_local")

<br/>
<br/>

### Release and conventional commits

**_ATTENTION_** : please do not remove {root}/package.json it is needed for conventional commits (explained bellow) to work correctly, do no use this file to install any other packages except for top level upgrades.

Ideas taken from: https://mokkapps.de/blog/how-to-automatically-generate-a-helpful-changelog-from-your-git-commit-messages
and from: https://www.conventionalcommits.org/en/v1.0.0-beta.2/

This project now support creating of releases via CLI command.
The release feature should only be used when issuing next release cycle of the project, the release should always be maintained, all commits need to follow valid formatting that will help generating final `CHANGELOG.md` file.
If your commits do not follow valid format you will not be able to commit;
**Example**

```sh
# this will fail
git commit -m "This is my new feature"
✖#subject may not be empty [subject-empty]
✖#type may not be empty [type-empty]
# this will pass
git commit -m " feat: This is my new feature"
git commit -m " fix: This is my new fix"
git commit -m " refactor: This is my new refactor"
git commit -m " perf: This is performance adjustments"
git commit -m " style: This is some code styling"
git commit -m " docs: This is some code documentations"
git commit -m " misc: This is some dependency adjustments, or small change"
git commit -m " test: This is for unit testing"
```

**Commit format**
To create valid commits please look inside package.json > "standard-version": {...}
you can use the following standards: `feat|fix|refactor|misc`

- feat > Feature
- fix > bugfix or hotfix
- refactor > Refactor
- misc > Miscellaneous (_anything that relates to package, dependency change_), deletion of old files, text or style changes
- perf > Performance, any performance improvements
- test > add unit testing (will not show in release)
- style > code formatting (will not show in release)
- docs > code documentation (will not show in release)
  **How does it work**
  This package will generate changelog.md file with latest commits and will bump your project version

1. _conventionalcommits_ > https://www.conventionalcommits.org/en/v1.0.0-beta.2/
   - Hook runs via husky validating your commits
2. _standard-version_ > https://www.npmjs.com/package/standard-version
   - After running release commands (per below), it will generate new `CHANGELOG.md` file from the last created git tag entry, for this to work correctly and display all commit messages you need to follow commit standards.
     - Every release increments the project version so make sure you know what semantic versioning is before you release something, my recommendation is to read this first: S**emantic Versioning 2.0.0** https://semver.org/

- _types: https://stackoverflow.com/questions/66856017/how-can-i-custom-config-changelog-md-using-standard-version-npm-package_
  **how to initiate a new release in correct order**
  You need to be at project root `./`, if not already installed, run: `yarn add standard-version`, if doesnt work you may also need to install it globally so, `npm i -g standard-version`
  new release:

```sh
# how to bump
## patch, this will increment x.x.1
yarn release:patch
## minor,  this will increment x.1.x
yarn release:minor
## major, this will increment 1.x.x
yarn release:major
## manually set version
## version increments: major | minor | patch
yarn release --release-as {increment}
yarn release --release-as 1.1.0
```

**Correct order of execution**

1. First create new release branch
2. Next create new release with `standard-version` package to generate/update CHANGELOG.md file, it will append and populate this file with latest commits correctly formatted according to **conventionalcommits**.
3. You need to commit new changes because `package.json` and `CHANGELOG.md` were updated.
4. Finally push to remote branch
5. Optionally so we can track all git tag changes, if you did not set it to automatic, please do the following:

```sh
#  Git 1.8.3
git push --follow-tags
## or set it up one time
git config --global push.followTags true
#### also useful commands
## to pull tags to your local
git pull --tags
## see all remote tags
git ls-remote --tags origin
## see all local tags
git tag
## reference: https://stackoverflow.com/questions/5195859/how-do-you-push-a-tag-to-a-remote-repository-using-git#5195913
```

- before pushing new release branch to remote git:
  - you need to run release command, example: `yarn release:patch`, you may also want to run this:
    `git push --follow-tags` > it will push all local tags to remote branch
    **new release example**

* Remember we only need to create release one time: `dev>staging>production`
* Remember every time you call `yarn release:{version_increment}` it will update project version and the change log.

```sh
## develop, any new changes release to staging
### at project root ./
git checkout -b release_25/staging
## if there are no breaking changes, or no new feature, then
yarn release:patch
## if there are new features, then
yarn release:minor
## if there are major changes to the project, that are not compatible, then
yarn release:major

## you can also skip version bump, commit and tag by adding this to above command or do the below\
npx standard-version --skip.bump --skip.commit --skip.tag


### finally push your release branch to remote
git push
```

## Todos

test pipeline ...
...
