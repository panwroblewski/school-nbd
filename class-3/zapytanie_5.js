printjson(
    db.cwiczenia2.find(
        {
            $expr: {$gte: [{$dateFromString: {dateString: "$birth_date"}}, new Date(2001, 0, 1)]}
        },
        {first_name: 1, last_name: 1}
    ).toArray()
);