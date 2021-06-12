printjson(
    db.cwiczenia2.find({sex: "Male", nationality: "Germany"}).toArray()
);