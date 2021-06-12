printjson(
    db.cwiczenia2.updateMany(
        {first_name: "Antonio"},
        {$set: {hobby: "pingpong"}}
    )
);