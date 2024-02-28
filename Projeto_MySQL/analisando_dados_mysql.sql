#INTRODUÇÃO: Os dados foram adquiridos diretamente do www.kaggle.com infelizmente eu perdi a database para poder disponiblizar, temos como objetivo análisar o principais paises com poder ecônomico e a média de idade.

#1.ETAPA PARA DEFINIR A DATABASE COMO PADRAO, QUAIS AS TABELAS EXISTENTE DENTRO DA DATABASE E SUAS DESCRIÇÕES
USE world;

SHOW TABLES; 

DESCRIBE city;

DESCRIBE country;

DESCRIBE countrylanguage;

#2.ETAPA DE SELECT, AQUI IREMOS ANALISAR OS DADOS PRESENTE NAS TABELAS.
SELECT * FROM country;

SELECT * FROM city;

SELECT * FROM countrylanguage;
#2.1- PASSANDO UM SELECT COM UMA CONDIÇÃO
SELECT * FROM city WHERE CountryCode='ARG';

#2.2-UM SELECT PARA SABER AS SIGLAS DOS PAISES EXISTENTES
SELECT DISTINCT CountryCode FROM city;

#2.3-SELECT PARA SABER QUAL É O PAIS QUE MAIS APARECE
SELECT CountryCode, COUNT(CountryCode) AS paises_que_mais_aparece FROM city
GROUP BY CountryCode ORDER BY paises_que_mais_aparece DESC;

#2.4-SELECT PARA SABER OS 10 ESTADOS DE CADA PAIS QUE POSSUI A MAIOR POPULAÇÃO MUNDIAL
SELECT c.Name AS Estado, ct.Name AS Pais, c.Population FROM city as c 
    LEFT JOIN country AS Ct ON ct.Code=c.CountryCode
        ORDER BY Population DESC LIMIT 10;

#2.5-AGORA VAMOS ANALISAR OS PAISES COM MAIORES POPULAÇÕES EXISTENTE
SELECT Name AS Pais, Population As POPULAÇÃO 
    FROM country ORDER BY Population DESC LIMIT 10;

#2.6-Aqui iremos fazer um grupo by aonde iremos agrupar a média de expectativa de vida por continente e o continente que mais tem potência ecônomico, 
#também iremos explorar pra cada pais tanto a média de expectativa de vida quanto ao seu pontecial ecônomico.
#É importante deixar claro que eu organizei em ordem decrescente pra saber qual é o continente que mais tem potencial ecônomico.

SELECT continente, FLOOR(AVG(LifeExpectancy)) AS Med_de_vida, SUM(GNP) AS Potencial_ecônomico 
    FROM country GROUP BY continente ORDER BY Potencial_ecônomico DESC;
SELECT Name, MAX((GNP)) AS economia FROM country GROUP BY Name  
    ORDER BY economia DESC;

SELECT Name, FLOOR(AVG(LifeExpectancy)) AS Med_de_vida, SUM(GNP) AS Potencial_ecônomico 
    FROM country GROUP BY Name
        ORDER BY Potencial_ecônomico DESC ;

#2.7-OS 10 MELHORES PAISES RANQUEADO PELA ECONOMIA
SELECT Name, MAX(GNPOld) AS economia FROM country 
    GROUP BY Name ORDER BY economia DESC LIMIT 10;

#2.8-OS 10 PIORES PAISES RANQUEADO PELA ECONOMIA
SELECT Name, MIN(GNPOld) AS economia FROM country WHERE GNP > 0
    GROUP BY Name ORDER BY economia ASC LIMIT 10;

#2.9-ALGUMAS LINHAS POSSUI VALORES NULOS, COMO AS LINHAS SÃO POUCAS DECIDIR EXCLUIR, AO INVÉS DE PREENCHELAS.
SELECT * FROM country WHERE ISNULL(GNPOld);

#2.9- QUANTIDADE DE PAIS QUE POSSUI O IDIOMA OFICIAL
SELECT  COUNT(CountryCode) FROM countrylanguage WHERE IsOfficial='T';

#3.ETAPA DE TRANSFORMAÇÃO E LIMPEZA, EXCLUINDO DADOS E RENOMEANDO TABELAS

#3.1AO TENTAR EXCLUIR AS LINHAS COM VALORES VAZIAS, ENFRENTEI UM IMPEDIMENTO AONDE NAO DEIXAVA DELETAR POR CAUSA DA FOREIGN KEY
#ENTAO EU EXCLUIR A FOREING KEY E COLOQUEI NOVAMENTE
DELETE Ct,c FROM country AS ct  
LEFT JOIN city AS c ON ct.Code=c.CountryCode 
WHERE ISNULL(GNPOld);

#3.2-VERIFICANDO SE AINDA EXISTE VALORES NULOS
SELECT * FROM country WHERE ISNULL(GNPOld);

#3.2-EXCLUINDO A FOREING KEY E ADICIONANDO-A NOVAMENTE
ALTER TABLE city DROP FOREIGN KEY city_ibfk_1

ALTER TABLE city ADD CONSTRAINT Fk_city_countryCode FOREIGN KEY (CountryCode) REFERENCES country(Code);

ALTER TABLE country CHANGE COLUMN Continent Continente
ENUM('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL DEFAULT 'Asia';

ALTER TABLE country CHANGE COLUMN Region Região CHAR(26) NOT NULL;