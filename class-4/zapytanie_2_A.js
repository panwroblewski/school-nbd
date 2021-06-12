printjson(
    db.cwiczenia2.aggregate([
        {
            $project: {
                credit: 1
            }
        },
        {
            $unwind: {
                path: '$credit'
            }
        },
        {
            $addFields: {
                convertedBalance: {$convert: {input: '$credit.balance', to: 'double'}}
            }
        },
        {
            $group: {
                _id: '$credit.currency',
                sum: {
                    $sum: '$convertedBalance'
                }
            }
        }
    ]).toArray()
);