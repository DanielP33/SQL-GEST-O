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
