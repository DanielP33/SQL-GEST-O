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

```

**3. Calcular o total de reservas de um determinado período:**

```
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
```


# Testes de Stored Procedures

**Stored Procedure 1.**



Corra uma vez e será aceite, corra duas testará também o trigger nº 2.
```
CALL RegistarReserva(5, 5, 5, '2024-07-20', '2024-07-25', 500.00);
```


**Stored Procedure 2.**



A Partir deste call é muito fácil atualizar o cliente.
```
CALL AtualizarCliente(2, 'Johnny Paulo', 'johnnypaulo@example.com', '222-222-222');
select * from Clientes
```

**Stored Procedure 3.**



A Partir deste call podemos ver o total de reservas de um determinado período.
```
CALL TotalReservasPeriodo('2024-07-15', '2024-07-18');
select * from Reservas
```

# Explicação

**Stored Procedure 1.**



**CREATE PROCEDURE:** Inicia a criação de um novo procedimento armazenado no banco de dados.

**RegistarReserva:** Nome do procedimento armazenado.

**IN p_ClienteID INT, ...:** Declaração dos parâmetros de entrada do procedimento.

**DECLARE estado_quarto, estado_atual:** Declara variáveis para armazenar o estado do quarto. Estas variáveis podem assumir valores 'Disponível', 'Ocupado', ou 'Manutenção'.

**SELECT Estado INTO estado_atual FROM Quartos WHERE ID = p_QuartoID:** Esta consulta SQL obtém o estado atual do quarto especificado (p_QuartoID) e armazena o resultado na variável estado_atual.

**IF estado_atual <> 'Disponível' THEN:** Verifica se o estado atual do quarto não é 'Disponível'.

**SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quarto não está disponível para reserva.':** Se o quarto não estiver disponível, o procedimento emite um erro com a mensagem especificada, impedindo a inserção da reserva.

**ELSE: Se o quarto estiver disponível:**

**INSERT INTO Reservas (ClienteID, QuartoID, FuncionarioID, DataCheckIn, DataCheckOut, TotalReserva) VALUES (...):** Insere uma nova linha na tabela Reservas com os valores fornecidos pelos parâmetros de entrada, registrando a nova reserva.


*Isso garante que apenas quartos disponíveis possam ser reservados, ajudando a manter a integridade e a precisão dos dados no sistema de gestão de hotel.*


**Stored Procedure 2.**



**CREATE PROCEDURE:** Inicia a criação de um novo procedimento armazenado no banco de dados.

**AtualizarCliente:** Nome do procedimento armazenado.

**IN p_ID INT, ...:** Declaração dos parâmetros de entrada do procedimento.

**UPDATE Clientes SET Nome = p_Nome, Email = p_Email, Telefone = p_Telefone WHERE ID = p_ID:** Esta instrução SQL atualiza as informações de um cliente na tabela Clientes.

**UPDATE Clientes:** Inicia a operação de atualização na tabela Clientes.

**SET Nome = p_Nome, Email = p_Email, Telefone = p_Telefone:** Define os novos valores para as colunas Nome, Email, e Telefone usando os valores fornecidos pelos parâmetros de entrada p_Nome, p_Email, e p_Telefone, respectivamente.

**WHERE ID = p_ID:** Especifica a condição para a atualização, onde o ID do cliente na tabela Clientes deve ser igual ao p_ID fornecido.

***Quando o procedimento AtualizarCliente é chamado, ele segue estes passos:***

_Recebe os valores dos parâmetros de entrada (p_ID, p_Nome, p_Email, p_Telefone)._
_Executa uma operação de atualização na tabela Clientes, definindo os novos valores para Nome, Email, e Telefone para o cliente cujo ID corresponde ao p_ID fornecido._

**Stored Procedure 3.**



**CREATE PROCEDURE:** Inicia a criação de um novo procedimento armazenado no banco de dados.

**TotalReservasPeriodo:** Nome do procedimento armazenado.

**IN p_DataInicio DATE, IN p_DataFim DATE:** Declaração dos parâmetros de entrada do procedimento. Estes parâmetros são fornecidos ao chamar o procedimento:

**p_DataInicio:** Data de início do período.

**p_DataFim:** Data de fim do período.

**SELECT IFNULL(SUM(TotalReserva), 0.00) AS TotalReservas FROM Reservas WHERE DataCheckIn BETWEEN p_DataInicio AND p_DataFim:** Esta consulta SQL calcula a soma total das reservas dentro do período especificado.

**IFNULL(SUM(TotalReserva), 0.00):** Utiliza a função SUM para somar os valores da coluna TotalReserva. A função IFNULL garante que, se a soma for NULL (ou seja, se não houver reservas no período), o resultado será 0.00.

**FROM Reservas:** Especifica a tabela Reservas de onde os dados serão extraídos.

**WHERE DataCheckIn BETWEEN p_DataInicio AND p_DataFim:** Filtra os registros para considerar apenas aqueles cuja data de check-in (DataCheckIn) está entre as datas fornecidas (p_DataInicio e p_DataFim).

**Quando o procedimento TotalReservasPeriodo é chamado, ele segue estes passos:**

_Recebe os valores dos parâmetros de entrada (p_DataInicio e p_DataFim).
Executa uma consulta SQL que calcula a soma total das reservas (TotalReserva) para as reservas cuja data de check-in está entre as datas especificadas. Retorna o resultado da soma como TotalReservas. Se não houver reservas no período, o resultado será 0.00._
