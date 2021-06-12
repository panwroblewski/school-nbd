printjson(
    db.cwiczenia2.mapReduce(
        function () {
            emit(
                this.sex,
                {
                    count: 1,
                    weight: parseFloat(this.weight),
                    height: parseFloat(this.height)
                }
            );
        },
        function (key, values) {
            return {
                count: values.map(v => v.count).reduce((a, b) => a + b, 0),
                weight: values.map(v => v.weight).reduce((a, b) => a + b, 0),
                height: values.map(v => v.height).reduce((a, b) => a + b, 0)
            };
        },
        {
            finalize: function (key, reducedValues) {
                return {
                    avgWeight: reducedValues.weight / reducedValues.count,
                    avgHeight: reducedValues.height / reducedValues.count
                };
            },
            out: {inline: 1}
        }
    )
);