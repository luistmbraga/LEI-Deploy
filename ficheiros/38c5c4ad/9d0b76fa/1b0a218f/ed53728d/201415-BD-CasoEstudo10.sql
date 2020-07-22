--
-- Sistemas de Bases de Dados
--
--    ***  ****
--   **** **  **
--     ** **  **
--     ** **  **
--     **  ****
--
-- Folhas de Exercícios Práticos de Aplicação (SEMANA 10)
-- A Linguagem SQL
-- Resolução de problemas envolvendo vistas, procedimentos armazenados, gatilhos e funções, 
-- Belo, O., 2014

-- OBS.: As soluções aqui apresentadas para cada um dos exercícios da folha de 
--       exercícios semanal foram desenvolvidas com base nos vários requisitos expostos 
--       e discutidos na aula e, como tal, devem ser encaradas apenas como simples propostas 
--       de soluções que, em alguns casos, incorporaram algumas pequenas coisas mais. 
--       Outras soluções, com certeza, existem para os casos apresentados. 

-- Indicação da base de dados de trabalho.
USE UnknownX;


-- Exercício 01
-- Através da definição de uma vista, defina um objeto de dados que permita
-- criar uma única lista de contactos, com endereços postais, telefones e email
-- dos clientes, dos funcionários e dos fabricantes de equipamento, fazendo a separação
-- de cada registo consoante o tipo de contacto incorporado nesse objeto.
-- Criação da vista.
CREATE VIEW vw_ListaContactos AS
	SELECT 'FU' AS Tipo, FU.Id AS Codigo, FU.Nome AS Nome, 
		CONCAT(FU.rua, ', ', FU.localidade, ', ', FU.codpostal) AS Endereco,
		FU.eMail AS eMail
		FROM Funcionarios AS FU
	UNION
	SELECT 'CL', CL.Id, CL.Designacao, 
		CONCAT(CL.rua, ', ', CL.localidade, ', ', CL.codpostal),
		CL.eMail
		FROM Clientes AS CL
	UNION
	SELECT 'FA', Id, Designacao, '<Desconhecido>', '<Desconhecido>'
		FROM Fabricante
	ORDER BY Nome;

-- Remoção da vista do sistema.
DROP VIEW vw_ListaContactos;

-- Exemplos da utilização da vista criada numa query.
-- Numa query simples.
SELECT *
	FROM vw_ListaContactos;

-- Numa query com critérios de filyragem e de ordenação.
SELECT Codigo, Nome, eMail
	FROM vw_ListaContactos
	WHERE Tipo = 'FU'
	ORDER BY Codigo;

-- Numa query com uma subquery e uma operação de junção.
SELECT *
	FROM (SELECT * 
			FROM vw_ListaContactos 
			WHERE Tipo = 'FU') AS VW 
		INNER JOIN Funcionarios AS FU
		ON VW.Codigo = FU.id;


-- Exercício 02
-- Implementar um procedimento que nos indique quais os processos que ainda estão 
-- em curso, há quantos dias e a que clientes pertencem.  
DELIMITER $$
CREATE PROCEDURE sp_ProcessosEmCurso()
BEGIN
	SELECT Nr AS Processo, Cliente AS Cliente, DATEDIFF(NOW(),DataAprovacao) 
		FROM processos
		WHERE DataAprovacao IS NOT NULL AND DataEncerramento IS NULL;
END $$

-- Execução do procedimento do criado.
CALL sp_ProcessosEmCurso;

-- Remoção do procedimento do sistema.
DROP PROCEDURE sp_ProcessosEmCurso;


-- Exercício 03
-- Implementar um procedimento que dado o número de um cliente indique quantos 
-- processos este cliente teve aprovados e,para cada um deles, indique os custos 
-- associados - total, equipamento e tarefas.
-- Alternativa 1 - Dá a informação solicitada, mas não sumariada.
DELIMITER $$
CREATE PROCEDURE sp_ProcessosEmCursoClienteV1
	(IN NrCliente INT)
BEGIN
	SELECT Nr AS Processo, CustoMaterial AS Material, 
		CustoEquipamento AS Equipamento, CustoFinal AS Total
		FROM processos
		WHERE DataAprovacao IS NOT NULL AND 
		Cliente = NrCliente;
END $$

-- Uma outra solução para a query pretendida.
DELIMITER $$
CREATE PROCEDURE sp_ProcessosEmCursoClienteV2
	(IN NrCliente INT)
BEGIN
	SELECT Cliente, COUNT(Nr) AS NrProcessos, 
		SUM(CustoMaterial) AS Material, 
		SUM(CustoEquipamento) AS Equipamento, 
		SUM(CustoFinal) AS Total
		FROM processos
		WHERE DataAprovacao IS NOT NULL 
			AND Cliente = NrCliente
		GROUP BY Cliente;
END $$

-- Execução do procedimento alternativo.
CALL sp_ProcessosEmCursoClienteV2(1);

-- Remoção do procedimento alternativo do sistema.
DROP Procedure sp_ProcessosEmCursoClienteV2;


-- Exercício 04
-- Implementar um procedimento que, para um dado processo aprovado, apresente 
-- um "extrato" contendo uma caracterização breve do processo, uma relação 
-- das tarefas efectuadas, e, por fim, um resumo dos custos imputados a esse processo. 
-- Nesta resolução o referido 'Extrato' será constituído por uma sequência de queries.  
DELIMITER $$
CREATE PROCEDURE sp_ExtratoProcesso
	(IN NrProcesso INT)
BEGIN
	SELECT 'Extrato de Processo', NrProcesso;
	SELECT 'Caracterizaçao';
	SELECT PR.Nr AS Processo, CL.Designacao AS NomeCliente, 
		PR.DataAprovacao AS DataAprovacao, PR.Descricao AS DescricaoProjeto 
		FROM processos AS PR INNER JOIN Clientes AS CL
			ON PR.Cliente = CL.Id
		WHERE PR.DataAprovacao IS NOT NULL 
			AND Nr = NrProcesso;
	SELECT 'Tarefas Realizadas';
	SELECT PR.Nr AS Processo, TA.Designacao AS Tarefa, PT.Tempo, PT.CustoTarefa 
		FROM processos AS PR INNER JOIN ProcessoTarefasFuncionarios AS PT
			ON PR.Nr = PT.Processo
			INNER JOIN Tarefas AS TA
				ON PT.Tarefa=TA.id
		WHERE PR.DataAprovacao IS NOT NULL 
			AND Nr = NrProcesso;
	SELECT 'Resumo dos Custos';
	SELECT Nr, 
		SUM(CustoMaterial) AS Material, 
		SUM(CustoEquipamento) AS Equipamento, 
		SUM(CustoFinal) AS Total
		FROM processos
		WHERE DataAprovacao IS NOT NULL
			AND Nr = NrProcesso
		GROUP BY Nr;
END $$

-- Execução do procedimento criado.
CALL sp_ProcessosEmCursoClienteV2(1);

-- Remoção do procedimento do sistema.
DROP Procedure sp_ExtratoProcesso;


-- Exercício 05
-- Cálculo de um atributo derivado. Implementar um gatilho que atualize o atributo 
-- "NrProcessos" (adicione +1) na tabela "Clientes" sempre que seja introduzido um novo 
-- processo para um dado cliente.
DELIMITER $$
CREATE TRIGGER tg_ActNrProcessosCliente 
	AFTER INSERT ON Processos
	FOR EACH ROW
BEGIN
	UPDATE Clientes
		SET NrProcessos = NrProcessos + 1
		WHERE Id = NEW.Cliente;
END $$

-- Istruções necessárias para a demonstração da atuação do gatilho criado.
SELECT Id, Designacao, NrProcessos
	FROM Clientes
	WHERE Id = 1;
--
INSERT INTO Processos
	(Nr, Cliente, DataProcesso, FuncionarioAbriu, Descricao)
	VALUES(99, 1, NOW(), 1, 'Processo 99');
--
DELETE FROM Processos
	WHERE Nr= 99;


-- Exercício 06
-- Implementar um gatilho que registe numa tabela de auditoria (audClientes) uma referência 
-- a todos os registos que forem removidos da tabela de Clientes, complementando essa 
-- informação com a data e a hora na qual a operação foi realizada.
DELIMITER $$
CREATE TRIGGER tg_AuditoriaClientes 
	AFTER DELETE ON Clientes
	FOR EACH ROW
BEGIN
    INSERT INTO audClientes
		(ClienteId, DataOP, Operacao, UserOp)	
		VALUES (OLD.Id, NOW(), 'Remoção', CURRENT_USER());
END $$

--
DROP TRIGGER tg_AuditoriaClientes;
--
SHOW TRIGGERS;

-- Mas para suportar a operação do gatilho, temos que, promeiro, criar a tabela de auditoria, 
-- uma vez que ela não exste na base de dados.
CREATE TABLE audClientes ( 
    NrOp INT NOT NULL AUTO_INCREMENT, 
    ClienteId INT NOT NULL, 
    DataOP DATETIME NOT NULL, 
    Operacao VARCHAR(50) NOT NULL,
	UserOp VARCHAR(50) NOT NULL,
    PRIMARY KEY (NrOp) 
 );

-- Para obtermos o utilizador corrente
SELECT CURRENT_USER();
-- Apenas o identificador do utilizador
SELECT SUBSTRING_INDEX(USER(),'@',1);
-- Informação acerca do estado do servidor.
SHOW status;

-- 
DROP TABLE audClientes;
--
SELECT * 
	FROM audClientes;
--
INSERT INTO Clientes
	(Id, Designacao)
	VALUES (99, 'Nome do Cliente 99');
--
DELETE FROM Clientes
	WHERE Id = 99;


-- Exercício 07
-- Implementar uma função que dado um dado número de processo, indique o nome do 
-- respetivo cliente.
DELIMITER $$
CREATE FUNCTION fu_LookUpCliente
	(NrCliente INT)
	RETURNS VARCHAR(75)
BEGIN
	DECLARE NomeCliente VARCHAR(75); 
	SELECT Designacao INTO NomeCliente
		FROM Clientes
		WHERE Id = NrCliente;
  RETURN NomeCliente;
END $$

--
SELECT fu_LookUpCliente(1);

--
DROP FUNCTION fu_LookUpCliente;


-- <fim>
-- Unidade Curricular de Bases de Dados 
-- Belo, O., 2014
-- 
