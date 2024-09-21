## examples scripts

```sh

# current script for pipeline deployment
# Dev-kog-kos-konc-Backend

# original
firebase deploy --project $(firebase-app-name) --token $(firebase-token) --message "Release: $(Build.BuildNumber)"

# new /dev
firebase functions:config:unset env && firebase functions:config:set env.node_env="$(node-env)" && firebase deploy --project $(firebase-app-name) --token $(firebase-token) --message "Release: $(Build.BuildNumber)"

# new /staging
firebase use staging --token $(firebase-token) && firebase functions:config:unset env --token $(firebase-token) && firebase functions:config:set env.node_env="$(node-env)" --token $(firebase-token) && firebase deploy -P staging --token $(firebase-token) --message "Release: $(Build.BuildNumber)"


# new /production
firebase use prod --token $(firebase-token) && firebase functions:config:unset env --token $(firebase-token) && firebase functions:config:set env.node_env="$(node-env)" --token $(firebase-token) && firebase deploy -P prod --token $(firebase-token) --message "Release: $(Build.BuildNumber)"

```
