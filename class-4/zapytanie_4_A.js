printjson(
    db.cwiczenia2.aggregate([
        {
            $addFields: {
                convertedWeight: {$convert: {input: '$weight', to: 'double'}},
                convertedHeight: {$convert: {input: '$height', to: 'double'}},
            }
        },
        {
            $addFields: {
                bmi: {
                    $divide: [
                        '$convertedWeight',
                        {$pow: [{$divide: ["$convertedHeight", 100]}, 2]}
                    ]
                }
            }
        },
        {
            $group: {
                _id: '$nationality',
                avg: {$avg: '$bmi'},
                max: {$max: '$bmi'},
                min: {$min: '$bmi'}
            }
        }
    ]).toArray()
);