printjson(
    db.cwiczenia2.aggregate([
        {
            $addFields: {
                convertedWeight: {$convert: {input: '$weight', to: 'double'}},
                convertedHeight: {$convert: {input: '$height', to: 'double'}},
            }
        },
        {
            $group: {
                _id: '$sex',
                sumWeight: {$sum: '$convertedWeight'},
                sumHeight: {$sum: '$convertedHeight'},
                sum: {$sum: 1}
            }
        },
        {
            $project: {
                _id: 1,
                avgWeight: {
                    $divide: ['$sumWeight', '$sum']
                },
                avgHeight: {
                    $divide: ['$sumHeight', '$sum']
                }
            }
        }
    ]).toArray()
);