-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: carros
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `db_agendamento_voo`
--

DROP TABLE IF EXISTS `db_agendamento_voo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `db_agendamento_voo` (
  `id_agendamento` int NOT NULL AUTO_INCREMENT,
  `data_agendamento` datetime DEFAULT NULL,
  `duracao` varchar(45) DEFAULT NULL,
  `origem` varchar(45) DEFAULT NULL,
  `destino` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_agendamento`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_agendamento_voo`
--

/*!40000 ALTER TABLE `db_agendamento_voo` DISABLE KEYS */;
/*!40000 ALTER TABLE `db_agendamento_voo` ENABLE KEYS */;

--
-- Table structure for table `piloto`
--

DROP TABLE IF EXISTS `piloto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `piloto` (
  `breve` int NOT NULL,
  `salario` varchar(45) DEFAULT NULL,
  `tb_pessoa_id` int DEFAULT NULL,
  PRIMARY KEY (`breve`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `piloto`
--

/*!40000 ALTER TABLE `piloto` DISABLE KEYS */;
/*!40000 ALTER TABLE `piloto` ENABLE KEYS */;

--
-- Table structure for table `tb_cliente`
--

DROP TABLE IF EXISTS `tb_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_cliente` (
  `data_cadastro` datetime DEFAULT NULL,
  `tb_pessoa_id` int DEFAULT NULL,
  `tb_negociar_tb_cliente_id_cliente` int DEFAULT NULL,
  `tb_negociar_tb_vendendor_id_vendendor` int DEFAULT NULL,
  `tb_negociar_tb_contrato_protocolo` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cliente`
--

/*!40000 ALTER TABLE `tb_cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_cliente` ENABLE KEYS */;

--
-- Table structure for table `tb_contrato`
--

DROP TABLE IF EXISTS `tb_contrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_contrato` (
  `protocolo` int NOT NULL,
  `valor_contrato` varchar(45) DEFAULT NULL,
  `id_cliente` int DEFAULT NULL,
  `id_vendedor` int DEFAULT NULL,
  PRIMARY KEY (`protocolo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_contrato`
--

/*!40000 ALTER TABLE `tb_contrato` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_contrato` ENABLE KEYS */;

--
-- Table structure for table `tb_negociar`
--

DROP TABLE IF EXISTS `tb_negociar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_negociar` (
  `tb_cliente_id_cliente` int NOT NULL,
  `tb_vendedor_id_vendedor` int NOT NULL,
  `tb_contrato_protocolo` int DEFAULT NULL,
  PRIMARY KEY (`tb_cliente_id_cliente`,`tb_vendedor_id_vendedor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_negociar`
--

/*!40000 ALTER TABLE `tb_negociar` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_negociar` ENABLE KEYS */;

--
-- Table structure for table `tb_pessoa`
--

DROP TABLE IF EXISTS `tb_pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_pessoa` (
  `id_pessoa` int NOT NULL AUTO_INCREMENT,
  `nome_pessoa` varchar(45) NOT NULL,
  `rg` varchar(45) NOT NULL,
  `cpf` varchar(45) NOT NULL,
  `logradouro` varchar(45) DEFAULT NULL,
  `cep` varchar(45) DEFAULT NULL,
  `logradouro_num` int DEFAULT NULL,
  `telefone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_pessoa`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pessoa`
--

/*!40000 ALTER TABLE `tb_pessoa` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_pessoa` ENABLE KEYS */;

--
-- Table structure for table `tb_pilotar`
--

DROP TABLE IF EXISTS `tb_pilotar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_pilotar` (
  `tb_piloto_id_piloto` int NOT NULL,
  `tb_veiculos_tb_registrar_db_agendamento_voo_id` int DEFAULT NULL,
  `tb_veiculos_numeros` int DEFAULT NULL,
  `tb_piloto_breve` int DEFAULT NULL,
  PRIMARY KEY (`tb_piloto_id_piloto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pilotar`
--

/*!40000 ALTER TABLE `tb_pilotar` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_pilotar` ENABLE KEYS */;

--
-- Table structure for table `tb_possui`
--

DROP TABLE IF EXISTS `tb_possui`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_possui` (
  `tb_contrato_protocolo` int DEFAULT NULL,
  `db_agendamento_voo_id` int DEFAULT NULL,
  KEY `FK_tb_contrato_protocolo` (`tb_contrato_protocolo`),
  KEY `FK_tb_possui_db_agendamento_voo_id` (`db_agendamento_voo_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_possui`
--

/*!40000 ALTER TABLE `tb_possui` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_possui` ENABLE KEYS */;

--
-- Table structure for table `tb_registrar`
--

DROP TABLE IF EXISTS `tb_registrar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_registrar` (
  `db_agendamento_voo_id` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_registrar`
--

/*!40000 ALTER TABLE `tb_registrar` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_registrar` ENABLE KEYS */;

--
-- Table structure for table `tb_veiculos`
--

DROP TABLE IF EXISTS `tb_veiculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_veiculos` (
  `numero` int NOT NULL,
  `modelo` varchar(45) DEFAULT NULL,
  `autonomia` varchar(45) DEFAULT NULL,
  `capacidade` varchar(45) DEFAULT NULL,
  `tb_registrar_db_agendamento_voo_id` int DEFAULT NULL,
  PRIMARY KEY (`numero`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_veiculos`
--

/*!40000 ALTER TABLE `tb_veiculos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_veiculos` ENABLE KEYS */;

--
-- Table structure for table `tb_vendedor`
--

DROP TABLE IF EXISTS `tb_vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_vendedor` (
  `data_contratado` datetime DEFAULT NULL,
  `comissao` varchar(45) DEFAULT NULL,
  `tb_pessoa_id` int DEFAULT NULL,
  `tb_negociar_tb_cliente_id_cliente` int DEFAULT NULL,
  `tb_negociar_tb_vendedor_id_vendedor` int DEFAULT NULL,
  `tb_negociar_tb_tb_contrato_protocolo` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_vendedor`
--

/*!40000 ALTER TABLE `tb_vendedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_vendedor` ENABLE KEYS */;

--
-- Dumping routines for database 'carros'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-13 17:06:32
