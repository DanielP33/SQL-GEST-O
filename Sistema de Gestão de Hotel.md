# Sistema de Gestão de Hotel

## Objetivo

Desenvolver um sistema de gestão de um hotel que permita o controlo de quartos, reservas, clientes e funcionários.

## Requisitos do Projeto

### 1. Desenho da Base de Dados

- Desenhar o diagrama ER de base de dados usando MySQL Workbench.
- Definir as tabelas necessárias e os seus relacionamentos.

### 2. Criação da Base de Dados

Utilizar DDL para criar as tabelas na base de dados MySQL. As tabelas incluídas são:

- **Quartos**: (ID, Número, Tipo, Preço, Estado)
- **Clientes**: (ID, Nome, Email, Telefone)
- **Funcionários**: (ID, Nome, Posição, Salário)
- **Reservas**: (ID, ClienteID, QuartoID, DataCheckIn, DataCheckOut, TotalReserva)
- **Serviços**: (ID, Nome, Preço)
- **PedidosServiço**: (ID, ReservaID, ServiçoID, Quantidade, Preço)

### 3. Inserção de Dados

Inserir dados de exemplo nas tabelas criadas.

### 4. Consultas SQL

Criar consultas para responder às seguintes questões:
- Listar todos os quartos disponíveis com os respectivos tipos e preços.
- Listar as reservas realizadas num determinado período.
- Listar os clientes que fizeram mais de um determinado número de reservas.
- Listar os serviços disponíveis.

### 5. Triggers

Criar triggers para:
- Atualizar o estado do quarto após uma reserva.
- Impedir a inserção de uma reserva se o quarto não estiver disponível.

### 6. Stored Procedures

Criar stored procedures para:
- Registar uma nova reserva.
- Atualizar os dados de um cliente.
- Calcular o total de reservas de um determinado período.

### 7. Cursores

Utilizar cursores para:
- Gerar um relatório que lista todos os quartos reservados e a quantidade de reservas de cada um num determinado período.

### 8. Documentação

Documentar o projeto, incluindo:
- Descrição das tabelas e os seus campos.
- Explicação dos triggers, stored procedures e cursores criados.
- Instruções para configurar e utilizar o sistema.
