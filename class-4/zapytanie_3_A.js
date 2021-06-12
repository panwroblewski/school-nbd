printjson(
    db.cwiczenia2.aggregate([
        {
            $group: {
                _id: '$job'
            }
        }
    ]).toArray()
);