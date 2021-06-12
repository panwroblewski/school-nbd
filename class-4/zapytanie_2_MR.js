printjson(
    db.cwiczenia2.mapReduce(
        function () {
            this.credit.forEach(c => emit(c.currency, parseFloat(c.balance)));
        },
        function (key, values) {
            return values.reduce((a, b) => a + b, 0);
        },
        {
            out: {inline: 1}
        }
    )
);