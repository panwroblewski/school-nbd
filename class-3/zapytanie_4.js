printjson(
    db.cwiczenia2.find(
        {
            $expr: {
                $and: [
                    {$gte: [{$toDouble: "$weight"}, 68]},
                    {$lt: [{$toDouble: "$weight"}, 71.5]}
                ]
            }
        }
    ).toArray()
);