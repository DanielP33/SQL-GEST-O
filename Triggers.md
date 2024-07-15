**Atualizar o estado do quarto após uma reserva**
```
DELIMITER //

CREATE TRIGGER AtualizaEstadoQuarto 
AFTER INSERT ON Reservas 
FOR EACH ROW 
BEGIN
    UPDATE Quartos 
    SET Estado = 'Ocupado' 
    WHERE ID = NEW.QuartoID;
END//

DELIMITER ;
```
**Impedir a inserção de uma reserva se o quarto não estiver disponível**

```
CREATE TRIGGER ImpedirReservaQuartoIndisponivel 
BEFORE INSERT ON Reservas 
FOR EACH ROW 
BEGIN
    DECLARE estado_quarto ENUM('Disponível', 'Ocupado', 'Manutenção');
    SELECT Estado INTO estado_quarto 
    FROM Quartos 
    WHERE ID = NEW.QuartoID;

    IF estado_quarto != 'Disponível' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Quarto não está disponível para reserva.';
    END IF;
END;
```

** Teste fácil de triggers **

**Trigger 1.**

```
# Testar o Trigger
SELECT * FROM Quartos;

INSERT INTO Reservas (ClienteID, QuartoID, FuncionarioID, DataCheckIn, DataCheckOut, TotalReserva) VALUES
(3, 3, 3, '2024-07-15', '2024-07-18', 350.00);

# O Quarto 103 tornar-se-à Ocupado.

```

**Trigger 2.**

```

```
