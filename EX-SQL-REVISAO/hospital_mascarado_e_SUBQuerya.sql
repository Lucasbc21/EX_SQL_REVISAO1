CREATE DATABASE hospital
GO

USE hospital
GO

CREATE TABLE paciente(
CPF                VARCHAR(11)           NOT NULL,
nome               VARCHAR(30)           NOT NULL,
Rua                VARCHAR(30)           NOT NULL,
Nº                 INT                   NOT NULL,
bairro             VARCHAR(30)           NOT NULL,
telefone           VARCHAR(8)            NULL,
data_Nasc          DATE                  NOT NULL
PRIMARY KEY (CPF)
)
GO

CREATE TABLE medico (
codigo             INT                   NOT NULL,
nome               VARCHAR(30)           NOT NULL,
especialidade      VARCHAR(20)           NOT NULL
PRIMARY KEY (codigo)
)
GO

CREATE TABLE prontuario (
data               DATE                  NOT NULL,
CPF_paciente       VARCHAR(11)           NOT NULL,
codigo_medico      INT                   NOT NULL,
diagnostico        VARCHAR(30)           NOT NULL,
medicamento        VARCHAR(20)           NOT NULL
PRIMARY KEY (data, CPF_paciente, codigo_medico)
FOREIGN KEY (CPF_paciente) REFERENCES paciente (CPF),
FOREIGN KEY (codigo_medico) REFERENCES medico (codigo)
)
GO


INSERT INTO paciente VALUES
             ('35454562890', 'José Rubens', 'Campos Salles', 2750, 'Centro', '21450998', '1954-10-18'),
			 ('29865439810', 'Ana Claudia', 'Sete de Setembro', 178, 'Centro', '97382764', '1960-05-29'),
			 ('82176534800', 'Marcos Aurélio', 'Timóteo Penteado', 236, 'Vila Galvão', '68172651', '1980-09-24'),
			 ('12386758770', 'Maria Rita', 'Castello Branco', 7765, 'Vila Rosália', NULL, '1975-03-30'),
			 ('92173458910', 'Joana de Souza', 'XV de Novembro', 298, 'Centro', '21276578', '1944-04-24')
GO


INSERT INTO medico (codigo, nome, especialidade)
VALUES             (1, 'Wilson Cesar', 'Pediatra')
GO

INSERT INTO medico (codigo, nome, especialidade)
VALUES             (2, 'Marcia Matos', 'Geriatra')
GO

INSERT INTO medico (codigo, nome, especialidade)
VALUES             (3, 'Carolina Oliveira', 'Ortopedista')
GO

INSERT INTO medico (codigo, nome, especialidade)
VALUES             (4, 'Vinicius Araujo', 'Clinico Geral')
GO


INSERT INTO prontuario (data, CPF_paciente, codigo_medico, diagnostico, medicamento) 
VALUES              ('2020-09-10', '35454562890', 2, 'Reumatismo', 'Celebra')
GO

INSERT INTO prontuario (data, CPF_paciente, codigo_medico, diagnostico, medicamento) 
VALUES				('2020-09-10', '92173458910', 2, 'Renite Alérgica', 'Allegra')
GO

INSERT INTO prontuario (data, CPF_paciente, codigo_medico, diagnostico, medicamento) 
VALUES				('2020-09-12', '29865439810', 1, 'Inflamação de garganta', 'Nimesulina')
GO

INSERT INTO prontuario (data, CPF_paciente, codigo_medico, diagnostico, medicamento) 
VALUES				('2020-09-13', '35454562890', 2, 'H1N1', 'Tamiflu')
GO

INSERT INTO prontuario (data, CPF_paciente, codigo_medico, diagnostico, medicamento) 
VALUES				('2020-09-15', '82176534800', 4, 'Gripe', 'Resprin')
GO

INSERT INTO prontuario (data, CPF_paciente, codigo_medico, diagnostico, medicamento) 
VALUES				('2020-09-15', '12386758770', 3, 'Braço Quebrado',	'Dorflex + Gesso')
GO					




--SELECT SIMPLES
--1)

SELECT nome, 
       rua + ', ' + CAST(Nº AS varchar(5)) +', ' + bairro AS endereco_conct


FROM paciente
WHERE DATEDIFF(YEAR,  data_Nasc, GETDATE()) > 50


--2)
SELECT especialidade
FROM medico
WHERE nome LIKE 'Caroli%' 



--3)

SELECT medicamento
FROM prontuario
WHERE diagnostico LIKE '%eumati%'


--SELECT COM SUBQUERYS

--4)

SELECT diagnostico, medicamento 
FROM prontuario
WHERE CPF_paciente IN (
            SELECT CPF
			FROM paciente 
			WHERE nome = 'José Rubens'           
					   )

--5)

SELECT nome, 
	   SUBSTRING(especialidade, 1, 3) + '.' AS especialidade
FROM medico
WHERE codigo IN(
               SELECT codigo_medico
			   FROM prontuario 
			   WHERE CPF_paciente IN(
			                         SELECT CPF 
									 FROM paciente
									 WHERE nome = 'José Rubens'
									 
									 ) 
				)

--6)

SELECT SUBSTRING(CPF, 1, 3) + '.' + SUBSTRING(CPF, 4, 3 ) + '.' + SUBSTRING(CPF, 7, 3) + '-' + SUBSTRING(CPF, 10, 2) AS CPF,
       nome,
	   rua +', ' + CAST(Nº AS VARCHAR(5)) + ', ' + bairro AS Endereço_completo,
	   CASE WHEN telefone IS NULL
	   THEN   '       -'
	   ELSE telefone
	   END AS telefone
FROM paciente
WHERE CPF IN (
             SELECT CPF_paciente 
			 FROM prontuario
			 WHERE codigo_medico IN (
			                        SELECT codigo
									FROM medico 
									WHERE nome LIKE 'Vinicius%'
			                        )   
			 )



--7)

SELECT DATEDIFF(DAY, data, GETDATE()) AS dias_desde_consulta
FROM prontuario
WHERE CPF_paciente IN (
                       SELECT CPF
					   FROM paciente
					   WHERE nome = 'Maria Rita'
                      )

--UPDATES


UPDATE paciente
SET telefone = '98345621'
WHERE nome = 'Maria Rita'


UPDATE paciente
SET rua = 'Voluntarios da Patria',
    Nº = 1980,
	bairro = 'Jd. Aeroporto' 
WHERE nome = 'Joana de Souza'




SELECT * FROM paciente
SELECT * FROM prontuario 
SELECT * FROM medico

