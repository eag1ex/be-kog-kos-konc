## DTO / Data transfer object

- An object that can do all pre flight logic that is finally parsed to another chain of events
- data that is send to `model.set` or `model.update` is transferred via DTA object to change update or modify when needed.
- we have more control over what is happening in the entire process of database changes
- we will use it to log reference to database document that is being updated, and we can trace it from firebase logs, it can help with debugging and QA testing.

### Logging / monitoring

We can monitor updates to the database by observing log changes for these firebase logger tags

```ts
// [set][dto] < any changes on set/create to document
// [update][dto] < any changes on update to document
// [dto] < if you just use this tag you can sso all set and update changes
```

To enable or disable the logging you can do it from : `/functions/src/config/globals.ts` > `{LOG_DTO_SET_ACTIONS}`

## Referencing

we currently use `src/config/db-collection.ts` together with models `src/models` (typescript declarations), < but those are not being used widely in the project

## example

```ts

updateDto = (data)=>{
    // some more logic can be utilized here
    return {
        ...data
        updated_date:new Date()
    }
}

setDto = (data)=>{
    // some more logic can be utilized here
    return {
        ...data
        updated_date:new Date()
    }
}

const data = {
    name:'johndoe'
}

// update dto
// now any new item that we pass the dto will always include any required presets
 // > modelRef.path provides query uri of the document location in database we can use to find the document
const output = updateDto(data, ["{functionName}", modelRef.path]);
await modelRef.update(output);


// set dto
const dd = setDto(obj, ["{functionName}", modelRef.path]);
await modelRef.set(dd, { merge: true });

```
