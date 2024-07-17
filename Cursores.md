**Gerar um relatório que lista todos os quartos reservados e a quantidade de reservas de cada um num determinado período:**

```
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

# Para Testar

**1.**
```
CALL RelatorioReservasQuartos('2024-01-01', '2024-12-31');
```

# Explicação

**DELIMITER:** Define um novo delimitador para o SQL (//) para que possamos definir o procedimento armazenado corretamente.

**CREATE PROCEDURE:** Inicia a criação de um novo procedimento armazenado no banco de dados.

**RelatorioReservasQuartos:** Nome do procedimento armazenado.

**IN DataInicio DATE, IN DataFim DATE:** Declaração dos parâmetros de entrada do procedimento. Estes parâmetros são fornecidos ao chamar o procedimento:

**DataInicio:** Data de início do período.

**DataFim:** Data de fim do período.


**Declaração de Variáveis:**

**done:** Usada para controlar o loop do cursor.
**quarto_id, numero_quarto, tipo_quarto, preco_quarto, estado_quarto, quantidade_reservas:** Variáveis para armazenar os dados dos quartos e o número de reservas.

**Declaração do Cursor:**

**DECLARE cursor_quartos CURSOR FOR:** Define um cursor chamado cursor_quartos que seleciona os quartos reservados no período especificado e conta a quantidade de reservas de cada quarto.
A consulta SQL dentro do cursor faz um JOIN entre Quartos e Reservas, filtrando os registros com base no período especificado (DataInicio e DataFim) e agrupando por Q.ID.

**Handler para o Fim do Cursor:**

**DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1:** Define um manipulador (handler) que define a variável done como 1 quando não houver mais linhas para ler no cursor.

**Criação de uma Tabela Temporária:**

**CREATE TEMPORARY TABLE TempRelatorio:** Cria uma tabela temporária chamada TempRelatorio para armazenar os resultados do cursor.

**Abrir o Cursor:**

**OPEN cursor_quartos:** Abre o cursor cursor_quartos.

**Loop Através dos Resultados do Cursor:**

**read_loop: LOOP: Inicia um loop chamado read_loop.**

**FETCH cursor_quartos INTO...:** Recupera os dados do cursor e armazena nas variáveis declaradas.

**IF done THEN LEAVE read_loop:** Verifica se não há mais linhas para ler e sai do loop se done for 1.

**INSERT INTO TempRelatorio...:** Insere os dados recuperados do cursor na tabela temporária TempRelatorio.

**Fechar o Cursor:**

**CLOSE cursor_quartos:** Fecha o cursor cursor_quartos.

**Selecionar os Resultados da Tabela Temporária:**

**SELECT * FROM TempRelatorio:** Seleciona todos os registros da tabela temporária TempRelatorio para exibir os resultados.

**Limpar a Tabela Temporária:**

**DROP TEMPORARY TABLE TempRelatorio:** Remove a tabela temporária TempRelatorio após o uso.


_**Quando o procedimento RelatorioReservasQuartos é chamado, ele segue estes passos:**_

_Recebe os valores dos parâmetros de entrada (DataInicio e DataFim).
Abre um cursor que seleciona os quartos reservados no período especificado e conta a quantidade de reservas de cada quarto.
Insere os resultados na tabela temporária TempRelatorio.
Seleciona todos os registros da tabela temporária TempRelatorio para exibir os resultados.
Limpa a tabela temporária._
