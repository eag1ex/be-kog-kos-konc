### Global Node Cache Service

Class name: **GlobalNodeProcessCacheService**

This is a caching service that works together with node Global cache of currently running process, can can only be stored independently on each process running, when the class in reinitialized from another controller or module it will lookup the available cache on node `global` and merge it again.

### Notes

- Please refer to class Types, class description and comments for more details
- the cache is stored under node process on `global.cacheV2`
- be careful about long expiry you can run out of memory
  - fortunately the function will check for critical memory and auto clear for you, but its not guaranteed if goes up really quickly
  - we also use the method called `memoryAllocation()` that uses `v8.getHeapStatistics()` to check system memory, it works together with **expiry** and **memoryBuffer** setting.

## Firebase logger

to check usage and see what was cleared, use these logger tags in firebase logger

```ts
// [GlobalNodeProcessCacheService][memoryUsage] // current memory and usage

// [GlobalNodeProcessCacheService][cache_size] // how many items were cached

// [GlobalNodeProcessCacheService][bufferLimit] // check current buffer limit based on setting in: FirebaseNodeJS/functions/src/config/globals.ts > {globalAppOptions}

// how much memory was cleared based on {globalAppOptions} setting
// [GlobalNodeProcessCacheService][cleared]
// [GlobalNodeProcessCacheService][isExpired][cleared]
// GlobalNodeProcessCacheService][checkCriticalMemory][cleared]
// [cacheMemoryCheck][cleared]
```

###

### Example

```ts
/**
 *  opts:
 * expiry : when to expire cache item(id) in memory
 * memoryBuffer: at which point  memory is at 20 has 20% available space we should reduce it by {reduceCacheSize}
 * reduceCacheSize: how much size to reduce when we reach memoryBuffer limit
 *
 */

const config = { expiry: 7000, memoryBuffer: 20, reduceCacheSize: 50 };
const cache = new GlobalNodeProcessCacheService(config);

const format1 = cache.formatCache("some data1", "my_id_abc", "cacheName_1");
const format2 = cache.formatCache("some data2", "my_id_abcf", "cacheName_2");
cache.setCache(format1);
// keep setting new items
cache.setCache(format2);

cache.getCache(format1.id); // >> data | null
cache.getCache(format2.id); // >> data | null

await cache.getAllCache(); //  all cache data[]

// because the data here is accessed after expiry it will already be cleared
setTimeout(async () => {
  cache.getCache(format1.id); // >>  null
  cache.getCache(format2.id); // >> null
  await cache.getAllCache(); // >> []
}, config.expiry + 1000);
```
