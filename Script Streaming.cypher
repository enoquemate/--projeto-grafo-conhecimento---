[
  {
    "cypherStatements": ":begin
CREATE CONSTRAINT actor_unique FOR (node:Actor) REQUIRE (node.name) IS UNIQUE;
CREATE CONSTRAINT director_unique FOR (node:Director) REQUIRE (node.name) IS UNIQUE;
CREATE CONSTRAINT genre_unique FOR (node:Genre) REQUIRE (node.name) IS UNIQUE;
CREATE CONSTRAINT movie_unique FOR (node:Movie) REQUIRE (node.id) IS UNIQUE;
CREATE CONSTRAINT series_unique FOR (node:Series) REQUIRE (node.id) IS UNIQUE;
CREATE CONSTRAINT user_unique FOR (node:User) REQUIRE (node.id) IS UNIQUE;
:commit
CALL db.awaitIndexes(300);
:begin
UNWIND [{name:\"Lana Wachowski\", properties:{}}, {name:\"Christopher Nolan\", properties:{}}, {name:\"James Cameron\", properties:{}}, {name:\"Vince Gilligan\", properties:{}}, {name:\"Shawn Levy\", properties:{}}] AS row
CREATE (n:Director{name: row.name}) SET n += row.properties;
UNWIND [{name:\"Sci-Fi\", properties:{}}, {name:\"Drama\", properties:{}}, {name:\"Comedy\", properties:{}}, {name:\"Action\", properties:{}}, {name:\"Romance\", properties:{}}] AS row
CREATE (n:Genre{name: row.name}) SET n += row.properties;
UNWIND [{id:1, properties:{name:\"João\", age:25}}, {id:2, properties:{name:\"Maria\", age:30}}, {id:3, properties:{name:\"Carlos\", age:28}}, {id:4, properties:{name:\"Ana\", age:22}}, {id:5, properties:{name:\"Pedro\", age:35}}, {id:6, properties:{name:\"Luiza\", age:27}}, {id:7, properties:{name:\"Rafael\", age:40}}, {id:8, properties:{name:\"Fernanda\", age:33}}, {id:9, properties:{name:\"Bruno\", age:29}}, {id:10, properties:{name:\"Clara\", age:26}}] AS row
CREATE (n:User{id: row.id}) SET n += row.properties;
UNWIND [{id:101, properties:{duration:136, year:1999, title:\"Matrix\"}}, {id:102, properties:{duration:148, year:2010, title:\"Inception\"}}, {id:103, properties:{duration:169, year:2014, title:\"Interstellar\"}}, {id:104, properties:{duration:152, year:2008, title:\"The Dark Knight\"}}, {id:105, properties:{duration:195, year:1997, title:\"Titanic\"}}] AS row
CREATE (n:Movie{id: row.id}) SET n += row.properties;
UNWIND [{id:201, properties:{seasons:5, year:2008, title:\"Breaking Bad\", episodes:62}}, {id:202, properties:{seasons:4, year:2016, title:\"Stranger Things\", episodes:34}}, {id:203, properties:{seasons:8, year:2011, title:\"Game of Thrones\", episodes:73}}, {id:204, properties:{seasons:6, year:2016, title:\"The Crown\", episodes:60}}, {id:205, properties:{seasons:9, year:2005, title:\"The Office\", episodes:201}}] AS row
CREATE (n:Series{id: row.id}) SET n += row.properties;
UNWIND [{name:\"Keanu Reeves\", properties:{}}, {name:\"Leonardo DiCaprio\", properties:{}}, {name:\"Matthew McConaughey\", properties:{}}, {name:\"Bryan Cranston\", properties:{}}, {name:\"Millie Bobby Brown\", properties:{}}] AS row
CREATE (n:Actor{name: row.name}) SET n += row.properties;
:commit
:begin
UNWIND [{start: {id:101}, end: {name:\"Sci-Fi\"}, properties:{}}, {start: {id:105}, end: {name:\"Romance\"}, properties:{}}] AS row
MATCH (start:Movie{id: row.start.id})
MATCH (end:Genre{name: row.end.name})
CREATE (start)-[r:IN_GENRE]->(end) SET r += row.properties;
UNWIND [{start: {name:\"Lana Wachowski\"}, end: {id:101}, properties:{}}, {start: {name:\"Christopher Nolan\"}, end: {id:102}, properties:{}}, {start: {name:\"James Cameron\"}, end: {id:105}, properties:{}}] AS row
MATCH (start:Director{name: row.start.name})
MATCH (end:Movie{id: row.end.id})
CREATE (start)-[r:DIRECTED]->(end) SET r += row.properties;
UNWIND [{start: {id:1}, end: {id:101}, properties:{rating:5}}, {start: {id:3}, end: {id:102}, properties:{rating:5}}] AS row
MATCH (start:User{id: row.start.id})
MATCH (end:Movie{id: row.end.id})
CREATE (start)-[r:WATCHED]->(end) SET r += row.properties;
UNWIND [{start: {id:2}, end: {id:201}, properties:{rating:4}}, {start: {id:4}, end: {id:202}, properties:{rating:3}}] AS row
MATCH (start:User{id: row.start.id})
MATCH (end:Series{id: row.end.id})
CREATE (start)-[r:WATCHED]->(end) SET r += row.properties;
UNWIND [{start: {name:\"Bryan Cranston\"}, end: {id:201}, properties:{}}, {start: {name:\"Millie Bobby Brown\"}, end: {id:202}, properties:{}}] AS row
MATCH (start:Actor{name: row.start.name})
MATCH (end:Series{id: row.end.id})
CREATE (start)-[r:ACTED_IN]->(end) SET r += row.properties;
UNWIND [{start: {name:\"Vince Gilligan\"}, end: {id:201}, properties:{}}, {start: {name:\"Shawn Levy\"}, end: {id:202}, properties:{}}] AS row
MATCH (start:Director{name: row.start.name})
MATCH (end:Series{id: row.end.id})
CREATE (start)-[r:DIRECTED]->(end) SET r += row.properties;
UNWIND [{start: {name:\"Keanu Reeves\"}, end: {id:101}, properties:{}}, {start: {name:\"Leonardo DiCaprio\"}, end: {id:102}, properties:{}}] AS row
MATCH (start:Actor{name: row.start.name})
MATCH (end:Movie{id: row.end.id})
CREATE (start)-[r:ACTED_IN]->(end) SET r += row.properties;
UNWIND [{start: {id:201}, end: {name:\"Drama\"}, properties:{}}, {start: {id:202}, end: {name:\"Sci-Fi\"}, properties:{}}] AS row
MATCH (start:Series{id: row.start.id})
MATCH (end:Genre{name: row.end.name})
CREATE (start)-[r:IN_GENRE]->(end) SET r += row.properties;
:commit
"
  }
]