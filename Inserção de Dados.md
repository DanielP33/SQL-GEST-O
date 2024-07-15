-- Inserir dados na tabela Quartos
INSERT INTO Quartos (Numero, Tipo, Preco, Estado) VALUES
(101, 'Simples', 100.00, 'Disponível'),
(102, 'Duplo', 150.00, 'Disponível'),
(103, 'Suite', 300.00, 'Disponível');

-- Verificar inserção de Quartos
SELECT * FROM Quartos;

-- Inserir dados na tabela Clientes
INSERT INTO Clientes (Nome, Email, Telefone) VALUES
('João Silva', 'joao.silva@example.com', '111-111-1111'),
('Maria Fernandes', 'maria.fernandes@example.com', '222-222-2222');

-- Verificar inserção de Clientes
SELECT * FROM Clientes;

-- Inserir dados na tabela Funcionarios
INSERT INTO Funcionarios (Nome, Posicao, Salario) VALUES
('Ana Costa', 'Recepcionista', 2000.00),
('Carlos Lima', 'Gerente', 4000.00);

-- Verificar inserção de Funcionarios
SELECT * FROM Funcionarios;
