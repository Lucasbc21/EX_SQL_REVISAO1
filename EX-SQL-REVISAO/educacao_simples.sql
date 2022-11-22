CREATE DATABASE educacao
GO

USE educacao
GO 


CREATE TABLE Aluno(
ra                       INT                                  NOT NULL,
nome                     VARCHAR(10)                          NOT NULL,
sobrenome                VARCHAR(30)                          NOT NULL,
rua                      VARCHAR(30)                          NOT NULL,
numero                   INT                                  NOT NULL,
bairro                   VARCHAR(40)                          NOT NULL,
CEP                      CHAR(8)     CHECK(LEN(CEP) <= 8)      NOT NULL,
telefone                 VARCHAR(8)                           NULL
PRIMARY KEY(ra)
)
GO


CREATE TABLE Curso(
codigo                   INT               NOT NULL,
nome                     VARCHAR(20)       NOT NULL,
carga_horaria            INT               NOT NULL,
turno                    VARCHAR(10)        CHECK(turno = 'Tarde' OR turno = 'Noite' )     NOT NULL,
PRIMARY KEY(codigo)
)
GO

CREATE TABLE Disciplina(
codigo                   INT                   NOT NULL,
nome                     VARCHAR(20)           NOT NULL,
carga_horaria            INT                   NOT NULL,
turno                    VARCHAR(10)        CHECK(turno = 'Tarde' OR turno = 'Noite' )     NOT NULL,
semestre                 INT                   NOT NULL
PRIMARY KEY(codigo)
)
GO


INSERT INTO Aluno(ra, nome, sobrenome, rua, numero, bairro, CEP, telefone)
VALUES           (12345, 'José', 'Silva', 'Almirante Noronha', 236, 'Jardim São Paulo', '1589000', '69875287')

INSERT INTO Aluno(ra, nome, sobrenome, rua, numero, bairro, CEP, telefone)
VALUES           (12346, 'Ana', 'Maria Bastos', 'Anhaia', 1568, 'Barra Funda', '3569000', '25698526')

INSERT INTO Aluno(ra, nome, sobrenome, rua, numero, bairro, CEP, telefone)
VALUES           (12347, 'Mario', 'Santos', 'XV de Novembro', 1841, 'Centro', '1020030', NULL)

INSERT INTO Aluno(ra, nome, sobrenome, rua, numero, bairro, CEP, telefone)
VALUES           (12348, 'Marcia', 'Neves', 'Voluntarios da Patria', 225, 'Santana', '2785090', '78964152')



INSERT INTO Curso(codigo, nome, carga_horaria, turno) 
VALUES                (1, 'Informatica', 2800, 'Tarde')

INSERT INTO Curso(codigo, nome, carga_horaria, turno) 
VALUES                (2, 'Informatica', 2800, 'Noite')

INSERT INTO Curso(codigo, nome, carga_horaria, turno) 
VALUES                (3, 'Logística', 2650, 'Tarde')

INSERT INTO Curso(codigo, nome, carga_horaria, turno) 
VALUES                (4, 'Logística', 2650, 'Noite')

INSERT INTO Curso(codigo, nome, carga_horaria, turno) 
VALUES                (5, 'Plásticos', 2500, 'Tarde')

INSERT INTO Curso(codigo, nome, carga_horaria, turno) 
VALUES                (6, 'Plásticos', 2500, 'Noite')



INSERT INTO Disciplina VALUES
            (1, 'Informatica', 4, 'Tarde', 1),
			(2, 'Informatica', 4, 'Noite', 1),
			(3, 'Quimica', 4, 'Tarde', 1),
			(4, 'Quimica', 4, 'Noite', 1),
			(5, 'Banco de Dados I', 2, 'Tarde', 3),
			(6, 'Banco de Dados I', 2, 'Noite', 3),
			(7, 'Estrutura de Dados', 4, 'Tarde', 4),
			(8, 'Estrutura de Dados', 4, 'Noite', 4)


--1)
SELECT nome +' '+sobrenome AS nome_completo
FROM Aluno

--2)
SELECT rua +' Nº '+ CAST(numero AS VARCHAR(10)) +', '+ bairro +', CEP '+ CEP AS endereço_aluno 
FROM Aluno
WHERE telefone IS NULL


--3)
SELECT telefone
FROM Aluno
WHERE ra = 12348 

--4)

SELECT nome, turno
FROM Curso
WHERE carga_horaria = 2800


--5)

SELECT semestre
FROM Disciplina
WHERE nome LIKE 'Banco%' AND turno LIKE '%oite'






SELECT * FROM Aluno
SELECT * FROM Curso
SELECT * FROM Disciplina


