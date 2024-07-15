# Triggers

**1. Atualizar o estado do quarto após uma reserva**
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
**2. Impedir a inserção de uma reserva se o quarto não estiver disponível**

```
DELIMITER //

CREATE TRIGGER ImpedirReservaQuartoIndisponivel 
BEFORE INSERT ON Reservas 
FOR EACH ROW 
BEGIN
    DECLARE estado_quarto ENUM('Disponível', 'Ocupado', 'Manutenção');
    DECLARE estado_atual ENUM('Disponível', 'Ocupado', 'Manutenção');

    SELECT Estado INTO estado_atual 
    FROM Quartos 
    WHERE ID = NEW.QuartoID;

    IF estado_atual <> 'Disponível' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Quarto não está disponível para reserva.';
    END IF;
END//

DELIMITER ;

```

(Opcional) **3. Evitar Duplicacao De Quartos**
```
DELIMITER //

CREATE TRIGGER EvitarDuplicacaoDeQuartos
BEFORE INSERT ON Quartos
FOR EACH ROW
BEGIN
    DECLARE num_ocorrencias INT;

    -- Verifica se o novo número de quarto já existe na tabela
    SELECT COUNT(*) INTO num_ocorrencias
    FROM Quartos
    WHERE Numero = NEW.Numero;

    -- Se já existir, sinaliza um erro
    IF num_ocorrencias > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Não é permitido inserir quartos com o mesmo número.';
    END IF;
END//

DELIMITER ;
```
(Opcional) **4. Evitar Duplicação de Serviços**
```
DELIMITER //

CREATE TRIGGER EvitarDuplicacaoDeServicos
BEFORE INSERT ON Servicos
FOR EACH ROW
BEGIN
    DECLARE num_ocorrencias INT;

    -- Verifica se o novo nome de serviço já existe na tabela
    SELECT COUNT(*) INTO num_ocorrencias
    FROM Servicos
    WHERE Nome = NEW.Nome;

    -- Se já existir, sinaliza um erro
    IF num_ocorrencias > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Não é permitido inserir serviços com o mesmo nome.';
    END IF;
END//

DELIMITER ;
```


# Teste Fácil de Triggers

**Trigger 1.**

```
SELECT * FROM Quartos;

INSERT INTO Reservas (ClienteID, QuartoID, FuncionarioID, DataCheckIn, DataCheckOut, TotalReserva) VALUES
(3, 3, 3, '2024-07-15', '2024-07-18', 350.00);

# O Quarto 103 tornar-se-à Ocupado.
```

**Trigger 2.**

```
SELECT * FROM Quartos;
INSERT INTO Reservas (ClienteID, QuartoID, FuncionarioID, DataCheckIn, DataCheckOut, TotalReserva) VALUES
(4, 4, 4, '2024-07-15', '2024-07-18', 100.00);

# Será dado um erro, "O Quarto não está disponível para reserva." .
```
**Trigger 3.**

```
INSERT INTO `HotelManagement`.`Quartos` (`ID`, `Numero`, `Tipo`, `Preco`, `Estado`)
VALUES ('4', '101', 'Simples', '132', 'Disponível');

# Será dado um erro, "Não é permitido inserir quartos com o mesmo número" .

```
**Trigger 4.**
```
INSERT INTO Servicos (Nome, Preco) VALUES
('Estacionamento', 15.00);
# Será dado um erro " Não é permitido inserir serviços com o mesmo nome. "
```
