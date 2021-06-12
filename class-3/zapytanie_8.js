printjson(
    db.cwiczenia2.updateMany(
        {"location.city": "Moscow"},
        {$set: {"location.city": "Moskwa"}}
    )
);