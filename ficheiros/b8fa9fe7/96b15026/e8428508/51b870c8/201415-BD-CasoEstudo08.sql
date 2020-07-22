--
-- Sistemas de Bases de Dados
--
--  ****   ****
-- **  ** **  **
-- **  **  ****
-- **  ** **  **
--  ****   ****
--
-- Folhas de Exercícios Práticos de Aplicação (SEMANA 08)
-- A Linguagem SQL
-- Resolução de problemas envolvendo consultas simples e complexas e operações de atualizacao
-- de uma base de dados, 
-- Belo, O., 2014

-- OBS.: As soluções aqui apresentadas para cada um dos exercícios da folha de 
--       exercícios semanal foram desenvolvidas com base nos vários requisitos expostos 
--       e discutidos na aula e, como tal, devem ser encaradas apenas como simples propostas 
--       de soluções que, em alguns casos, incorporaram algumas pequenas coisas mais. 
--       Outras soluções, com certeza, existem para os casos apresentados. 

-- Indicação da base de dados de trabalho.
USE UnknownX;

-- Exercício 01
-- Qual é o nome do gerente dos clientes da cidade de ‘Porto? Apresente a lista ordenada de forma 
-- crescente por nome do funcionário?
SELECT DISTINCT FU.Id, FU.Nome
	FROM Clientes AS CL INNER JOIN Funcionarios AS FU
		ON CL.Gerente = FU.Id
	WHERE CL.Localidade = 'Porto'
	ORDER BY FU.Nome ASC;


-- Exercício 02
-- Quais foram os relatórios realizados por funcionários com a função ‘Porteiro’ a clientes que 
-- desenvolvem a sua atividade em ‘Construção e Obras’?
SELECT FU.Id, FN.Designacao, RE.Tipo, RE.Descricao, 
	CL.Id, AI.Designacao
	FROM Relatorios AS RE INNER JOIN Funcionarios AS FU
		ON RE.Funcionario = FU.Id
		INNER JOIN Funcoes AS FN
			ON FU.Funcao = FN.Id
			INNER JOIN Clientes AS CL
				ON RE.Cliente=CL.Id
				INNER JOIN Atividades AS AI
					ON CL.Atividade= AI.id
	WHERE FN.Designacao = 'Porteiro' AND
		  AI.Designacao = 'Construção e Obras';

-- Uma possível solução alternativa...
SELECT FU.Id, FN.Designacao, RE.Tipo, RE.Descricao, 
	CL.Id, AI.Designacao
	FROM Relatorios AS RE INNER JOIN Funcionarios AS FU
		ON RE.Funcionario = FU.Id
		INNER JOIN (
					SELECT Id, Designacao 
						FROM Funcoes
						WHERE Designacao = 'Porteiro'
					) AS FN
			ON FU.Funcao = FN.Id
			INNER JOIN Clientes AS CL
				ON RE.Cliente=CL.Id
				INNER JOIN (
							SELECT * 
								FROM Atividades
								WHERE Designacao = 'Construção e Obras'
							) AS AI
					ON CL.Atividade= AI.id;

-- Uma outra possível solução alternativa...
SELECT FU.Id, FN.Designacao, RE.Tipo, RE.Descricao, 
	CL.Id, AI.Designacao
	FROM Relatorios AS RE, Funcionarios AS FU, 
		 Funcoes AS FN, Clientes AS CL, Atividades AS AI
	WHERE 
		RE.Funcionario = FU.Id AND
		FU.Funcao = FN.Id AND
		RE.Cliente=CL.Id AND
		CL.Atividade= AI.id AND
		FN.Designacao = 'Porteiro' AND
		AI.Designacao = 'Construção e Obras';


-- Exercício 03
-- Qual é o endereço (“Rua”, “Localidade” e “CodPostal”) e eMail dos funcionários da empresa 
-- que não têm a função de ‘Porteiro’?
SELECT FU.Nome, Fu.Rua, Fu.Localidade, FU.CodPostal, 
	FU.eMail
	FROM Funcionarios AS FU
	WHERE FU.Funcao NOT IN (
		SELECT Id
			FROM Funcoes
			WHERE Designacao = 'Porteiro');


-- Exercício 04
-- Quais foram os equipamentos usados nos processos ‘1’, ‘3’ e ‘7’?
SELECT DISTINCT Processo, Equipamento
	FROM ProcessosMaterialEquipamento
	WHERE Processo IN (1,3,7)
	ORDER BY Processo, Equipamento;


-- Exercício 05
-- Quanto custaram por hora os equipamentos que foram utilizados nos processos terminados em ‘2014’?
SELECT PM.Equipamento, ROUND(PM.CustoEquipamento / PM.TempoEquipamento, 2) AS CustoHora
	FROM ProcessosMaterialEquipamento AS PM INNER JOIN Processos AS PR
		ON PM.Processo = PR.Nr
	WHERE YEAR(PR.DataEncerramento) = 2014;


-- Exercício 06
-- Quais as tarefas que foram realizadas por funcionários com a função ‘Operador’ em processos 
-- aprovados em ‘2014’ a clientes da cidade de ‘Braga?
SELECT DISTINCT PT.Tarefa
	FROM Funcionarios AS FU INNER JOIN Funcoes AS FN
		ON FU.Funcao = FN.Id
		INNER JOIN ProcessoTarefasFuncionarios AS PT 
			ON PT.Funcionarios = FU.id
			INNER JOIN Processos as PR
				ON PR.Nr = PT.Processo
				INNER JOIN Clientes AS CL
					ON CL.Id = PR.Cliente
	WHERE FN.Designacao = 'Operador'
		AND YEAR(PR.DataAprovacao) = 2014
		AND CL.Localidade = 'Braga';


-- Exercício 07
-- Insira um novo processo na base de dados com informação á sua escolha. 
INSERT INTO Processos
	(Nr, Cliente, DataProcesso, DataAprovacao, FuncionarioAbriu, FuncionarioAprovou,
	 Descricao, CustoMaterial, Designacao, CustoEquipamento, CustoTarefas, CustoFinal, Observacoes)
	VALUES(88, 8, '2014/11/30', '2014/12/04', 1, 1, 
           'Renovacao de Cozinha com aproveitamento dos materiais existentes', 0.00, 
           'Renovacao de Cozinha', 0.00, 0.00, 0.00, 'Nada a assinalar');

-- Consulta de dados
SELECT *
	FROM Processos;
SELECT *
	FROM Clientes;
SELECT *
	FROM Funcionarios;

-- Registe nesse processo duas tarefas realizadas pelo funcionário ‘1’. 
INSERT INTO ProcessoTarefasFuncionarios
	(Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes, DataExecucao)
	VALUES(88, 1, 1, 10, 100, 'Muito demorada', NOW()),
		  (88, 2, 1, 20, 200, 'Trabalhosa', NOW());

-- Consulta de dados
SELECT *
	FROM ProcessoTarefasFuncionarios;

-- Corrija o tempo anotado para cada um dessas tarefas, multiplicando o seu valor anterior 
-- por 1.25. 
UPDATE ProcessoTarefasFuncionarios
	SET Tempo = Tempo * 1.25
	WHERE Processo = 88;

-- Apague a tarefa que registou em segundo lugar. 
DELETE FROM ProcessoTarefasFuncionarios
	WHERE Processo = 88 AND Tarefa = 2;


-- Exercício 08
-- Quanto custou cada um dos materiais que foi aplicado pelo equipamento ‘1’ em processos de 
-- clientes que têm atividades no sector dos ‘Construção e Obras’?
SELECT PM.Material, SUM(PM.CustoMaterial) AS CustoTotal
	FROM ProcessosMaterialEquipamento AS PM INNER JOIN Processos AS PR
			ON PR.Nr = PM.Processo
			INNER JOIN Clientes AS CL
				ON CL.Id = PR.Cliente
				INNER JOIN Atividades AS AT
					ON AT.Id = CL.Atividade
	WHERE PM.Equipamento = 1
		AND AT.Designacao = 'Construção e Obras'
	GROUP BY PM.Material;

-- Exercício 09
-- Quais as funções dos funcionários que realizaram tarefas em processos terminados em ‘2014’ 
-- que tiveram um custo final superior a 10,000.00€?
SELECT DISTINCT FN.Designacao
	FROM Processos AS PR INNER JOIN ProcessoTarefasFuncionarios AS PT
			ON PR.Nr = PT.Processo
			INNER JOIN Funcionarios AS FU
				ON FU.Id = PT.Funcionarios
				INNER JOIN Funcoes AS FN
					ON FN.Id = FU.Funcao
	WHERE YEAR(PR.DataEncerramento) = 2014
		AND PR.CustoFinal > 10000;


-- Exercício 10
-- Quais foram os 5 processos de obra mais caros de sempre? Apresente-os por ordem decrescente 
-- do seu custo final.
SELECT Nr, Cliente, Designacao, Descricao, CustoFinal
	FROM Processos
	WHERE DataEncerramento IS NOT NULL
	ORDER BY CustoFinal DESC
	LIMIT 5;


-- Exercício 11
-- Quais são os nomes dos fabricantes do equipamento que foi utilizado para aplicar ‘Material Base’ 
-- em processos dos clientes de ‘Barcelos’ que desenvolvem atividades na ‘Comercio e Serviços'?
SELECT DISTINCT FA.Designacao
	FROM ProcessosMaterialEquipamento AS PM INNER JOIN Material AS MA
		ON PM.Material = MA.id
		INNER JOIN Processos AS PR
			ON PR.Nr = PM.Processo
			INNER JOIN Clientes AS CL
				ON CL.Id = PR.Cliente
				INNER JOIN Atividades AS AT
					ON AT.Id = CL.Atividade
					INNER JOIN Equipamentos AS EQ
						ON EQ.Id = PM.Equipamento
						INNER JOIN Fabricante AS FA
							ON FA.id = EQ.Fabricante 
	WHERE MA.Designacao = 'Material Base'
		AND AT.Designacao = 'Comercio e Serviços'
		AND CL.Localidade = 'Barcelos';


-- Exercício 12
-- Remova da bases de dados todos os equipamento que não intervieram em nenhum processo de obra 
-- até hoje.
-- Obs: A instrução seguinte remove de forma definitiva os dados que envolver.
DELETE FROM Equipamentos
	WHERE id NOT IN (	
		SELECT DISTINCT Equipamento 
			FROM ProcessosMaterialEquipamento); 
--
SELECT * 
	FROM Equipamentos

--
-- <fim>
-- 2014, Belo, O.

