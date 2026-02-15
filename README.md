# Projeto de Grafo de Conhecimento com Neo4j

Este repositório contém a modelagem e implementação de um pequeno grafo de conhecimento utilizando **Neo4j** e a linguagem **Cypher**.

## 📌 Entregáveis

1. **Diagrama/Esboço do Modelo de Grafo**  
   Representa as entidades e relacionamentos principais.

2. **Script Cypher (.cypher)**  
   - Criação de *constraints* (ex.: `UNIQUE` para IDs).  
   - Inserção de pelo menos:
     - 10 usuários
     - 10 filmes/séries
     - Relacionamentos entre eles (`WATCHED`, `ACTED_IN`, `DIRECTED`, `IN_GENRE`).

## 🧩 Modelo de Grafo

**Entidades (Nós):**
- Usuário
- Filme
- Série
- Género
- Ator
- Diretor

**Relacionamentos:**
- `WATCHED` (com propriedade `rating`)
- `ACTED_IN`
- `DIRECTED`
- `IN_GENRE`


```bash
docker run --rm -it -v C:\neo4j\plugins:/plugins -e NEO4J_AUTH=none -e NEO4J_PLUGINS='["apoc"]' neo4j:2026.01.4
