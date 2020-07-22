--
-- Sistemas de Bases de Dados
--
--    ***   ***
--   ****  ****
--     **    **  ****
--     **    ** ** 
--     **    **  ****
--
-- Folhas de Exercícios Práticos de Aplicação (SEMANA 11 - Complemento)
-- Folha de Exercícios Complementar.
-- A Linguagem SQL
-- Resolução de problemas envolvendo manutenção de utilizadores, de índices e definição de 
-- restrições (constraints) sobre tabelas, 
-- Belo, O., 2014

-- OBS.: As soluções aqui apresentadas para cada um dos exercícios da folha de 
--       exercícios semanal foram desenvolvidas com base nos vários requisitos expostos 
--       e discutidos na aula e, como tal, devem ser encaradas apenas como simples propostas 
--       de soluções que, em alguns casos, incorporaram algumas pequenas coisas mais. 
--       Outras soluções, com certeza, existem para os casos apresentados. 

-- Indicação da base de dados de trabalho.
USE UnknownX;


-- Exercício 01
-- Criação de três utilizadores, com diferentes perfis de acesso e de trabalho 
-- sobre a base de dados 'UnknownX'.

-- Criação do utilizador 'admin'
CREATE USER 'admin'@'host';
SET PASSWORD FOR 'admin'@'localhost' = PASSWORD('admin1234');
-- ou de forma alternativa 
CREATE USER 'admin'@'host'
	IDENTIFIED BY PASSWORD 'admin1234';
-- Mudança da password de um utilizador
UPDATE user 
	SET password = PASSWORD('admin4567')
	WHERE user = 'admin' AND host = 'localhost';

-- Criação do utilizador 'prog'
CREATE USER 'prog'@'localhost';
SET PASSWORD FOR 'prog'@'localhost' = PASSWORD('prog1234');

-- Criação do utilizador 'user'
-- Utilizador que apenas pode consultar as tabelas base: Clientes, Processos e Funcionarios.
CREATE USER 'user'@'localhost';
SET PASSWORD FOR 'user'@'localhost' = PASSWORD('user1234');

-- Mudança do nome de um utilizador.
RENAME USER 'user'@'localhost' TO 'user'@'otherhost';

-- Remoção do utilizador do sistema.
DROP USER 'user'@'localhost';

-- Consulta dos utilizadores criados no sistema.
-- Caracterização geral de todos os utilizadores.
SELECT * 
	FROM mysql.user;

-- Caracterização geral de um utilizador em particular.
SELECT * 
	FROM mysql.user
	WHERE User = 'user';

-- Apenas os nomes dos utilizadres e dos sistemas em que estão definidos.
SELECT User, Host 
	FROM mysql.user
	ORDER BY User;


-- Exercício 02
-- Atribuição dos privilégios aos utilizadores criados no exercício anterior.
-- Definição de alguns previlégios para o utilizador 'admin'. Apenas alguns exemplos de aplicação. 
-- Permissão de acesso a todos os objetos de todas as bases de dados em 'localhost'.
GRANT ALL ON *.* TO 'admin'@'localhost';

-- Permissão de acesso a todos os objectos da base de dados 'UnknownX' em 'localhost'.
GRANT ALL ON UnknownX.* TO 'admin'@'localhost';

-- Definição de limite de execução de consultas e de atualizações por hora.
GRANT USAGE ON *.* TO 'admin'@'localhost'
	WITH MAX_QUERIES_PER_HOUR 50 MAX_UPDATES_PER_HOUR 10;

-- Definição de alguns previlégios para o utilizador 'prog'. Apenas alguns exemplos de aplicação.
-- Permissão para a execução de instruções SELECT, INSERT e UPDATE na base de dados 
-- 'UnknownX' em 'localhost'.
GRANT SELECT, INSERT, UPDATE ON  UnknownX.* TO 'prog'@'localhost';

-- Permissão para a criação e execução de procedimentos em 'localhost'.
GRANT CREATE ROUTINE ON UnknownX.* TO 'prog'@'localhost';
GRANT EXECUTE ON PROCEDURE UnknownX.* TO 'prog'@'localhost';

-- Definição de alguns previlégios para o utilizador 'user'. Apenas alguns exemplos de aplicação.
-- Permissão para a execução de instruções SELECT e INSERT sobre a base de dados 
-- 'UnknownX' em 'localhost', apenas sobre as tabelas 'Clientes' e 'Processos'.
GRANT SELECT, INSERT ON UnknownX.Clientes TO 'user'@'localhost';
GRANT SELECT, INSERT ON UnknownX.Processos TO 'user'@'localhost';

-- E apenas de leitura sobre a tabela 'Equipamentos'.
GRANT SELECT ON UnknownX.Equipamentos TO 'user'@'localhost';

-- E apenas de leitura sobre os atributos 'Id' e 'Nome' da tabela 'Funcionários'.
GRANT SELECT (Id, Nome) ON UnknownX.Funcionarios TO 'user'@'localhost';

-- Consulta dos privilégios atribuídos ao utilizador 'user' em 'localhost'.
SHOW GRANTS FOR 'user'@'localhost';

-- Refrescamento dos privilégios dos utilizadores. 
FLUSH PRIVILEGES;


-- Exercício 03
-- Remoção de alguns dos privilégios dos utilizadores criados no exercício anterior.
-- Remoção de previlégios para o utilizador 'admin'. Apenas alguns exemplos de aplicação. 
-- Inibição da execução de instruções DELETE sobre a base de dados 'UnknownX' em 'localhost'.
REVOKE DELETE ON UnknownX.* FROM 'admin'@'localhost';

-- Remoção de todos os tipos de privilégios do utilizador
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'user'@'localhost';


-- Exercício 04
-- Definição de índices. Alguns exemplos de aplicação, apenas para demonstração.
-- A criação deste índice sobre a tabela processos permitirá consultar de forma mais rápida a
-- informação contida nesta tabela a partir do atributo 'DataProcesso'.
CREATE INDEX idx_DataProcesso 
	ON Processos (DataProcesso);

-- A criação deste índice sobre a tabela processos para além de permitir realizar consultas
-- com base no atributo 'NrContribuinte', garante também que dois clientes não tenham
-- o mesmo número de contribuinte uma vez que não permite valores repetidos. 
CREATE UNIQUE INDEX idx_NrContribuinte 
	ON Clientes (NrContribuinte);

-- Exemplo de uma criação de um índice sobre mais do que um atributo.
CREATE INDEX idx_FuncionariosTempo
	ON ProcessoTarefasFuncionarios (Funcionarios, Tempo);

-- Remoção dos índices criados anteriormente.
DROP INDEX idx_DataProcesso ON Processos;
DROP INDEX idx_NrContribuinte ON Clientes;
DROP INDEX idx_FuncionariosTempo ON ProcessoTarefasFuncionarios;

-- Visualização dos índices definidos sobre a tabela 'Processos'.
SHOW INDEX FROM Processos;

-- Visualização de todos os índices criados sobre as tabelas da nossa base de accessible-- dados de trabalho.
SELECT DISTINCT TABLE_NAME, INDEX_NAME
	FROM INFORMATION_SCHEMA.STATISTICS
	WHERE TABLE_SCHEMA = 'UnknownX';


-- Exercício 05
-- Definição de restrições sobre tabelas. Alguns exemplos de aplicação, apenas para demonstração.
-- Exemplo com atribuição de um nome à restrição a aplicar sobre a tabela.
CREATE TABLE Veiculos (
	Id INT NOT NULL,
	Matricula VARCHAR(8) NOT NULL,
	MarcaModelo VARCHAR(50) NOT NULL,
	Tipo CHAR(1) NOT NULL,
	CapacidadeCarga DECIMAL (12,2) DEFAULT 100,
	Funcionario INT,
	LugarParque VARCHAR(100),
	PRIMARY KEY (Id),
	FOREIGN KEY (Funcionario)
		REFERENCES Funcionarios (Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT chk_Veiculos 
		CHECK (Tipo IN ('N','U') AND CapacidadeCarga <= 1000)
);

-- No caso da tabela ter sido criada anteriormente, apenas teríamos que executar a seguinte 
-- instrução para definir a mesma restrição.
ALTER TABLE Veiculos
	ADD CONSTRAINT chk_Veiculos 
		CHECK (Tipo IN ('N','U') AND CapacidadeCarga <= 1000);

-- Porém, se não quisermos atribuir um nome à restrição que queremos estabelecer, então 
-- podemos executar simplesmente a seguinte instrução.
ALTER TABLE Veiculos
	ADD CHECK (Tipo IN ('N','U'));

--
-- <fim>
-- 2014, Belo, O.
