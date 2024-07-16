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

