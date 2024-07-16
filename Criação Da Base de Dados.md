# Criação da Base de Dados e Tabelas

```
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
```

# Descrição das Tabelas

**Tabela Quartos**

Esta tabela armazena informações sobre os quartos disponíveis no hotel. Cada quarto é identificado por um número único e possui um tipo (como Standard, Luxo, etc.), um preço por noite e um estado que pode ser "Disponível", "Ocupado" ou "Manutenção".

**Tabela Clientes**

Aqui são registrados os dados dos clientes que se hospedam no hotel. Cada cliente tem um ID único, um nome completo, um endereço de email e um número de telefone.
Tabela Funcionarios

Registra informações sobre os funcionários do hotel. Cada funcionário tem um ID único, um nome completo, uma posição dentro do hotel (como recepcionista, gerente, etc.) e um salário.

**Tabela Reservas**

Esta tabela mantém o registro das reservas feitas pelos clientes. Cada reserva recebe um ID único e está associada a um cliente, a um quarto específico e ao funcionário que fez a reserva. Além disso, são registradas as datas de check-in e check-out, e o valor total da reserva.

**Tabela Servicos**

Registra os diferentes serviços adicionais oferecidos pelo hotel, como café da manhã, lavanderia, entre outros. Cada serviço possui um ID único, um nome descritivo e um preço associado.

**Tabela PedidosServico**

Esta tabela mantém o registro dos pedidos de serviços feitos pelos clientes durante suas estadias. Cada pedido recebe um ID único e está vinculado a uma reserva específica, a um serviço solicitado, ao funcionário responsável pelo atendimento do pedido, além da quantidade e do preço total do serviço solicitado.

**Conclusão**

Essas tabelas em conjunto formam a estrutura básica de um sistema de banco de dados para gestão de um hotel, permitindo o controle e organização eficientes das operações relacionadas a quartos, clientes, funcionários, reservas e serviços oferecidos.
