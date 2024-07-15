**Gerar um relatório que lista todos os quartos reservados e a quantidade de reservas de cada um num determinado período:**
```
CREATE PROCEDURE RelatorioQuartosReservados (
    IN p_DataInicio DATE,
    IN p_DataFim DATE
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE quartoID INT;
    DECLARE numeroReservas INT;

    DECLARE cursor1 CURSOR FOR 
        SELECT QuartoID, COUNT(*) AS NumeroReservas 
        FROM Reservas 
        WHERE DataCheckIn BETWEEN p_DataInicio AND p_DataFim 
        GROUP BY QuartoID;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cursor1;

    read_loop: LOOP
        FETCH cursor1 INTO quartoID, numeroReservas;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Aqui você pode inserir lógica adicional, como inserção em uma tabela de relatórios
        SELECT CONCAT('Quarto ID: ', quartoID, ' - Número de Reservas: ', numeroReservas);
    END LOOP;

    CLOSE cursor1;
END;
``
