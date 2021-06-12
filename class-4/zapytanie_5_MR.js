printjson(
    db.cwiczenia2.mapReduce(
        function () {
            this.credit.forEach(v => emit(v.currency, {count: 1, balance: v.balance}));
        },
        function (key, values) {
            return {
                sum: values.map(v => v.balance | 0).reduce((a, b) => a + b, 0),
                count: values.map(v => v.count).reduce((a, b) => a + b, 0)
            };
        },
        {
            finalize: function (key, reducedValues) {
                return {
                    sum: reducedValues.sum,
                    avg: reducedValues.sum / reducedValues.count
                };
            },
            query: {
                nationality: 'Poland',
                sex: 'Female'
            },
            out: {inline: 1}
        }
    )
);