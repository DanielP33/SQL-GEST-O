**1. Registrar uma nova reserva:**

```
DELIMITER //

CREATE PROCEDURE RegistarReserva (
    IN p_ClienteID INT,
    IN p_QuartoID INT,
    IN p_FuncionarioID INT,
    IN p_DataCheckIn DATE,
    IN p_DataCheckOut DATE,
    IN p_TotalReserva DECIMAL(10, 2)
)
BEGIN
    DECLARE estado_quarto ENUM('Disponível', 'Ocupado', 'Manutenção');
    DECLARE estado_atual ENUM('Disponível', 'Ocupado', 'Manutenção');

    -- Verifica se o quarto está disponível durante o período especificado
    SELECT Estado INTO estado_atual
    FROM Quartos
    WHERE ID = p_QuartoID;

    -- Se o quarto não estiver disponível, sinaliza um erro
    IF estado_atual <> 'Disponível' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quarto não está disponível para reserva.';
    ELSE
        -- Se o quarto estiver disponível, insere a reserva
        INSERT INTO Reservas (ClienteID, QuartoID, FuncionarioID, DataCheckIn, DataCheckOut, TotalReserva)
        VALUES (p_ClienteID, p_QuartoID, p_FuncionarioID, p_DataCheckIn, p_DataCheckOut, p_TotalReserva);
    END IF;
END//

DELIMITER ;
```

**2. Atualizar os dados de um cliente:**

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

**3. Calcular o total de reservas de um determinado período:**

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


# Testes de Stored Procedures

**1.**
Corra uma vez e será aceite, corra duas testará também o trigger nº 2.
```
CALL RegistarReserva(1, 2, 1, '2024-07-20', '2024-07-25', 500.00);
```


