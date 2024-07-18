CREATE DATABASE  IF NOT EXISTS `HotelManagement` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `HotelManagement`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: HotelManagement
-- ------------------------------------------------------
-- Server version	8.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Clientes`
--

DROP TABLE IF EXISTS `Clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Clientes` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Telefone` varchar(15) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Clientes`
--

LOCK TABLES `Clientes` WRITE;
/*!40000 ALTER TABLE `Clientes` DISABLE KEYS */;
INSERT INTO `Clientes` VALUES (1,'João Silva','joao.silva@example.com','111-111-111'),(2,'Johnny Paulo','johnnypaulo@example.com','222-222-222'),(3,'Pedro Santos','pedro.santos@example.com','333-333-333'),(4,'Ana Oliveira','ana.oliveira@example.com','444-444-444'),(5,'Rui Almeida','rui.almeida@example.com','555-555-555');
/*!40000 ALTER TABLE `Clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Funcionarios`
--

DROP TABLE IF EXISTS `Funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Funcionarios` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Posicao` varchar(50) NOT NULL,
  `Salario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Funcionarios`
--

LOCK TABLES `Funcionarios` WRITE;
/*!40000 ALTER TABLE `Funcionarios` DISABLE KEYS */;
INSERT INTO `Funcionarios` VALUES (1,'Ana Costa','Recepcionista',2000.00),(2,'Carlos Lima','Gerente',4000.00),(3,'Marta Sousa','Recepcionista',1800.00),(4,'António Santos','Cozinheiro',2200.00),(5,'Sofia Oliveira','Camareira',1600.00);
/*!40000 ALTER TABLE `Funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PedidosServico`
--

DROP TABLE IF EXISTS `PedidosServico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PedidosServico` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ReservaID` int DEFAULT NULL,
  `ServicoID` int DEFAULT NULL,
  `FuncionarioID` int DEFAULT NULL,
  `Quantidade` int NOT NULL,
  `Preco` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ReservaID` (`ReservaID`),
  KEY `ServicoID` (`ServicoID`),
  KEY `FuncionarioID` (`FuncionarioID`),
  CONSTRAINT `PedidosServico_ibfk_1` FOREIGN KEY (`ReservaID`) REFERENCES `Reservas` (`ID`),
  CONSTRAINT `PedidosServico_ibfk_2` FOREIGN KEY (`ServicoID`) REFERENCES `Servicos` (`ID`),
  CONSTRAINT `PedidosServico_ibfk_3` FOREIGN KEY (`FuncionarioID`) REFERENCES `Funcionarios` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PedidosServico`
--

LOCK TABLES `PedidosServico` WRITE;
/*!40000 ALTER TABLE `PedidosServico` DISABLE KEYS */;
INSERT INTO `PedidosServico` VALUES (1,1,1,1,2,30.00),(2,1,2,1,1,25.00),(3,2,3,2,1,15.00),(4,2,4,2,1,100.00),(5,3,5,3,2,100.00),(6,4,6,4,1,20.00);
/*!40000 ALTER TABLE `PedidosServico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Quartos`
--

DROP TABLE IF EXISTS `Quartos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Quartos` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Numero` int NOT NULL,
  `Tipo` varchar(50) NOT NULL,
  `Preco` decimal(10,2) NOT NULL,
  `Estado` enum('Disponível','Ocupado','Manutenção') NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Quartos`
--

LOCK TABLES `Quartos` WRITE;
/*!40000 ALTER TABLE `Quartos` DISABLE KEYS */;
INSERT INTO `Quartos` VALUES (1,101,'Simples',100.00,'Ocupado'),(2,102,'Duplo',150.00,'Ocupado'),(3,103,'Suite',300.00,'Ocupado'),(4,104,'Simples',100.00,'Ocupado'),(5,105,'Suite',300.00,'Ocupado'),(6,106,'Simples',100.00,'Disponível');
/*!40000 ALTER TABLE `Quartos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `EvitarDuplicacaoDeQuartos` BEFORE INSERT ON `Quartos` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Reservas`
--

DROP TABLE IF EXISTS `Reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reservas` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ClienteID` int DEFAULT NULL,
  `QuartoID` int DEFAULT NULL,
  `FuncionarioID` int DEFAULT NULL,
  `DataCheckIn` date NOT NULL,
  `DataCheckOut` date NOT NULL,
  `TotalReserva` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ClienteID` (`ClienteID`),
  KEY `QuartoID` (`QuartoID`),
  KEY `FuncionarioID` (`FuncionarioID`),
  CONSTRAINT `Reservas_ibfk_1` FOREIGN KEY (`ClienteID`) REFERENCES `Clientes` (`ID`),
  CONSTRAINT `Reservas_ibfk_2` FOREIGN KEY (`QuartoID`) REFERENCES `Quartos` (`ID`),
  CONSTRAINT `Reservas_ibfk_3` FOREIGN KEY (`FuncionarioID`) REFERENCES `Funcionarios` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservas`
--

LOCK TABLES `Reservas` WRITE;
/*!40000 ALTER TABLE `Reservas` DISABLE KEYS */;
INSERT INTO `Reservas` VALUES (1,1,1,1,'2024-07-15','2024-07-18',300.00),(2,1,1,3,'2024-07-15','2024-07-18',300.00),(3,2,2,2,'2024-07-20','2024-07-25',750.00),(4,1,3,2,'2024-08-01','2024-08-05',1200.00),(5,4,4,4,'2024-07-15','2024-07-18',350.00),(6,5,5,5,'2024-07-20','2024-07-25',500.00);
/*!40000 ALTER TABLE `Reservas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `ImpedirReservaQuartoIndisponivel` BEFORE INSERT ON `Reservas` FOR EACH ROW BEGIN
    DECLARE estado_quarto ENUM('Disponível', 'Ocupado', 'Manutenção');
    DECLARE estado_atual ENUM('Disponível', 'Ocupado', 'Manutenção');

    SELECT Estado INTO estado_atual 
    FROM Quartos 
    WHERE ID = NEW.QuartoID;

    IF estado_atual <> 'Disponível' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Quarto não está disponível para reserva.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `AtualizaEstadoQuarto` AFTER INSERT ON `Reservas` FOR EACH ROW BEGIN
    UPDATE Quartos 
    SET Estado = 'Ocupado' 
    WHERE ID = NEW.QuartoID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Servicos`
--

DROP TABLE IF EXISTS `Servicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Servicos` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Preco` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Servicos`
--

LOCK TABLES `Servicos` WRITE;
/*!40000 ALTER TABLE `Servicos` DISABLE KEYS */;
INSERT INTO `Servicos` VALUES (1,'Estacionamento',15.00),(2,'Bar',25.00),(3,'Wi-Fi',15.00),(4,'Spa',100.00),(5,'Ginásio',50.00),(6,'Piscina',20.00);
/*!40000 ALTER TABLE `Servicos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `EvitarDuplicacaoDeServicos` BEFORE INSERT ON `Servicos` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'HotelManagement'
--

--
-- Dumping routines for database 'HotelManagement'
--
/*!50003 DROP PROCEDURE IF EXISTS `AtualizarCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `AtualizarCliente`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistarReserva` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `RegistarReserva`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RelatorioReservasQuartos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `RelatorioReservasQuartos`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TotalReservasPeriodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `TotalReservasPeriodo`(
    IN p_DataInicio DATE,
    IN p_DataFim DATE
)
BEGIN
    -- Calcula a soma das reservas no período especificado e exibe o resultado
    SELECT IFNULL(SUM(TotalReserva), 0.00) AS TotalReservas
    FROM Reservas
    WHERE DataCheckIn BETWEEN p_DataInicio AND p_DataFim;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-18 15:03:26
