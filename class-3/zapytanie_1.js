// printjson(
//     db.cwiczenia2.findOne({})
// ); ???


printjson(
    db.cwiczenia2.find({first_name: "Gregory", last_name:"Anderson"}).toArray()
);