CREATE DATABASE concessionaria
GO

USE concessionaria
GO

CREATE TABLE carro(
placa                  VARCHAR(8)  UNIQUE     NOT NULL,
marca                  VARCHAR(10)            NOT NULL,
modelo                 VARCHAR(10)            NOT NULL,
cor                    VARCHAR(15)            NOT NULL,
ano                    INT                    NOT NULL,
PRIMARY KEY(placa) 
)
GO

CREATE TABLE cliente(
nome                   VARCHAR(40)            NOT NULL,
logradouro             VARCHAR(50)            NOT NULL,
numero                 INT                    NOT NULL,
bairro                 VARCHAR(30)            NOT NULL,
telefone               VARCHAR(8)             NOT NULL,
carro_placa_cliente    VARCHAR(8)       NOT NULL
PRIMARY KEY(carro_placa_cliente)
FOREIGN KEY(carro_placa_cliente) REFERENCES carro (placa)   
)
GO


CREATE TABLE peças (
codigo                 INT                    NOT NULL,
nome                   VARCHAR(30)            NOT NULL,
valor                  DECIMAL(7,2)           NOT NULL,
PRIMARY KEY(codigo)
)
GO

CREATE TABLE serviço (
carro_placa_serviço    VARCHAR(8)             NOT NULL,
peças_codigo           INT                    NOT NULL,
quantidade             INT                    NOT NULL,
valor                  DECIMAL(7,2)           NOT NULL,
data                   DATE                   NOT NULL
PRIMARY KEY(data, carro_placa_serviço, peças_codigo)
FOREIGN KEY(carro_placa_serviço)   REFERENCES carro(placa),
FOREIGN KEY(peças_codigo)  REFERENCES peças(codigo) 
)
GO

--INSERÇÕES DE INFORMAÇÕES DO CARRO

INSERT INTO carro (placa, marca, modelo, cor, ano)
VALUES            ('AFT9087', 'VW', 'Gol', 'Preto', 2007)
GO

INSERT INTO carro (placa, marca, modelo, cor, ano)
VALUES            ('DXO9876', 'Ford', 'Ka', 'Azul', 2000)
GO

INSERT INTO carro (placa, marca, modelo, cor, ano)
VALUES            ('EGT4631', 'Renault', 'Clio', 'Verde', 2004)
GO

INSERT INTO carro (placa, marca, modelo, cor, ano)
VALUES            ('LKM7380', 'Fiat', 'Palio', 'Prata', 1997)
GO

INSERT INTO carro (placa, marca, modelo, cor, ano)
VALUES            ('BCD7521', 'Ford', 'Fiesta', 'Preto', 1999)
GO

--INSERÇÕES DE INFORMAÇÕES DO CLIENTE

INSERT INTO cliente (nome, logradouro, numero, bairro, telefone, carro_placa_cliente)
VALUES              ('João Alves', 'R. Pereira Barreto', 1258, 'Jd. Oliveiras', '21549658', 'DXO9876') 
GO

INSERT INTO cliente (nome, logradouro, numero, bairro, telefone, carro_placa_cliente)
VALUES              ('Ana Maria', 'R. 7 de Setembro', 259, 'Centro', '96588541', 'LKM7380') 
GO

INSERT INTO cliente (nome, logradouro, numero, bairro, telefone, carro_placa_cliente)
VALUES              ('Clara Oliveira', 'Av. Nações Unidas', 10254, 'Pinheiros', '24589658', 'EGT4631') 
GO

INSERT INTO cliente (nome, logradouro, numero, bairro, telefone, carro_placa_cliente)
VALUES              ('José Simões', 'R. XV de Novembro', 36, 'Água Branca', '78952459', 'BCD7521') 
GO

INSERT INTO cliente (nome, logradouro, numero, bairro, telefone, carro_placa_cliente)
VALUES              ('Paula Rocha', 'R. Anhaia', 548, 'Barra Funda', '69582548', 'AFT9087') 
GO


--INSERÇÕES DE INFORMAÇÕES DA PEÇA

INSERT INTO peças (codigo, nome, valor)
VALUES            (1, 'Vela', 70) 
GO


INSERT INTO peças (codigo, nome, valor)
VALUES            (2, 'Correia Dentada', 125) 
GO


INSERT INTO peças (codigo, nome, valor)
VALUES            (3, 'Trambulador', 90) 
GO


INSERT INTO peças (codigo, nome, valor)
VALUES            (4, 'Filtro de Ar', 30) 
GO



INSERT INTO serviço VALUES
       ('DXO9876', 1, 4, 280, '1/8/20'),
	   ('DXO9876', 4, 1, 30, '1/8/20'),
	   ('EGT4631', 3, 1, 90, '2/8/20'),
	   ('DXO9876', 2, 1, 125, '7/8/20')
GO


SELECT telefone
FROM cliente
WHERE carro_placa_cliente IN (
      SELECT placa
	  FROM carro
	  WHERE modelo = 'Ka' AND cor = 'Azul'
                             )
GO


DROP TABLE serviço

SELECT logradouro +', Nº'+CAST(numero AS VARCHAR(5))+ ', ' + bairro AS endereço
FROM cliente
WHERE carro_placa_cliente IN (

         SELECT placa
		 FROM carro
		 WHERE placa IN (

		 SELECT carro_placa_serviço
		 FROM serviço
		 WHERE data = '02/08/2020'              
						
						)
							 )
GO

SELECT placa
FROM carro
WHERE ano < 2001
GO

SELECT 'Marca ' + marca + ', Modelo ' + modelo + ', Cor ' + cor AS tipo_de_carro 
FROM carro
WHERE ano > 2005
GO

SELECT codigo, nome
FROM peças
WHERE valor < 80
GO
	


SELECT * FROM carro
SELECT * FROM serviço
SELECT * FROM cliente

SELECT * FROM peças

