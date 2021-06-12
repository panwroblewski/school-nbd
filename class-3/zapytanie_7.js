printjson(
    db.cwiczenia2.remove(
        {
            $expr: {$gte: [{$toDouble: "$height"}, 190]}
        }
    )
);