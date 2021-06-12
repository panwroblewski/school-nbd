printjson(
    db.cwiczenia2.insert(
        {
            "sex": "Male",
            "first_name": "Adam",
            "last_name": "Wróblewski",
            "job": "Big Data Engineer",
            "email": "mmail@gmail.com",
            "location": {"city": "Warsaw", "address": {"streetname": "Puławska", "streetnumber": "72"}},
            "description": "Mongodb jest sper",
            "height": "185.04",
            "weight": "75.38",
            "birth_date": "1990-07-23T19:11:32Z",
            "nationality": "Poland",
            "credit": [{
                "type": "switch",
                "number": "4565897816827440",
                "currency": "PLN",
                "balance": "100000"
            }]
        }
    )
);