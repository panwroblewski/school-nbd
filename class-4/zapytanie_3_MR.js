printjson(
    db.cwiczenia2.mapReduce(
        function () {
            emit(
                this.job, this.job
            );
        },
        function (key, values) {
            function onlyUnique(value, index, self) {
                return self.indexOf(value) === index;
            }
            return values.filter(onlyUnique);
        },
        {
            out: {inline: 1}
        }
    )
);