printjson(
    db.cwiczenia2.mapReduce(
        function () {
            const bmi = parseFloat(this.weight) / Math.pow((parseFloat(this.height) / 100), 2)
            emit(
                this.nationality,
                {
                    count: 1,
                    min: bmi,
                    max: bmi,
                    sum: bmi
                }
            );
        },
        function (key, values) {
            const count = values.map(v => v.count).reduce((a, b) => a + b, 0);
            const min =  Math.min(...values.map(v => v.min));
            const max = Math.max(...values.map(v => v.max));
            const sum = values.map(v => v.sum).reduce((a, b) => a + b, 0);
            return {
                count: count,
                min: min,
                max: max,
                sum: sum
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