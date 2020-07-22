--
-- Sistemas de Bases de Dados
--
--  ****   ****
-- **  **      **
-- **  **     **
-- **  **    **
--  ****   **
--
-- Folhas de Exercícios Práticos de Aplicação (SEMANA 07)
-- A Linguagem SQL
-- Resolução de problemas envolvendo consultas simples e complexas sobre uma base de dados, 
-- Belo, O., 2014

-- OBS.: As soluções aqui apresentadas para cada um dos exercícios da folha de 
--       exercícios semanal foram desenvolvidas com base nos vários requisitos expostos 
--       e discutidos na aula e, como tal, devem ser encaradas apenas como simples propostas 
--       de soluções que, em alguns casos, incorporaram algumas pequenas coisas mais. 
--       Outras soluções, com certeza, existem para os casos apresentados. 

-- Indicação da base de dados de trabalho.
USE UnknownX;

-- Exercício 01
-- Quais são os clientes (“id”,”Designacao”) da empresa que têm um número de processos (“NrProcessos”) 
-- superior a 10 e um volume de negócios (“VolumeNegocios”) inferior a 50000 €?
SELECT id, Designacao
	FROM Clientes
	WHERE NrProcessos > 10
		AND VolumeNegocios < 50000;


-- Exercício 02
-- Quais foram os custos finais (CustoFinal) dos processos realizados para o cliente 
-- ‘Grupo Lusitano de Beneficência’ (Designacao)? 
SELECT CL.ID, CL.Designacao, PR.CustoFinal
	FROM Processos AS PR INNER JOIN Clientes AS CL
		ON PR.Cliente = CL.id
	WHERE CL.Designacao = 'Grupo Lusitano de Beneficência';


-- Exercício 03
-- Quais são as tarefas (“id”,”Designacao”) que foram realizadas em processos registados em ‘2014’ 
-- (“DataProcesso”) dos clientes ‘1’, ‘2’ e ‘3’?
SELECT DISTINCT TA.Id, TA.Designacao
	FROM Processos AS PR INNER JOIN ProcessoTarefasFuncionarios AS PT
		ON PR.Nr = PT.Processo	
		INNER JOIN Tarefas AS TA
			ON TA.id = PT.Tarefa
	WHERE YEAR(PR.DataProcesso) = 2014 
		AND PR.Cliente IN (1,2,3);


-- Exercício 04
-- Quais foram os funcionários da empresa (“Nome”) que realizaram tarefas de ‘Limpeza de chão de obra’ 
-- e ‘Pintura de paredes’ (“Designacao”) em processos dos clientes  ‘1’, ‘2’ e ‘3’ (“Id”), 
-- entre ‘2013/10/01’ e ‘2014/09/01’ (“DataProcesso”)?
SELECT DISTINCT FU.Nome
	FROM Processos AS PR INNER JOIN ProcessoTarefasFuncionarios AS PT
		ON PR.Nr = PT.Processo	
		INNER JOIN Tarefas AS TA
			ON TA.id = PT.Tarefa
			INNER JOIN Funcionarios AS FU
				ON FU.id = PT.Funcionarios
	WHERE PR.DataProcesso BETWEEN '2013/10/01' AND '2014/09/01'
		AND PR.Cliente IN (1,2,3)
		AND (TA.Designacao = 'Limpeza de chão de obra' OR TA.Designacao = 'Pintura de paredes');


--
-- <fim>
-- 2014, Belo, O.

