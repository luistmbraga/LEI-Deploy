--
-- Sistemas de Bases de Dados
--
--    ***   ***
--   ****  ****
--     **    **
--     **    **
--     **    **
--
-- Folhas de Exercícios Práticos de Aplicação (SEMANA 11)
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
-- Desenvolva um gatilho para a tabela "ProcessosMaterialEquipamento" para que, sempre que 
-- seja introduzido um novo registo, faça o cálculo dos atributos derivados "CustoMaterial" e 
-- "CustoEquipamento" na tabela "Processos".
DELIMITER $$
CREATE TRIGGER tg_InsereRegisto 
	AFTER INSERT ON ProcessosMaterialEquipamento
	FOR EACH ROW
BEGIN
	UPDATE Processos
		SET CustoMaterial=CustoMaterial+NEW.CustoMaterial, 
			CustoEquipamento=CustoEquipamento+NEW.CustoEquipamento,
			CustoFinal=CustoFinal+NEW.CustoMaterial+NEW.CustoEquipamento
		WHERE Nr = NEW.Processo;
END $$

-- Remocao do gatilho implementado do sistema.
DROP TRIGGER tg_InsereRegisto; 

-- Instruções desenvolvidas para teste e validação do gatilho implementado.
--
UPDATE Processos
	SET CustoMaterial=0,
		CustoEquipamento=0,
		CustoFinal=0
	WHERE Nr=3;

--
DELETE FROM ProcessosMaterialEquipamento
	WHERE Processo = 3; 

--
INSERT INTO ProcessosMaterialEquipamento
	(Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento)
	VALUES
		(3, 1, 1,  0.00, 10.00, 1),
		(3, 1, 2, 10.00, 20.00, 2),
		(3, 2, 1,  0.00, 10.00, 1),
		(3, 2, 2, 10.00, 20.00, 2);
--
SELECT *
	FROM ProcessosMaterialEquipamento
	WHERE Processo = 3; 
--
SELECT *
	FROM Processos
	WHERE Nr = 3; 


-- Exercício 02
-- Desenvolva uma nova versão para o gatilho da alínea anterior para que atualize, também, 
-- o valor do atributo "VolumeNegocios", na tabela “Clientes”, com os custos de equipamento e 
-- de material acabados de registar na tabela “ProcessosMaterialEquipamento”, e que depois 
-- insira um novo registo na tabela "PagamentosFabricantes" – uma tabela que se terá que criar 
-- especialmente para este exercício - com a informação relativa à data do registo, ao 
-- equipamento utilizado, ao tempo de utilização e ao custo a pagar pela utilização do 
-- equipamento (10% do custo registado). 
-- Versão 1
DELIMITER $$
CREATE TRIGGER tg_InsereRegisto 
	AFTER INSERT ON ProcessosMaterialEquipamento
	FOR EACH ROW
BEGIN
	DECLARE NrCLiente INT; 
	DECLARE NrFabricante INT;
	UPDATE Processos
		SET CustoMaterial=CustoMaterial+NEW.CustoMaterial, 
			CustoEquipamento=CustoEquipamento+NEW.CustoEquipamento,
			CustoFinal=CustoFinal+NEW.CustoMaterial+NEW.CustoEquipamento
		WHERE Nr = NEW.Processo;
	SELECT Cliente INTO NrCliente
		FROM Processos
		Where Nr = NEW.Processo;
	UPDATE Clientes
		SET VolumeNegocios=VolumeNegocios+NEW.CustoMaterial+NEW.CustoEquipamento
		WHERE Id = NrCliente;
	SELECT Fabricante INTO NrFabricante
		FROM Equipamentos
		Where Id = NEW.Equipamento;
	INSERT INTO PagamentosFabricantes
		(DataRegisto, Processo, Equipamento, Fabricante, Tempo, APagar)
		VALUES(NOW(), NEW.Processo, NrFabricante, NEW.Equipamento, 
			NEW.TempoEquipamento, NEW.CustoEquipamento*0.1);
END $$

-- Remocao do gatilho implementado.
DROP TRIGGER tg_InsereRegisto; 

-- Instruções necessárias para o teste e validação do gatilho desenvolvido.
-- Criação da tabela "PagamentosFabricantes"
CREATE TABLE PagamentosFabricantes (
	NrPagamento INT auto_increment NOT NULL,
	DataRegisto DATETIME NOT NULL, 
	Processo INT NOT NULL, 
	Equipamento INT NOT NULL, 
	Fabricante INT NOT NULL, 
	Tempo INT NOT NULL, 
	APagar DECIMAL(10,2) NOT NULL DEFAULT 0,
	PRIMARY KEY (NrPagamento)
);

-- Remocao da tabela 'PagamentosFabricantes' do sistema.
DROP TABLE PagamentosFabricantes;

-- Consulta dos dados contidos na tabela 'PagamentosFabricantes' 
SELECT *
	FROM PagamentosFabricantes;


-- Resolvendo o mesmo exercício,mas agora utilizando transações. 
-- Versão 2
-- Criacao do gatilho
DELIMITER $$
CREATE TRIGGER tg_InsereRegisto 
	AFTER INSERT ON ProcessosMaterialEquipamento
	FOR EACH ROW
BEGIN
	-- Invocação do procedimento armazenado para a execução da transação.
	CALL sp_InsereRegisto(NEW.Processo,NEW.Equipamento,NEW.CustoMaterial,NEW.CustoEquipamento,NEW.TempoEquipamento); 
END $$

-- Remocao do gatilho do sistema
DROP TRIGGER tg_InsereRegisto; 

-- Criacao do procedimento 
DELIMITER $$
CREATE PROCEDURE sp_InsereRegisto (
	IN NEWProcesso INT, 
	IN NEWEquipamento INT,
	IN NEWCustoMaterial DECIMAL(12,2),
	IN NEWCustoEquipamento DECIMAL(12,2),
	IN NEWTempoEquipamento INT)
BEGIN
	DECLARE NrCLiente INT; 
	DECLARE NrFabricante INT;
	-- Declaração de um handler para tratamento de erros.
    DECLARE Erro BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET Erro = 1;
	-- Definição do início da transação.
	START TRANSACTION;
	UPDATE Processos
		SET CustoMaterial=CustoMaterial+NEWCustoMaterial, 
			CustoEquipamento=CustoEquipamento+NEWCustoEquipamento,
			CustoFinal=CustoFinal+NEWCustoMaterial+NEWCustoEquipamento
		WHERE Nr = NEWProcesso;
	SELECT Nr INTO NrCliente
		FROM Processos
		Where Nr = NEWProcesso;
	UPDATE Clientes
		SET VolumeNegocios=VolumeNegocios+NEWCustoMaterial+NEWCustoEquipamento
		WHERE Id = NrCliente;
	SELECT Fabricante INTO NrFabricante
		FROM Equipamentos
		Where Id = NEWEquipamento;
	INSERT INTO PagamentosFabricantes
		(DataRegisto, Processo, Equipamento, Fabricante, Tempo, APagar)
		VALUES(NOW(), NEWProcesso, NrFabricante, NEWEquipamento, NEWTempoEquipamento, NEWCustoEquipamento*0.1);
	-- Verificação se ocorreu ou não algum erro.
    IF Erro THEN
		-- Desfazer qualquer operação anterior que tenha sido realizada com sucesso.
        ROLLBACK;
    ELSE
		-- Confirmar as operações realizadas.
        COMMIT;
    END IF;
END $$


-- Exercício 03
-- Utilizando cursores, desenvolva um pequeno procedimento que "envie" um cartão de aniversário 
-- a todos os funcionários que façam hoje anos.
-- Criação do procedimento.
DELIMITER $$
CREATE PROCEDURE sp_FelizAniversario 
	(OUT Cartoes VARCHAR(5000))
BEGIN
	-- Declaração da variável de suporte ao handler
	DECLARE Fim INTEGER DEFAULT 0;
	-- Declaração das variáveis para acolhimento dos dados dos clientes.
	DECLARE nomefuncionario CHAR(75);
	DECLARE datanasc DATETIME;
	DECLARE anos INT;
	-- Declaração do cursor para acolher os dados dos processos.
	DEClARE cs_Aniversariantes CURSOR FOR 
		SELECT Nome, DataNascimento
			FROM Funcionarios
			WHERE DAY(DataNascimento) = DAY(NOW()) AND
				MONTH(DataNascimento) = MONTH(NOW())
			ORDER BY DataNascimento ASC;
	-- Declaração do handler, necessária para detetar o final do cursor.
	DECLARE CONTINUE HANDLER 
		FOR NOT FOUND SET Fim = 1;
	-- Abertura e carregamento do curso com os dados.
	OPEN cs_Aniversariantes;
	-- Ciclo para fazer a travessia de todas as linhas do cursor.
	fazcartoes: LOOP
		-- Obtenção dos dados de uma linha do cursor.
		FETCH cs_Aniversariantes 
			INTO nomefuncionario, datanasc;
		IF fim = 1 THEN 
			LEAVE fazcartoes;
		END IF;
		-- Construção da lista com os cartoes de aniversário.
		SET anos = YEAR(NOW()) - YEAR (datanasc);
		SET Cartoes = CONCAT("Parabéns ",nomefuncionario,", pelos seus ",anos, " anos.;");
	END LOOP fazcartoes;
	CLOSE cs_Aniversariantes;
END $$ 
DELIMITER ;

-- Alguma preparação de dados antes da execução do procedimento.
UPDATE Funcionarios
	SET DataNascimento = NOW()
	WHERE id = 1;

-- Execução do procedimento implementado.
CALL sp_FelizAniversario(@Cartoes);
-- Intrução que representa o envio dos cartões. :-)
SELECT @Cartoes;

-- Remoção do procedimento criado do sistema.
DROP PROCEDURE sp_FelizAniversario;


-- Exercício 04
-- Utilizando cursores, desenvolva um procedimento que para cada processo de obra em curso, 
-- dos clientes de uma dada localidade, prepare uma pequena “folha informativa" contendo 
-- informação sobre a última tarefa que nele foi realizada.

-- É necessário fazer alguma preparação da base de dados: alteração do esquema 
-- da tabela "ProcessosTarefasFuncionarios", com a adição de um novo atributo 'DataExecucao'.
ALTER TABLE ProcessoTarefasFuncionarios
	ADD DataExecucao DATE NOT NULL;

-- Atualização de dados na tabela alterada. 
SET SQL_SAFE_UPDATES = 0;
UPDATE ProcessoTarefasFuncionarios
	SET DataExecucao = NOW();

-- Verificação do estado atual dos dados na tabela alterada.
SELECT *
	FROM ProcessoTarefasFuncionarios;

-- Realização da mesma alteração na tabela 'ProcessosMaterialEquipamento'
ALTER TABLE ProcessosMaterialEquipamento
	ADD DataExecucao DATE NOT NULL;

-- Execução do procedimento criado.
SET @Tarefas = "<Início>";
CALL sp_UTRProcessosLocalidade ('Braga', @Tarefas);
SELECT @Tarefas;

-- Remoção do procedimento criado.
DROP PROCEDURE sp_UTRProcessosLocalidade;

-- Criação do procedimento.
DELIMITER $$
CREATE PROCEDURE sp_UTRProcessosLocalidade 
	(IN NomeLocalidade VARCHAR(50), INOUT Tarefas VARCHAR(5000))
BEGIN
	-- Declaração da variável de suporte ao handler
	DECLARE Fim INTEGER DEFAULT 0;
	-- Declaração das variáveis para acolhimento dos dados dos clientes.
	DECLARE idprocesso INT;
	DECLARE nomecliente CHAR(75);
	DECLARE ultimatarefa CHAR(75);
	DECLARE linhaprocesso CHAR(200);
	-- Declaração da variável para preparação da folha informativa.
	DECLARE Tarefa varchar(100) DEFAULT "";
	-- Declaração do cursor para acolher os dados dos processos.
	DEClARE cs_Processos CURSOR FOR 
		SELECT Pr.Nr, Cl.Designacao 
			FROM Processos AS Pr INNER JOIN Clientes AS Cl
				ON Pr.Cliente = Cl.Id
			WHERE DataAprovacao IS NOT NULL AND
				DataEncerramento IS NULL AND
				Localidade = NomeLocalidade;
	-- Declaração do handler, necessária para detetar o final do cursor.
	DECLARE CONTINUE HANDLER 
		FOR NOT FOUND SET Fim = 1;
	-- Abertura e carregamento do curso com os dados.
	OPEN cs_Processos;
	-- Ciclo para fazer a travessia de todas as linhas do cursor.
	listaprocessos: LOOP
		-- Obtenção dos dados de uma linha do cursor.
		FETCH cs_Processos 
			INTO idprocesso, nomecliente;
		IF fim = 1 THEN 
			LEAVE listaprocessos;
		END IF;
		-- Construção da lista com a última tarefa realizada para cada processo.
		SELECT Ta.Designacao INTO ultimatarefa 
			FROM ProcessoTarefasFuncionarios AS Pt INNER JOIN Tarefas AS Ta
					ON Pt.Tarefa = Ta.id
			WHERE Pt.Processo = idprocesso
			ORDER BY Pt.DataExecucao DESC
			LIMIT 1;
		SET linhaprocesso = CONCAT(idprocesso,"-",nomecliente,"-",ultimatarefa);
		SET Tarefas = CONCAT(Tarefas,";",linhaprocesso);
	END LOOP listaprocessos;
	CLOSE cs_processos;
	SET Tarefas = CONCAT(Tarefas,";",'<Fim>');
END $$ 
DELIMITER ;


--
-- <fim>
-- 2014, Belo, O.
