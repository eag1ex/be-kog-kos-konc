## Info

Back log some information

```ts
// this function only works with getFunctions().taskQueue(...);
export const taskQueDispatchTrigger = functions.tasks // }) //   /*secrets: ["NASA_API_KEY"] */ // .runWith({
  .taskQueue({
    retryConfig: {
      maxAttempts: 5,
      minBackoffSeconds: 60
    },
    rateLimits: {
      maxConcurrentDispatches: 6
    }
  })
  .onDispatch(async (data) => {
    Logger(["[taskQueDispatchTrigger][data]", data], "debug");
  });
```

```ts
/**
 * we need to return success respond when at least 75% of each request has completed
 * @param queName provide que name from {queuesList}
 * @param completeRatio percentage between 0-100
 * @param checkFrequency how often to check again (millseconds)
 * @param maxWait max time to wait before we exit, regardless of {completeRatio}
 */
export const queResolveBuffer = async (
  queName: string[],
  completeRatio = 75,
  checkFrequency = 200,
  maxWait = 10000
): Promise<{ label: string; completed: number; timeout?: number }> => {
  const def = defer();

  if (completeRatio > 100) return Promise.reject("completeRatio cannot be gt>100");
  let exitMaxWait = maxWait;

  // give some time  for request to show in que
  await delay(1000);

  const list = async () => {
    return (await taskListQueues(queName)).length;
  };

  const INITIAL_TOTAL = await list();
  let result: number = 0;
  let label: string = "";
  const t: NodeJS.Timer = setInterval(async () => {
    if (exitMaxWait <= 0) {
      def.resolve({ label, completed: result, timeout: exitMaxWait });
      return clearTimeout(t);
    }

    const currentTotal = await list();
    const percent = percentage(currentTotal, INITIAL_TOTAL);
    result = 100 - percent;
    label = `${currentTotal}/${INITIAL_TOTAL}=${result}/100%`;

    if (result >= 75) {
      def.resolve({ label, completed: result });
      return clearTimeout(t);
    }
    exitMaxWait = exitMaxWait - checkFrequency;
  }, checkFrequency);
  return def.promise as any;
};

/**
 * we need to return success respond when at least 75% of each request has completed
 * @param queName provide que name from {queuesList}
 * @param completeRatio percentage between 0-100
 * @param checkFrequency how often to check again (millseconds)
 * @param maxWait max time to wait before we exit, regardless of {completeRatio}
 */
export const queResolveBuffer = async (
  queName: string[],
  completeRatio = 75,
  checkFrequency = 200,
  maxWait = 10000
): Promise<{ label: string; completed: number; timeout?: number }> => {
  const def = defer();

  if (completeRatio > 100) return Promise.reject("completeRatio cannot be gt>100");
  let exitMaxWait = maxWait;

  // give some time  for request to show in que
  await delay(1000);

  const list = async () => {
    return (await taskListQueues(queName)).length;
  };

  const INITIAL_TOTAL = await list();
  let result: number = 0;
  let label: string = "";
  const t: NodeJS.Timer = setInterval(async () => {
    if (exitMaxWait <= 0) {
      def.resolve({ label, completed: result, timeout: exitMaxWait });
      return clearTimeout(t);
    }

    const currentTotal = await list();
    const percent = percentage(currentTotal, INITIAL_TOTAL);
    result = 100 - percent;
    label = `${currentTotal}/${INITIAL_TOTAL}=${result}/100%`;

    if (result >= 75) {
      def.resolve({ label, completed: result });
      return clearTimeout(t);
    }
    exitMaxWait = exitMaxWait - checkFrequency;
  }, checkFrequency);
  return def.promise as any;
};
```
