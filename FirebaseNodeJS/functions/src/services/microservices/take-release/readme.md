# Take Release Microservice

Data enqueuing service that will consume all requests and release them at time intervals

### Why

- it helps with congested requests being executed to frequently instead of batches
- the ideal usage for this service is to use it with firebase triggers, when it performs only **single** actions per request, where it should perform **multiple** actions per request.

### Logging

```ts
// you can use [TakeRelease] to see all relevant logs when class function debug=true was enabled
// [TakeRelease][que] // currently running setInterval
// [TakeRelease][size][send] // how much was available to send
// [TakeRelease][lastMean][average] // time between each take
// [TakeRelease][size][cleared][reset] // how much was reset after time out completed
// [TakeRelease][size][que][timeout][callback] // when timeout was cleared and last callback per time out was called
```

## Usage

The main use with high computation jobs that can be delayed and released later

### Example

```ts

// NOTE  tested on April 5
// the best configuration {releaseIndex:120,interval:1500,timeout:3000}
const config: TakeReleaseConfig = {
  releaseIndex: 120, // release every {releaseIndex} items
  // or release every interval which ever sooner
  // cannot be higher then {timeout}
  interval: 1500,
  // any reminding items in que to be executed on timeout
  timeout: 3000,

  // you need to set debug=true to learn {lastMean} time then you can set it for this job
  // if not set it will be automatic
  // meanTime: 200
};

const tr = new TakeRelease(config,/**debug */true);
let exampleData = [...] // long list of items in array


const runJOb = ()=>{
  let inx = 0

  let time = setInterval(async()=>{

      let d = exampleData[inx];
      if (d) {

      console.log('[size]', tr.size);

        tr.take(d) // << keep adding new data
        .onDone((release)=>{
            // the last chunk of data, calculated from interval
            console.log('release', release);
            runJOb()
            console.log('run another job')
        }).release() // release new data


      } else {
        clearInterval(time);
        // runJOb()
        // console.log('run another job')
        return;
      }

      console.log('-- check --')
      inx++
  },50)
}; runJOb()


```
