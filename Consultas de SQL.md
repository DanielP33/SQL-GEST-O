**Listar todos os quartos disponíveis com os respectivos tipos e preços:**
```
SELECT Numero, Tipo, Preco 
FROM Quartos 
WHERE Estado = 'Disponível';
```


**Listar as reservas realizadas num determinado período:**
```
SELECT * 
FROM Reservas 
WHERE DataCheckIn BETWEEN '2024-07-20' AND '2024-07-30';
```


**Listar os clientes que fizeram mais de um determinado número de reservas:**
```
SELECT Clientes.Nome, COUNT(Reservas.ID) AS NumeroReservas 
FROM Clientes 
JOIN Reservas ON Clientes.ID = Reservas.ClienteID 
GROUP BY Clientes.Nome 
HAVING NumeroReservas > 1;
```
**Listar os serviços disponíveis**

```
SELECT * 
FROM Servicos;
```
