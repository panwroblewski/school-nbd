//--1.	Wszystkie filmy
MATCH (m:Movie) RETURN m

//--2.	Wszystkie filmy, w których grał Hugo Weaving
MATCH (p:Person {name: "Hugo Weaving"})-[:ACTED_IN]->(Movie) RETURN Movie

//--3.	Reżyserzy filmów, w których grał Hugo Weaving
MATCH (p:Person {name: "Hugo Weaving"})-[:ACTED_IN]->(movie)<-[:DIRECTED]-(director)
RETURN movie

//--4.	Wszystkie osoby, z którymi Hugo Weaving grał w tych samych filmach
MATCH (p:Person {name:"Hugo Weaving"})-[:ACTED_IN]->(movie)<-[:ACTED_IN]-(actorActedWith)
RETURN actorActedWith

//--5.	Wszystkie filmy osób, które grały w Matrix
MATCH (movie:Movie)<-[:ACTED_IN]-(actor)
WHERE (actor)-[:ACTED_IN]->(:Movie { title: "The Matrix" })
RETURN movie

//--6.	Listę aktorów (aktor = osoba, która grała przynajmniej w jednym filmie) wraz z ilością filmów, w których grali
MATCH (actor:Person)-[:ACTED_IN]->(movie)
WITH actor, count(movie) as countMovie
WHERE countMovie > 0
RETURN actor, countMovie

//--7.	Listę osób, które napisały scenariusz filmu, które wyreżyserowały wraz z tytułami takich filmów (koniunkcja – ten sam autor scenariusza i reżyser)
MATCH (person:Person)-[:WROTE]->(movie)
WHERE (person)-[:DIRECTED]->(movie)
RETURN person, movie

//--8.	Listę filmów, w których grał zarówno Hugo Weaving jak i Keanu Reeves
MATCH (hugo:Person {name:"Hugo Weaving"})-[:ACTED_IN]->(movie)<-[:ACTED_IN]-(keanu:Person {name:"Keanu Reeves"})
RETURN movie, hugo, keanu

//--9.	(za 0.2pkt) Zestaw zapytań powodujących uzupełnienie bazy danych o film Captain America: The First Avenger wraz z uzupełnieniem informacji o reżyserze, scenarzystach i odtwórcach głównych ról (w oparciu o skrócone informacje z IMDB - http://www.imdb.com/title/tt0458339/) + zapytanie pokazujące dodany do bazy film wraz odtwórcami głównych ról, scenarzystą i reżyserem. Plik SVG ma pokazywać wynik ostatniego zapytania.
CREATE (movie:Movie {title:"Captain America: The First Avenger", released:2011, tagline:'Steve Rogers, a rejected military soldier, transforms into Captain America after taking a dose of a "Super-Soldier serum". But being Captain America comes at a price as he attempts to take down a war monger and a terrorist organization.'})
CREATE (p1:Person {name:"Chris Evans", born:1981})
CREATE (p2:Person {name:"Samuel L. Jackson", born:1948})
CREATE (p3:Person {name:"Hugo Weaving", born:1960})
CREATE (p4:Person {name:"Hayley Atwell", born:1982})
CREATE (p5:Person {name:"Tommy Lee Jones", born:1946})
CREATE (p6:Person {name:"Joe Johnston", born:1950})
CREATE (p7:Person {name:"Christopher Markus", born:1970})
CREATE (p8:Person {name:"Stephen McFeely", born:1970})
CREATE
  (p1)-[:ACTED_IN {roles:["Captain America"]}]->(movie),
  (p2)-[:ACTED_IN {roles:["Nick Fury"]}]->(movie),
  (p3)-[:ACTED_IN {roles:["Johann Schmidt"]}]->(movie),
  (p4)-[:ACTED_IN {roles:["Peggy Carter"]}]->(movie),
  (p5)-[:ACTED_IN {roles:["Colonel Chester Phillips"]}]->(movie),
  (p6)-[:DIRECTED]->(movie),
  (p7)-[:WROTE]->(movie),
  (p8)-[:WROTE]->(movie)

MATCH (movie:Movie { title: "Captain America: The First Avenger" })-[:ACTED_IN|DIRECTED|WROTE]-(person:Person)
RETURN movie, person