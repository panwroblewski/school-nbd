printjson(
    db.cwiczenia2.mapReduce(
        function () {
            emit(
                this.nationality,
                {
                    count: 1,
                    bmi: parseFloat(this.weight) / Math.pow((parseFloat(this.height) / 100), 2)
                }
            );
        },
        function (key, values) {
            const count = values.map(v => v.count).reduce((a, b) => a + b, 0);
            const bmis = values.map(v => v.bmi);
            return {
                count: count,
                min: Math.min(...bmis),
                max: Math.max(...bmis),
                sum: bmis.reduce((a, b) => a + b, 0)
            };
        },
        {
            finalize: function (key, reducedValues) {
                return {
                    min: reducedValues.min,
                    max: reducedValues.max,
                    avg: reducedValues.sum / reducedValues.count
                };
            },
            out: {inline: 1}
        }
    )
);