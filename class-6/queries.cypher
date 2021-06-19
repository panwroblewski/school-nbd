//-- Część 1 – Wycieczki górskie
//-- Zaimportuj dane uruchamiając skrypt task2.cypher. Napisz następujące zapytania:
//-- 1.	Znajdź trasy którymi można dostać się z Darjeeling na Sandakphu, mające najmniejszą ilość etapów
MATCH (place1:town {name: 'Darjeeling'}), (place2:peak {name: 'Sandakphu'})
RETURN allShortestPaths((place1)-[*]->(place2))

//-- 2.	Znajdź mające najmniej etapów trasy którymi można dostać się z Darjeeling na Sandakphu i które mogą być wykorzystywane zimą
MATCH (place1:town {name: 'Darjeeling'}), (place2:peak {name: 'Sandakphu'})
MATCH path = allShortestPaths((place1)-[*]->(place2))
  WHERE ALL(r IN relationships(path)
    WHERE r.winter = 'true')
RETURN path

//-- 3.	Uszereguj trasy którymi można dostać się z Darjeeling na Sandakphu według dystansu + Znajdź wszystkie miejsca do których można dotrzeć przy pomocy roweru (twowheeler) z Darjeeling latem
MATCH p = (:town {name: 'Darjeeling'})-[r*]->(:peak {name: 'Sandakphu'})
UNWIND r AS relationship
WITH p, collect(relationship.distance) AS distances
WITH p, reduce(acc = 0, d IN distances | acc + d) AS distance
RETURN p, distance
  ORDER BY distance ASC

//union?? this query returns empty result
//MATCH fromDarjeelingPath = (:town {name: 'Darjeeling'})-[r:twowheeler*]->(target)
//  WHERE ALL (r IN relationships(fromDarjeelingPath)
//    WHERE r.summer = 'true')
//RETURN target

//-- Część 2 – Połączenia lotnicze
//-- Zaimportuj dane uruchamiając skrypt task3.cypher. Napisz następujące zapytania:
//-- 4.	Uszereguj porty lotnicze według ilości rozpoczynających się w nich lotów
MATCH (airport:Airport)<-[:ORIGIN]-(flight:Flight)
WITH airport, count(flight) AS countFlights
RETURN airport, countFlights
  ORDER BY countFlights ASC

//-- 5.	Znajdź wszystkie porty lotnicze, do których da się dolecieć (bezpośrednio lub z przesiadkami) z Los Angeles (LAX) wydając mniej niż 3000
//MATCH p = (origin:Airport { name:"LAX" })<-[r1:ORIGIN]-(:Flight)-[r2:ORIGIN|DESTINATION]->(destination:Airport)
//WITH p, REDUCE(acc = 0, n IN [x IN NODES(p) WHERE 'Ticket' IN LABELS(x)] | acc + n.price[0]) as totalPrice
//WHERE totalPrice < 3000
//RETURN p, totalPrice

//  WHERE ALL (r IN relationships(p) WHERE r.class = "Economy")

MATCH p = (origin:Airport {name: 'LAX'})<-[r1:ORIGIN]-(:Flight)-[r2:ORIGIN|DESTINATION*]->(destination:Airport)
WITH p, reduce(acc = 0, n IN [x IN nodes(p) WHERE 'Flight' IN labels(x)] | acc + [(n)<-[:ASSIGN]-(ticket) | ticket.price][0]) AS totalPrice
  WHERE totalPrice < 3000
RETURN p, totalPrice


//UNWIND  relationships(p) as relationship
//WITH p, COLLECT(relationship.price[0]) AS prices
//WITH p, reduce(acc = 0, d in prices | acc + d) as totalPrice
//  WHERE totalPrice < 3000
//RETURN p, totalPrice

//-- 6.	Uszereguj połączenia, którymi można dotrzeć z Los Angeles (LAX) do Dayton (DAY) według ceny biletów
MATCH p = (origin:Airport { name:"LAX" })<-[r1:ORIGIN]-(:Flight)-[r2:ORIGIN|DESTINATION*]->(destination:Airport {name: "DAY"})
WITH p, reduce(acc = 0, n IN [x IN nodes(p) WHERE 'Flight' IN labels(x)] | acc + [(n)<-[:ASSIGN]-(ticket) | ticket.price][0]) AS totalPrice
RETURN p, totalPrice
  ORDER BY totalPrice asc
// returns empty result, so I am trying with different airport
MATCH p = (origin:Airport { name:"LAX" })<-[r1:ORIGIN]-(:Flight)-[r2:ORIGIN|DESTINATION*]->(destination:Airport {name: "SMF"})
WITH p, reduce(acc = 0, n IN [x IN nodes(p) WHERE 'Flight' IN labels(x)] | acc + [(n)<-[:ASSIGN]-(ticket) | ticket.price][0]) AS totalPrice
RETURN p, totalPrice
  ORDER BY totalPrice asc

//-- 7.	Znajdź najtańsze połączenie z Los Angeles (LAX) do Dayton (DAY)
// USING SMF AS AIRPORT AGAIN
MATCH p = (origin:Airport { name:"LAX" })<-[r1:ORIGIN]-(:Flight)-[r2:ORIGIN|DESTINATION*]->(destination:Airport {name: "SMF"})
WITH p, reduce(acc = 0, n IN [x IN nodes(p) WHERE 'Flight' IN labels(x)] | acc + [(n)<-[:ASSIGN]-(ticket) | ticket.price][0]) AS totalPrice
RETURN p, totalPrice
  ORDER BY totalPrice asc LIMIT 1

//-- 8.	Znajdź najtańsze połączenie z Los Angeles (LAX) do Dayton (DAY) w klasie biznes
// USING SMF AS AIRPORT AGAIN
MATCH p = (origin:Airport { name:"LAX" })<-[r1:ORIGIN]-(:Flight)-[r2:ORIGIN|DESTINATION*]->(destination:Airport {name: "SMF"})
WITH p, reduce(acc = 0, n IN [x IN nodes(p) WHERE 'Flight' IN labels(x)] | acc + [(n)<-[:ASSIGN]-(ticket {class: 'business'}) | ticket.price][0]) AS totalPrice
RETURN p, totalPrice
  ORDER BY totalPrice asc LIMIT 1

//-- 9.	Uszereguj linie lotnicze według ilości miast, pomiędzy którymi oferują połączenia
//(unikalnych miast biorących udział w relacjach :ORIGIN i :DESTINATION węzłów typu Flight obsługiwanych przez daną linię)
// ZAPYTANIE SIE ZAWIESZA
//MATCH p = (:Airport)-[:ORIGIN|DESTINATION*]-(f:Flight)-[:ORIGIN|DESTINATION*]-(:Airport)
//WITH p, f.airline as airline, reduce(acc = 0, n IN [x IN nodes(p) WHERE 'Flight' IN labels(x)] | acc + 1) AS totalNumberOfFlights
//RETURN p, airline, totalNumberOfFlights
//  ORDER BY totalNumberOfFlights asc LIMIT 1

MATCH (flight:Flight)
WITH collect(flight.airline) as airlines
UNWIND airlines as unwind_airlines
RETURN unwind_airlines, count(unwind_airlines)

//MATCH p = (o:Airport)<-[:ORIGIN]->(f:Flight)<-[:DESTINATION]->(d:Airport)
//WITH f.airline AS airline, COLLECT(o.name) AS oNames, COLLECT(d.name) AS dNames
//WITH airline, collect(distinct REDUCE(s = [], name IN COLLECT(oNames, dNames) | s + name)) as uniqueNames
//WITH airline , count(uniqueNames) AS uniqueNamesCount
//  order by flight_count desc
//return airline, uniqueNamesCount

//
//MATCH p = (c:Airport)<-[:ORIGIN|DESTINATION]-(f:Flight)
//UNWIND c.name AS unwindCities
//WITH p, f.airline as airline, COLLECT(distinct unwindCities) AS cNames
//WITH airline, count(cNames) AS uniqueNamesCount
//  order by uniqueNamesCount desc
//return airline, uniqueNamesCount


//-- 10.	Znajdź najtańszą trasę łączącą 3 różne porty lotnicze
//MATCH p = (origin:Airport)<-[r1:ORIGIN]-(:Flight)-[r2:ORIGIN|DESTINATION*2..2]->(destination:Airport)
//WITH p, reduce(acc = 0, n IN [x IN nodes(p) WHERE 'Flight' IN labels(x)] | acc + [(n)<-[:ASSIGN]-(ticket) | ticket.price][0]) AS totalPrice
//RETURN p, totalPrice
//  ORDER BY totalPrice asc LIMIT 1
MATCH p = (a1:Airport)<-[r1:ORIGIN]-(f1:Flight)-[r2:DESTINATION]->(a2:Airport)<-[r3:ORIGIN]-(f2:Flight)-[r4:DESTINATION]->(a3:Airport)
  WHERE not(a1=a2) AND not(a1=a3) AND not(a2=a3)
WITH p, reduce(acc = 0, n IN [x IN nodes(p) WHERE 'Flight' IN labels(x)] | acc + [(n)<-[:ASSIGN]-(ticket) | ticket.price][0]) AS totalPrice
RETURN p, totalPrice
  ORDER BY totalPrice asc LIMIT 1



