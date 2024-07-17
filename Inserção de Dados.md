# Inserção de Dados

```
-- Inserir dados na tabela Quartos
INSERT INTO Quartos (Numero, Tipo, Preco, Estado) VALUES
(101, 'Simples', 100.00, 'Disponível'),
(102, 'Duplo', 150.00, 'Disponível'),
(103, 'Suite', 300.00, 'Disponível'),
(104, 'Simples', 100.00, 'Ocupado');

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
(1, 1, 1, '2024-07-15', '2024-07-18', 350.00),
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
```
