### Global Node Cache Service

- update : this is updated documentation on cache microservice
  Class name: **GlobalNodeProcessCacheService**

This is a caching service that works together with node Global cache of currently running process, can only be stored independently on each process running when class in reinitialized from another controller or module it will lookup the available cache on node `global` and merge it together.

## Firebase logger

to check usage and see what was cleared, use these logger tags in firebase log explorer
ps: some of these have been commented out to avoid crowded logging.

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

### api shortcodes

we have one short code api for setting cache

- `getNodeCache(cacheRef: string, dataCB: () => Promise<any>, service: GlobalNodeProcessCacheService | undefined, expire?: number)`: when calling this method it will first check if existing data already expired, and the clear it, then call `dataCB()` callback and set new cache, and finally return the expected value

### Example

How to implement cache microservice on existing classes

the cache will ignore subsequent calls to database within the set {expire} period being 6 seconds, so if we call the function `callOperator()` multiple times within that period it will only return the cache, when the time is over 6 seconds that cache is cleared and new value is set.

When there is some manual logic that requires latest data on the item that has caching implemented, we need to find the source function call, it usually starts at api call, so add clear cache there `globalNodeProcessCacheService.removeCache(cacheRef)`, find the correct `cacheRef` and map to correct `document_id` ( if any )

```ts

// imports
  import { getNodeCache, GlobalNodeProcessCacheService } from "./microservices";
  import { CacheExpiryType } from "../types";

  // code
  // import global cache settings and override expire depending on circumstances
  const config: CacheExpiryType = { ...GLOBAL.nodeCache, expiry: 6000 };
  class Example {
     globalNodeProcessCacheService: GlobalNodeProcessCacheService = null as any;
     constructor() {
      this.globalNodeProcessCacheService = new GlobalNodeProcessCacheService(config);
      this.updateOperator('4', {preference_notification:'DUMMY_DATA'}){
    }


    // it will return cached data with persistance to every 6 seconds
    async getOperator(coachId){

      // if we did no use the cache, we would just call like this:
      // > const snap = db.collection(Collection.COACHES).doc(coachId).get()

     // when using cache we need to set cache reference path and always use the same path ref of calling document
      const cacheRef = `${Collection.COACHES}/${coachId}`;

      // assign  correct type so we know what to expect, since cache can return what ever you add to it
      const snap: FirebaseFirestore.DocumentSnapshot<FirebaseFirestore.DocumentData> = await getNodeCache(
        cacheRef,
        () => db.collection(Collection.COACHES).doc(coachId).get(),
        this.globalNodeProcessCacheService,
        /** expire **/ // << can override expire settings to future number in {ms}
      );

      return snap.data()
    }

    // update document operator
    updateOperator(id:string, d:any){
      const snapRef = db.collection(Collection.COACHES).doc(id)
       const data = {
        preference_notification:{
         ...d
        }
       }
       await snapRef.set(setDto(data, ["updateOperator", snapRef.path]), { merge: true });
    }

    // initialize
    async init(){


      // list of dummy ids
      for(let coachId in ['0','1','2','3','4']){

        // updates
        await this.updateOperator(coachId,/**  some data >>**/{preference_notification})

        // gets
        if(id==='4'){
          // access cached value
          // previously in constructor we set initial data
          // this call will return cached data if accessed before the {expire} time
          const oldData =  await this.getOperator(coachId)

          // clear cache
          // this block will clear specific cache
          const cacheRef = `${Collection.COACHES}/${coachId}`;
          this.globalNodeProcessCacheService.removeCache(cacheRef);

          // this block will access latest data because we cleared the cache
          const newData =   await this.getOperator(coachId)

        }
       // continue as usual
        else{
          await this.getOperator(coachId)
        }
      }

    }
  }

new Example().init()


```

### Notes

- Please refer to class Types, class description and comments for more details
- cache is stored under node process on `global.cacheV2`
- be careful about long expiry you can run out of memory, or caching issues
  - fortunately the function will check for critical memory and auto clear for you, but its not guaranteed if goes up really quickly
  - we also have manual function that we call call to manually remove or reduce all cache : `nodeCacheMemoryCheck(criticalBuffer = 10, memoryBuffer: number = GLOBALS.nodeCache.memoryBuffer)`
  - we also use the method called `memoryAllocation()` that uses `v8.getHeapStatistics()` to check system memory, it works together with **expiry** and **memoryBuffer** setting.
