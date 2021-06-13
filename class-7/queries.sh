#!/bin/bash

printf '1.	Umieść w bazie (nazwa bucketa ma być Twoim numerem indeksu poprzedzonym literą „s”)
5 wartości, gdzie każda z nich ma być dokumentem json mającym 4 pola co najmniej dwóch różnych typów. \n\n' > result.txt

curl -i -XPUT -H "Content-Type: application/json" -d '{
    "first_name": "Adam",
    "last_name": "Wroblewski",
    "student_id": "s14902",
    "is_active": true
  }' http://localhost:8098/buckets/s14902/keys/s14902 >> result.txt

curl -i -XPUT -H "Content-Type: application/json" -d '{
    "first_name": "Piotr",
    "last_name": "Piotrowski",
    "student_id": "s11111",
    "is_active": true
  }' http://localhost:8098/buckets/s14902/keys/s11111 >> result.txt

curl -i -XPUT -H "Content-Type: application/json" -d '{
    "first_name": "Robert",
    "last_name": "Robertowski",
    "student_id": "s22222",
    "is_active": true
  }' http://localhost:8098/buckets/s14902/keys/s22222 >> result.txt

curl -i -XPUT -H "Content-Type: application/json" -d '{
    "first_name": "Kazik",
    "last_name": "Kazikowski",
    "student_id": "s33333",
    "is_active": true
  }' http://localhost:8098/buckets/s14902/keys/s33333 >> result.txt

curl -i -XPUT -H "Content-Type: application/json" -d '{
    "first_name": "Kamil",
    "last_name": "Kamilkiewicz",
    "student_id": "s44444",
    "is_active": true
  }' http://localhost:8098/buckets/s14902/keys/s44444 >> result.txt

printf "\\n2.	Pobierz z bazy jedną z dodanych przez Ciebie wartości. \n" >> result.txt
curl -i -XGET  http://localhost:8098/buckets/s14902/keys/s14902 >> result.txt

printf "\n3.	Zmodyfikuj jedną z wartości – dodając dodatkowe pole do dokumentu.\n" >> result.txt
curl -i -XPUT -H "Content-Type: application/json" -d '{
    "first_name": "Adam",
    "last_name": "Wroblewski",
    "student_id": "s14902",
    "is_active": true,
    "is_finished_studying": false
  }' http://localhost:8098/buckets/s14902/keys/s14902 >> result.txt

printf "\n4.	Zmodyfikuj jedną z wartości – usuwając jedną pole z wybranego dokumentu.\n" >> result.txt
curl -i -XPUT -H "Content-Type: application/json" -d '{
    "first_name": "Robert",
    "last_name": "Robertowski",
    "student_id": "s22222"
  }' http://localhost:8098/buckets/s14902/keys/s22222 >> result.txt

printf "\n5.	Zmodyfikuj jedną z wartości – zmieniając wartość jednego z pól.\n" >> result.txt
curl -i -XPUT -H "Content-Type: application/json" -d '{
    "first_name": "Kamil",
    "last_name": "Kamilkiewicz",
    "student_id": "s44444",
    "is_active": false
  }' http://localhost:8098/buckets/s14902/keys/s44444 >> result.txt

printf "\n6.	Usuń jeden z dokumentów z bazy.\n" >> result.txt
curl -i -XDELETE http://localhost:8098/buckets/s14902/keys/s22222 >> result.txt

printf "\n7.	Spróbuj pobrać z bazy wartość, która nie istnieje w tej bazie.\n" >> result.txt
curl -i -XGET  http://localhost:8098/buckets/s14902/keys/s66666 >> result.txt

printf "\n8.	Dodaj do bazy 1 dokument json (zawierający 1 pole), ale nie specyfikuj klucza.\n" >> result.txt
response=$(curl -i -XPOST -H "Content-Type: application/json" -d '{
    "first_name": "Człowiek",
    "last_name": "Widmo",
    "student_id": "s99999",
    "is_active": true
  }' http://localhost:8098/buckets/s14902/keys)
echo $response >> result.txt
location=$(echo $response | grep -oP 'Location: \K.*')

printf "\n9.	Pobierz z bazy element z zadania 8.\n" >> result.txt
url="http://localhost:8098${location}"
curl -i -XGET $url >> result.txt

printf "\n10.	Usuń z bazy element z zadania 8.\n" >> result.txt
curl -i -XDELETE  $url >> result.txt
