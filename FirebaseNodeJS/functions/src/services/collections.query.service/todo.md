## Some Todo scrips

Stashed scripts for later

```ts


 //ATTENTION more research needed please dont delete
//---------------------------------------------------

    const bookedRef = await db.collectionGroup(Collection.ITEM).where("date", "==", date).where("is_canceled", "==", false).get();

   async testCall() {
      const coachList = [
        "XLuMzO37JtO7m8nVJGFm",
        "gzv2NAQh1K0xPdrDD6CV",
        "RPzx3YLz1q8LGium2TLu",
        "FyYQWEV7AXYcGvnfrJ9M",
        "iwRHv6lSSp9y1XzLleOe",
        "NuJw3rcAidQUgiGfRzpW",
        "RbIgF20Gvj9ssyTp5sJ5",
      ];

     const dateList = ["2023-01-24", "2023-01-25", "2023-01-26"];
     const coatchIdWithWorkTime = "0H15iuyGb76ZGJmNzWeR";
     const coachWorkTimeRef = db.collection(Collection.COACHES).doc(coatchIdWithWorkTime).collection(Collection.WORKTIMES);
      .doc(selectedDate);
     const coachWorkTimeSnap = await database.getDoc(coachWorkTimeRef, "getCoachWorkTimeByDate");
     const coachWorkTimeData = coachWorkTimeSnap.data();
   }

    const coachWorkTimeRef = db.collection(Collection.COACHES).doc(coachId).collection(Collection.WORKTIMES).doc(selectedDate);




 //ATTENTION more research needed please dont delete
//---------------------------------------------------

   db.collectionGroup(Collection.ITEM)

/**
 * @param collectionName should refer to {collection} type items
 * @param itemName name of item you want to search for
 * @param query.base if we dont any specific query run all
 */
   collectionGroup(collectionName: string, query?: WhereOperator) {
     try {
       myConsole.time(`[${uuid()}][collectionGroup][${collectionName}]`);

       if (query) {
         this.data.collectionGroup.promise = db
           .collectionGroup(collectionName)
           .where(...whereOperator(query))
           .get()
           .then((n) => {
             myConsole.timeLog(`[collectionGroup][${collectionName}]`, "data received");
             myConsole.timeEnd(`[collectionGroup][${collectionName}]`);
             Logger([`[collectionGroup][${collectionName}][data]`, { query: query }, n.docs.length]);
             return n;
           });
       } else {
          # TODO find out if we can add better query sorting
         return (this.data.collectionGroup.promise = db
           .collectionGroup(collectionName)
            .where(...whereOperator(query))
           .get()
           .then((n) => {
              n.forEach((item) => {
                console.log("item", item);
              });
             myConsole.timeLog(`[collectionGroup][${collectionName}]`, "data received");
             myConsole.timeEnd(`[collectionGroup][${collectionName}]`);
             Logger([`[collectionGroup][${collectionName}][data]`, n.docs.length]);
             return n;
           }));
       }
     } catch (err) {
       this.data.error = Promise.reject(err);
     }
     return this;
   }

   async collectionItemsCanceled() {
     const bookedRef = await db.collectionGroup(Collection.ITEM);
      .where("date", "==", date).where("is_canceled", "==", false).get();
   }

/**
 * Get all items in Collection.COACHES
 * @example db.collection(Collection.COACHES)
 */
   collectionGroupCoaches() {
     this.data.collectionGroupCoaches.promise = db
        .collection(Collection.COACHES)
        .doc().c
       .collectionGroup(Collection.WORKTIMES)
       .get()
       .then((n) => {
         return n;
       });
      .doc(coachId).collection(Collection.WORKTIMES).doc(selectedDate);
      SECTION  const bookedRef = await db.collectionGroup(Collection.ITEM);
      .where("date", "==", date).where("is_canceled", "==", false).get();
     return this;
   }

   filterWith(collectionName: "collectionGroupCoaches", query: any) {
     try {
       const def = defer();
       if (collectionName === "collectionGroupCoaches") {
         return this.data.collectionGroupCoaches.promise.then((n) => {
           const list = forInSnapLoop(n);

           const resp = list.filter((x) => x.exists && x.id === query.id);

           console.log(
             "filterWith/resp",
             resp.map((nn) => nn.data())
           );
         });
       } else {
         return Promise.reject("wrong collectionName selected");
       }
     } catch (err) {
       Logger(["[filterWith]", err], "error");
     }
   }



   export class CollectionsService {
  // data: CollectionsServiceData = {
  //   collectionGroupCoaches: { promise: null, data: null },
  //   collectionGroup: { promise: null, data: null },
  //   error: null,
  // } as any;
  //   collectionCoaches: null
  // } as CollectionsServiceData;

  constructor() {

    // posible solution for child collections
    // https://cloud.google.com/firestore/docs/samples/firestore-data-get-sub-collections
    // const sfRef = db.collection(Collection.WORKTIMES).doc("0H15iuyGb76ZGJmNzWeR");
    // const collections = sfRef.listCollections();
    // collections.then((n) => {
    //   n.forEach((collection) => {
    //     console.log("Found subcollection with id:", collection.id);
    //   });
    // });
    // ATTENTION this migth work! https://firebase.google.com/docs/firestore/query-data/queries#collection-group-query
    // const querySnapshot = db
    //   .collectionGroup(Collection.WORKTIMES)
    //   // .where("type", "==", "museum")
    //   .get();
    // querySnapshot.then((n) => {
    //   n.forEach((doc) => {
    //     console.log("subcollection=>", doc.id, " => ");
    //   });
    // });
      // db.collection(Collection.COACHES)
    //   // .select(Collection.WORKTIMES)
    //   .get()
    //   .then((n) => {
    //     console.log(
    //       "collectionGroup/select",
    //       n.docs.map((nn) => nn.get("worktimes"))
    //     );
    //   });
    // this.collectionObservers(Collection.SERVICES);

```
