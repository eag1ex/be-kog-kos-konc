### Collections Service

Class name: **CollectionsService**

This is a central service to all database queries _(it has not been implemented on the entire project yet, as it is a new development)_

### Notes

- To make use of this service please, use the operators in `db.operators.ts` these are boilerplate functions to the service.
- Please refer to class Types, class description and comments for more details
- With this service we can have control over all of database processes from just one location, and not scattered all over the project.

## Firebase logger

to check usage and see what was cleared, use these logger tags in firebase logger

```ts
// [CollectionsService][time] // will provide information on how long it take to get data for specific item
```

### Example

```ts
// before
db.collection(Collection.SERVICES).orderBy(listPaging.field, is_sorted).get();

// after
collectionQuery(Collection.SERVICES, { fieldPath: listPaging.field, directionStr: is_sorted });
```

### Database Operators ( db.operators.ts )

All CollectionsService caller functions and db wrappers should be declared inside `./db.operators.ts`

### Database Destructors ( db.destructors.ts )

All database extending, and custom destructuring functions should be declared inside `./db.destructors.ts `
