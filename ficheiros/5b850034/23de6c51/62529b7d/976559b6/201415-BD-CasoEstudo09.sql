--
-- Sistemas de Bases de Dados
--
--  ****   ****
-- **  ** **  **
-- **  **  *****
-- **  **     **
--  ****     **
--
-- Folhas de Exercícios Práticos de Aplicação (SEMANA 09)
-- A Linguagem SQL
-- Resolução de problemas envolvendo consultas simples e complexas sobre uma dada base de dados, 
-- Belo, O., 2014

-- OBS.: As soluções aqui apresentadas para cada um dos exercícios da folha de 
--       exercícios semanal foram desenvolvidas com base nos vários requisitos expostos 
--       e discutidos na aula e, como tal, devem ser encaradas apenas como simples propostas 
--       de soluções que, em alguns casos, incorporaram algumas pequenas coisas mais. 
--       Outras soluções, com certeza, existem para os casos apresentados. 

-- Indicação da base de dados de trabalho.
USE UnknownX;

-- Exercício 01
-- Quais os equipamentos que foram utilizados nos processos 
-- aprovados em ‘2014’ a clientes da cidade da ‘Braga, geridos 
-- pelo funcionário ‘António Marques’?
-- 
SELECT DISTINCT PM.Equipamento 
	FROM Clientes AS CL INNER JOIN Processos AS PR
		ON CL.id = PR.Cliente
		INNER JOIN Funcionarios AS FU
			ON FU.id = CL.Gerente
			INNER JOIN ProcessosMaterialEquipamento AS PM
			ON PR.Nr = PM.Processo
	WHERE CL.Localidade = 'Braga' AND
		FU.Nome = 'António Marques' AND
		YEAR(PR.DataAprovacao) = 2014;

-- Uma alternativa...
SELECT DISTINCT PM.Equipamento 
	FROM Clientes AS CL, Processos AS PR, 
		Funcionarios AS FU, ProcessosMaterialEquipamento AS PM
	WHERE CL.Localidade = 'Braga' AND
		FU.Nome = 'António Marques' AND
		YEAR(PR.DataAprovacao) = 2014 AND
		CL.id = PR.Cliente AND
		FU.id = CL.Gerente AND
		PR.Nr = PM.Processo;

-- Uma outra alternativa... 
SELECT DISTINCT PM.Equipamento 
	FROM 
		(SELECT * 
			FROM Clientes 
			WHERE Localidade = 'Braga') AS CL, 
		(SELECT *
			FROM Processos 
			WHERE YEAR(DataAprovacao) = 2014) AS PR, 
		(SELECT * 
			FROM Funcionarios 
			WHERE Nome = 'António Marques') AS FU, 
			ProcessosMaterialEquipamento AS PM
	WHERE 
		CL.id = PR.Cliente AND
		FU.id = CL.Gerente AND
		PR.Nr = PM.Processo;


-- Exercício 02
-- Em que localidades é que residem os clientes que até hoje tiveram o maior 
-- número de processos aprovados?
SELECT CL.Id AS 'NrCliente', CL.Localidade, 
	COUNT(PR.DataAprovacao) AS 'NrProcessos'
	FROM Processos AS PR INNER JOIN Clientes AS CL
		ON PR.Cliente = CL.id
	WHERE PR.DataAprovacao IS NOT NULL
	GROUP BY CL.Id, CL.Localidade
	ORDER BY COUNT(PR.DataAprovacao) DESC
	LIMIT 3;


-- Exercício 03
-- Quais foram os equipamentos que nunca foram utilizados em 
-- processo de clientes da cidade de ‘Braga’.
SELECT EQ.Id, EQ.designacao
	FROM Equipamentos AS EQ
	WHERE EQ.Id NOT IN (
		SELECT DISTINCT PM.Equipamento
			FROM Clientes AS CL INNER JOIN Processos AS PR
				ON CL.id = PR.Cliente
				INNER JOIN ProcessosMaterialEquipamento AS PM
					ON PR.Nr = PM.Processo
			WHERE Localidade = 'Braga');


-- Exercício 04
-- Apresente uma lista com os processos que tiveram o segundo e o terceiro maior 
-- custo final.
SELECT Nr, CustoFinal 
	FROM Processos
	ORDER BY CustoFinal DESC
	LIMIT 1,2;


-- Exercício 05
-- Quais foram as três tarefas mais realizadas em processos de clientes da cidade do ‘Porto’ 
-- cujo custo de tarefas tenha excedido os 1,500.00€?
SELECT PT.Tarefa, COUNT(*) AS Total
	FROM Processos AS PR INNER JOIN ProcessoTarefasFuncionarios AS PT
		ON PR.NR = PT.Processo
		INNER JOIN Clientes AS CL
			ON CL.Id = PR.Cliente
	WHERE CL.Localidade = 'Porto' AND PR.CustoTarefas > 1500
	GROUP BY PT.Tarefa
	ORDER BY Total DESC
	LIMIT 3;


-- Exercício 06
-- Quanto é que foi gasto em materiais, tarefas e equipamentos em todos os processos 
-- encerrados durante o ano de ‘2014’, nas semanas ‘4’ e ‘5’?
SELECT SUM(CustoMaterial) AS VlMaterial, SUM(CustoTarefas) AS VlTarefas, 
	SUM(CustoEquipamento) AS VlEquipamento 
	FROM Processos
	WHERE YEAR(DataEncerramento) = 2014 AND
		WEEK(DataEncerramento) IN (4,5);


-- Exercício 07
-- Quais foram os equipamentos mais utilizados (10+) em processos aprovados pelo 
-- funcionário ‘José Mourinho’, entre ‘Novembro’ de ‘2012’ e ‘Outubro’ de ‘2014’? 
-- Indique também o tempo de operação de cada equipamento. 
SELECT PM.Equipamento AS Equipamento, COUNT(*) AS NRIntervencoes, 
	SUM(PM.TempoEquipamento) AS TempoOperacao
	FROM Processos AS PR INNER JOIN ProcessosMaterialEquipamento AS PM
		ON PR.Nr = PM.Processo
	WHERE PR.FuncionarioAprovou = (SELECT Id FROM Funcionarios WHERE Nome = 'José Mourinho')
		AND DataAprovacao BETWEEN '2012/11/01' AND '2014/10/31'
	GROUP BY PM.Equipamento
	ORDER BY NRIntervencoes DESC
	LIMIT 10;


-- Exercício 08
-- Em média, quanto tempo (em dias) demoram os processos a ser aprovados pela direção 
-- da empresa? Complemente a query de forma a se poder saber também, qual foi o processo 
-- que mais tempo demorou a ser aprovado.
-- Média de dias de aprovação e número de dias do processo mais demorado.
SELECT AVG(DATEDIFF(DataAprovacao,DataProcesso)) AS MediaDiasAprovacao,
	MAX(DATEDIFF(DataAprovacao,DataProcesso)) AS MaiorNrDiasAprovacao 
	FROM Processos
	WHERE DataAprovacao IS NOT NULL;

-- Processo que demorou mais tempo a ser aprovado.
SELECT Nr, DATEDIFF(DataAprovacao,DataProcesso) AS DiasAprovacao
	FROM Processos
	WHERE DataAprovacao IS NOT NULL
	ORDER BY DiasAprovacao DESC
	LIMIT 1;


--
-- <fim>
-- 2014, Belo, O.



