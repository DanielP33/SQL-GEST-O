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
# Explicação

**Trigger 1.**

**CREATE TRIGGER:** Inicia a definição de um novo trigger no banco de dados.

**AtualizaEstadoQuarto:** É o nome dado ao trigger. Esse nome pode ser qualquer coisa que você escolher para identificar o trigger.

**AFTER INSERT ON Reservas:** Especifica que o trigger deve ser acionado automaticamente após a inserção de um novo registro na tabela Reservas.

**FOR EACH ROW:** Indica que o trigger deve ser executado para cada linha afetada pela operação de inserção.

**BEGIN... END:** Define o corpo do trigger, que contém as instruções SQL a serem executadas quando o trigger é acionado.

**UPDATE Quartos:** Inicia uma operação de atualização na tabela Quartos.

**SET Estado = 'Ocupado':** Define o campo Estado da tabela Quartos como "Ocupado".

**WHERE ID = NEW.QuartoID:** Especifica a condição para a atualização, onde o ID do quarto na tabela Quartos deve ser igual ao QuartoID do novo registro inserido na tabela Reservas (NEW.QuartoID).

**NEW.QuartoID:** É uma referência ao valor do QuartoID na nova linha inserida na tabela Reservas.

*Quando uma nova reserva é inserida na tabela Reservas, o trigger AtualizaEstadoQuarto é automaticamente acionado. Ele então realiza uma operação de atualização na tabela Quartos, marcando o quarto correspondente ao QuartoID da nova reserva como "Ocupado". Isso automatiza o processo de atualização do estado do quarto sempre que uma reserva é confirmada, garantindo que o estado do quarto reflete com precisão se ele está ocupado após uma reserva ser feita.*


**Trigger 2.**

**CREATE TRIGGER:** Inicia a definição de um novo trigger no banco de dados.

**ImpedirReservaQuartoIndisponivel:** É o nome dado ao trigger. Este nome pode ser qualquer coisa que você escolher para identificar o trigger.

**BEFORE INSERT ON Reservas:** Especifica que o trigger deve ser acionado antes da inserção de um novo registro na tabela Reservas.

**FOR EACH ROW:** Indica que o trigger deve ser executado para cada linha afetada pela operação de inserção.

**BEGIN... END: **Define o corpo do trigger, que contém as instruções SQL a serem executadas quando o trigger é acionado.

**DECLARE estado_quarto:** Declara uma variável para armazenar o estado possível do quarto ('Disponível', 'Ocupado', 'Manutenção').

**DECLARE estado_atual:** Declara uma variável para armazenar o estado atual do quarto que está sendo verificado.

**SELECT Estado INTO estado_atual FROM Quartos WHERE ID = NEW.QuartoID:** Esta consulta SQL busca o estado atual do quarto na tabela Quartos, baseado no QuartoID da nova reserva (NEW.QuartoID).

**IF estado_atual <> 'Disponível' THEN:** Verifica se o estado atual do quarto não é "Disponível".

**SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quarto não está disponível para reserva.':** Se o quarto não estiver disponível, o comando SIGNAL é utilizado para emitir um erro personalizado (SQLSTATE '45000') com a mensagem especificada. Isso impede que a inserção da reserva ocorra.

*Antes de cada inserção na tabela Reservas, o trigger ImpedirReservaQuartoIndisponivel é acionado. Ele verifica o estado atual do quarto que está sendo reservado. Se o quarto não estiver disponível (ou seja, se o estado não for 'Disponível'), o trigger emite um sinal de erro, impedindo assim que a reserva seja realizada. Isso garante que apenas quartos disponíveis possam ser reservados pelos clientes, mantendo a integridade dos dados e a operação adequada do sistema de gestão de hotel.*


**Trigger 3.**

**BEGIN... END:** Define o corpo do trigger, que contém as instruções SQL a serem executadas quando o trigger é acionado.

**DECLARE num_quartos:** Declara uma variável para armazenar o número de quartos que têm o mesmo número que o novo quarto a ser inserido.

**SELECT COUNT(*) INTO num_quartos FROM Quartos WHERE Numero = NEW.Numero:** Esta consulta SQL conta quantos quartos já existem na tabela Quartos com o mesmo número que o Numero do novo quarto (NEW.Numero).

**IF num_quartos > 0 THEN:** Verifica se já existe algum quarto com o mesmo número.

**SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido inserir quartos com o mesmo número.':** Se houver quartos encontrados com o mesmo número, o comando SIGNAL é utilizado para emitir um erro personalizado (SQLSTATE '45000') com a mensagem especificada, impedindo assim a inserção do novo quarto.

*Antes de cada inserção na tabela Quartos, o trigger ImpedirQuartosDuplicados é acionado. Ele verifica se já existe algum quarto na tabela Quartos com o mesmo número que o novo quarto a ser inserido. Se existir algum quarto com o mesmo número, o trigger emite um sinal de erro, impedindo assim a inserção do novo quarto com número duplicado. Isso garante que cada quarto tenha um número único na base de dados do sistema de gestão de hotel.*

**Trigger 4.**

**CREATE TRIGGER:** Inicia a definição de um novo trigger no banco de dados.

**EvitarDuplicacaoDeServicos:** É o nome dado ao trigger. Este nome pode ser qualquer coisa que você escolher para identificar o trigger.

**BEFORE INSERT ON Servicos:** Especifica que o trigger deve ser acionado antes da inserção de um novo registro na tabela Servicos.

**FOR EACH ROW:** Indica que o trigger deve ser executado para cada linha afetada pela operação de inserção.

**BEGIN... END:** Define o corpo do trigger, que contém as instruções SQL a serem executadas quando o trigger é acionado.

**DECLARE num_ocorrencias:** Declara uma variável para armazenar o número de ocorrências do serviço com o mesmo nome que o novo serviço a ser inserido.

**SELECT COUNT(*) INTO num_ocorrencias FROM Servicos WHERE Nome = NEW.Nome:** Esta consulta SQL conta quantos serviços já existem na tabela Servicos com o mesmo nome que o novo serviço (NEW.Nome).

**IF num_ocorrencias > 0 THEN:** Verifica se já existe algum serviço com o mesmo nome.

**SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido inserir serviços com o mesmo nome.':** Se houver serviços encontrados com o mesmo nome, o comando SIGNAL é utilizado para emitir um erro personalizado (SQLSTATE '45000') com a mensagem especificada, impedindo assim a inserção do novo serviço com nome duplicado.

*Antes de cada inserção na tabela Servicos, o trigger EvitarDuplicacaoDeServicos é acionado. Ele verifica se já existe algum serviço na tabela Servicos com o mesmo nome que o novo serviço a ser inserido. Se existir algum serviço com o mesmo nome, o trigger emite um sinal de erro, impedindo assim a inserção do novo serviço com nome duplicado. Isso garante que cada serviço tenha um nome único na base de dados do sistema de gestão do hotel.*
