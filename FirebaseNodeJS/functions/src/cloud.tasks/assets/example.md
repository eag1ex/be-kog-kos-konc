### example implementation of cloud tasks

#### Example

Actual example from {jobHandleNotification}: `./src/triggers/scheduler/notification.schedule.ts`

```ts
// please create or use existing schema types under CloudTasksSpace namespace
const payload: CloudTasksSpace.TriggerFunction<NotificationModel> = {
  functionName: "generalNotificationTrigger",
  snapData: data,
  id: memberId,
};

// the body of settings and payload to be send  to que: {notificationsQue}
// and the function that will handle the request (forwarded by the que) : {notificationsTwoFunction}
const settings: CloudTasksSpace.TaskCreate = {
  data: {
    uid:'uid-124'
    payload,
  },
  // preset for could task of each payload to set max retry
  presets: {
    // disable: true,
    maxRetries: 30,
  },
  // important settings must be set or cloud task will not know what todo
  queueName: queuesList.notificationsQue,
  functionName: taskFunctionList.notificationsTwoFunction,

  options: {
    // how long to wait between failed attempts to try again
    retry: { backoffSettings: { maxRetryDelayMillis: 2000 } },
  },
  // optional setting if you want this to execute in the future
  // schedule: 5 /** run next in 5 seconds */,
} as any;

await taskCreate(settings);
```
