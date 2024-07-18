# Código completo de geração da BD

```
# Criação da BD e Tabelas

CREATE DATABASE HotelManagement;
USE HotelManagement;

CREATE TABLE Quartos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Numero INT NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL,
    Estado ENUM('Disponível', 'Ocupado', 'Manutenção') NOT NULL
);

CREATE TABLE Clientes (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Telefone VARCHAR(15) NOT NULL
);

CREATE TABLE Funcionarios (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Posicao VARCHAR(50) NOT NULL,
    Salario DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Reservas (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    QuartoID INT,
    FuncionarioID INT,
    DataCheckIn DATE NOT NULL,
    DataCheckOut DATE NOT NULL,
    TotalReserva DECIMAL(10, 2),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID),
    FOREIGN KEY (QuartoID) REFERENCES Quartos(ID),
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionarios(ID)
);

CREATE TABLE Servicos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE PedidosServico (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ReservaID INT,
    ServicoID INT,
    FuncionarioID INT,
    Quantidade INT NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ReservaID) REFERENCES Reservas(ID),
    FOREIGN KEY (ServicoID) REFERENCES Servicos(ID),
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionarios(ID)
);

# Inserção de Dados
-- Inserir dados na tabela Quartos
INSERT INTO Quartos (Numero, Tipo, Preco, Estado) VALUES
(101, 'Simples', 100.00, 'Ocupado'),
(102, 'Duplo', 150.00, 'Ocupado'),
(103, 'Suite', 300.00, 'Ocupado'),
(104, 'Simples', 100.00, 'Disponível'),
(105, 'Suite', 300.00, 'Disponível'),
(106, 'Simples', 100.00, 'Disponível');

-- Verificar inserção de Quartos
SELECT * FROM Quartos;

-- Inserir dados na tabela Clientes de forma múltipla
INSERT INTO Clientes (Nome, Email, Telefone) VALUES
('João Silva', 'joao.silva@example.com', '111-111-111'),
('Maria Fernandes', 'maria.fernandes@example.com', '222-222-222'),
('Pedro Santos', 'pedro.santos@example.com', '333-333-333'),
('Ana Oliveira', 'ana.oliveira@example.com', '444-444-444'),
('Rui Almeida', 'rui.almeida@example.com', '555-555-555');


-- Inserir dados na tabela Funcionarios
INSERT INTO Funcionarios (Nome, Posicao, Salario) VALUES
('Ana Costa', 'Recepcionista', 2000.00),
('Carlos Lima', 'Gerente', 4000.00),
('Marta Sousa', 'Recepcionista', 1800.00),
('António Santos', 'Cozinheiro', 2200.00),
('Sofia Oliveira', 'Camareira', 1600.00);

-- Inserir dados na tabela Reservas
INSERT INTO Reservas (ClienteID, QuartoID, FuncionarioID, DataCheckIn, DataCheckOut, TotalReserva) VALUES
(1, 1, 1, '2024-07-15', '2024-07-18', 300.00),
(1, 1, 3, '2024-07-15', '2024-07-18', 300.00),
(2, 2, 2, '2024-07-20', '2024-07-25', 750.00),
(1, 3, 2, '2024-08-01', '2024-08-05', 1200.00);

-- Inserir Servicos
INSERT INTO Servicos (Nome, Preco) VALUES
('Estacionamento', 15.00),
('Bar', 25.00),
('Wi-Fi', 15.00),
('Spa', 100.00),
('Ginásio', 50.00),
('Piscina', 20.00);

-- Inserir dados na tabela PedidosServico
INSERT INTO PedidosServico (ReservaID, ServicoID, FuncionarioID, Quantidade, Preco) VALUES
(1, 1, 1, 2, 30.00),  -- ReservaID 1, ServicoID 1 (Estacionamento), FuncionarioID 1 (Ana Costa), 2 vezes, 30.00 total
(1, 2, 1, 1, 25.00),  -- ReservaID 1, ServicoID 2 (Bar), FuncionarioID 1 (Ana Costa), 1 vez, 25.00 total
(2, 3, 2, 1, 15.00),  -- ReservaID 2, ServicoID 3 (Wi-Fi), FuncionarioID 2 (Carlos Lima), 1 vez, 15.00 total
(2, 4, 2, 1, 100.00), -- ReservaID 2, ServicoID 4 (Spa), FuncionarioID 2 (Carlos Lima), 1 vez, 100.00 total
(3, 5, 3, 2, 100.00), -- ReservaID 3, ServicoID 5 (Ginásio), FuncionarioID 3 (Marta Sousa), 2 vezes, 100.00 total
(4, 6, 4, 1, 20.00);  -- ReservaID 4, ServicoID 6 (Piscina), FuncionarioID 4 (António Santos), 1 vez, 20.00 total

# Consultas SQL

# Listar todos os quartos disponíveis com os respectivos tipos e preços:
SELECT Numero, Tipo, Preco 
FROM Quartos 
WHERE Estado = 'Disponível';

# Listar as reservas realizadas num determinado período:
SELECT * 
FROM Reservas 
WHERE DataCheckIn BETWEEN '2024-07-20' AND '2024-07-30';

# Listar os clientes que fizeram mais de um determinado número de reservas:
SELECT Clientes.Nome, COUNT(Reservas.ID) AS NumeroReservas 
FROM Clientes 
JOIN Reservas ON Clientes.ID = Reservas.ClienteID 
GROUP BY Clientes.Nome 
HAVING NumeroReservas > 1;

# Listar os serviços disponíveis
SELECT * 
FROM Servicos;

# Triggers

DELIMITER //
# Atualizar o estado do quarto após uma reserva
CREATE TRIGGER AtualizaEstadoQuarto 
AFTER INSERT ON Reservas 
FOR EACH ROW 
BEGIN
    UPDATE Quartos 
    SET Estado = 'Ocupado' 
    WHERE ID = NEW.QuartoID;
END//

DELIMITER ;
# Impedir a inserção de uma reserva se o quarto não estiver disponível

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

# Evitar Duplicacao De Quartos
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

# Evitar Duplicação de Serviços
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

# Stored Procedures

# Registrar uma nova reserva:

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

# Atualizar os dados de um cliente:

DELIMITER //

CREATE PROCEDURE AtualizarCliente (
    IN p_ID INT,
    IN p_Nome VARCHAR(100),
    IN p_Email VARCHAR(100),
    IN p_Telefone VARCHAR(15)
)
BEGIN
    -- Atualiza o cliente na tabela Clientes com base no ID fornecido
    UPDATE Clientes 
    SET Nome = p_Nome, Email = p_Email, Telefone = p_Telefone 
    WHERE ID = p_ID;
END//

DELIMITER ;

# Calcular o total de reservas de um determinado período:

DELIMITER //

CREATE PROCEDURE TotalReservasPeriodo (
    IN p_DataInicio DATE,
    IN p_DataFim DATE
)
BEGIN
    -- Calcula a soma das reservas no período especificado e exibe o resultado
    SELECT IFNULL(SUM(TotalReserva), 0.00) AS TotalReservas
    FROM Reservas
    WHERE DataCheckIn BETWEEN p_DataInicio AND p_DataFim;
END//

DELIMITER ;

# Cursor

DROP IF EXISTS RelatorioReservasQuartos

DELIMITER //

CREATE PROCEDURE RelatorioReservasQuartos(
    IN DataInicio DATE,
    IN DataFim DATE
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE quarto_id INT;
    DECLARE numero_quarto INT;
    DECLARE tipo_quarto VARCHAR(50);
    DECLARE preco_quarto DECIMAL(10, 2);
    DECLARE estado_quarto ENUM('Disponível', 'Ocupado', 'Manutenção');
    DECLARE quantidade_reservas INT;

    -- Cursor para selecionar os quartos reservados no período especificado
    DECLARE cursor_quartos CURSOR FOR
        SELECT Q.ID, Q.Numero, Q.Tipo, Q.Preco, Q.Estado, COUNT(R.ID) AS QuantidadeReservas
        FROM Quartos Q
        JOIN Reservas R ON Q.ID = R.QuartoID
        WHERE R.DataCheckIn <= DataFim AND R.DataCheckOut >= DataInicio
        GROUP BY Q.ID;

    -- Handler para o fim do cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Criar uma tabela temporária para armazenar os resultados
    CREATE TEMPORARY TABLE TempRelatorio (
        QuartoID INT,
        Numero INT,
        Tipo VARCHAR(50),
        Preco DECIMAL(10, 2),
        Estado ENUM('Disponível', 'Ocupado', 'Manutenção'),
        QuantidadeReservas INT
    );

    -- Abrir o cursor
    OPEN cursor_quartos;

    -- Loop através dos resultados do cursor
    read_loop: LOOP
        FETCH cursor_quartos INTO quarto_id, numero_quarto, tipo_quarto, preco_quarto, estado_quarto, quantidade_reservas;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Inserir os resultados na tabela temporária
        INSERT INTO TempRelatorio (QuartoID, Numero, Tipo, Preco, Estado, QuantidadeReservas)
        VALUES (quarto_id, numero_quarto, tipo_quarto, preco_quarto, estado_quarto, quantidade_reservas);
    END LOOP;

    -- Fechar o cursor
    CLOSE cursor_quartos;

    -- Selecionar os resultados da tabela temporária
    SELECT * FROM TempRelatorio;

    -- Limpar a tabela temporária
    DROP TEMPORARY TABLE TempRelatorio;
END //

DELIMITER ;
```
