**Registrar uma nova reserva:**

```
CREATE PROCEDURE RegistarReserva (
    IN p_ClienteID INT,
    IN p_QuartoID INT,
    IN p_FuncionarioID INT,
    IN p_DataCheckIn DATE,
    IN p_DataCheckOut DATE,
    IN p_TotalReserva DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Reservas (ClienteID, QuartoID, FuncionarioID, DataCheckIn, DataCheckOut, TotalReserva)
    VALUES (p_ClienteID, p_QuartoID, p_FuncionarioID, p_DataCheckIn, p_DataCheckOut, p_TotalReserva);
END;
```

**Atualizar os dados de um cliente:**

```
CREATE PROCEDURE AtualizarCliente (
    IN p_ID INT,
    IN p_Nome VARCHAR(100),
    IN p_Email VARCHAR(100),
    IN p_Telefone VARCHAR(15)
)
BEGIN
    UPDATE Clientes 
    SET Nome = p_Nome, Email = p_Email, Telefone = p_Telefone 
    WHERE ID = p_ID;
END;
```

**Calcular o total de reservas de um determinado período:**

```
CREATE PROCEDURE TotalReservasPeriodo (
    IN p_DataInicio DATE,
    IN p_DataFim DATE,
    OUT p_TotalReservas DECIMAL(10, 2)
)
BEGIN
    SELECT SUM(TotalReserva) 
    INTO p_TotalReservas 
    FROM Reservas 
    WHERE DataCheckIn BETWEEN p_DataInicio AND p_DataFim;
END;
```

