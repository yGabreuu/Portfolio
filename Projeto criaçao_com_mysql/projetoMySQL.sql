#OS DADOS PREENCHIDOS É APENAS DADOS FICTÍCIO, O INTUITO AQUI É APENAS O APRENDIZADO
#CRIANDO A BASEDEDADOS E TABELA 
CREATE DATABASE mercado;
use mercado;
CREATE TABLE clientes(
        cli_id INT AUTO_INCREMENT NOT NULL,
        cli_nome VARCHAR(50) ,
        cli_datanasc DATETIME,
        CONSTRAINT cli_id_pk PRIMARY KEY (cli_id)
    ) 
DEFAULT CHAR SET=utf8mb4;
CREATE TABLE produtos(
        pro_id INT NOT NULL AUTO_INCREMENT,
        pro_nome VARCHAR(50),
        pro_valor FLOAT,
        CONSTRAINT pro_PK PRIMARY KEY (pro_id)
    ) DEFAULT CHAR SET= utf8mb4;
CREATE TABLE estoque(
    estoque_id INT NOT NULL AUTO_INCREMENT,
    pro_id INT NOT NULL,
    estoque_QTDE FLOAT,
    CONSTRAINT PK_estoque PRIMARY KEY (estoque_id)
);
CREATE TABLE itens_pedido(
        ped_id INT NOT NULL,
        pro_id INT NOT NULL,
        itensped_VLRUNIT FLOAT,
        itensped_QTDE FLOAT,
        itensped_VLRTOTAL FLOAT,
        CONSTRAINT ped_pro_pk PRIMARY KEY (ped_id,pro_id)
);
CREATE TABLE pedidos(
    ped_id INT NOT NULL AUTO_INCREMENT,
    cli_id INT NOT NULL,
    ped_data DATETIME DEFAULT NOW(),
    ped_valor FLOAT,
    ped_QTDE FLOAT,
    CONSTRAINT ped_id_pk PRIMARY KEY (ped_id)
);

#RELACIONADO A BASE DE DADOS
ALTER TABLE estoque ADD CONSTRAINT FK_ESTOQUE_PRODUTO FOREIGN KEY (pro_id) REFERENCES produtos(pro_id);
ALTER TABLE pedidos ADD CONSTRAINT FK_PEDIDOS_CLIENTES FOREIGN KEY (cli_id) REFERENCES clientes(cli_id);
ALTER TABLE itens_pedido ADD CONSTRAINT FK_ITENS_PEDIDO_PEDIDOS FOREIGN KEY (ped_id) REFERENCES pedidos(ped_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE itens_pedido ADD CONSTRAINT FK_ITENS_PEDIDO_PRODUTOS FOREIGN KEY (pro_id) REFERENCES produtos(pro_id) ON UPDATE CASCADE ON DELETE CASCADE;

#PREENCHENDO A BASEDEDADOS
INSERT INTO clientes(cli_nome,cli_datanasc)
VALUES(
    'gabriel','2003-09-29'),
    (
        'Marcos','1998-11-15'),
        (
        'felipe','2002-02-14'
        ),
    (
        'marcia','1987-11-24'
        ),
    ('
    Maria', '1990-10-25'
    ),
    (
        'João', '1975-11-24'
        ),
    (
        'Valentina', '1990-06-12'
        ),
    (
        'Marcos', '1992-04-23'
        ),
    (
        'Marluce', '1978-10-14'
        );
SELECT * FROM clientes
DESCRIBE produtos
INSERT INTO produtos(pro_nome,pro_valor) 
VALUES 
    ('Caderno',20),('Lápis',2.50),
    ('Kit maquiagem',160),('Camisa Polo',40),
    ('Tênis',86.99),('Mochila',45),
    ('Camisa branca',29.58),('Calça',70),
    ('Kit de cozinha',150);
SELECT * FROM produtos
DESCRIBE estoque

INSERT INTO estoque(
    pro_id,estoque_QTDE) 
SELECT pro_id, FLOOR(1 + RAND()*100) FROM produtos

SELECT * FROM estoque
DESC pedidos

INSERT INTO pedidos(
    cli_id,ped_QTDE
    ) 
SELECT cli_id,FLOOR(1 + RAND()*20) FROM clientes

SELECT * FROM pedidos
DESC itens_pedido

INSERT INTO itens_pedido(ped_id,pro_id,itensped_VLRUNIT,itensped_QTDE,itensped_VLRTOTAL) 
SELECT p.ped_id,pro.pro_id,pro.pro_valor,p.ped_QTDE,(pro.pro_valor*p.ped_QTDE) FROM pedidos as p 
INNER JOIN produtos as pro ON p.ped_id = pro.pro_id

SELECT * FROM itens_pedido;
DELETE FROM itens_pedido
ALTER TABLE pedidos DROP COLUMN ped_valor
