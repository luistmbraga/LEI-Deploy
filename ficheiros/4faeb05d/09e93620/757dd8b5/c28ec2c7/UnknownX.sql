DROP SCHEMA IF EXISTS builtdb;
CREATE SCHEMA IF NOT EXISTS BuiltDB DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE BuiltDB;


-- -----------------------
-- CRIAR BASE DE DADOS --
-- -----------------------
-- Funcoes
--
CREATE TABLE IF NOT EXISTS Funcoes (
	id INT NOT NULL,
    Designacao VARCHAR (75) NOT NULL,
    PRIMARY KEY (id))
ENGINE = InnoDB;

-- Funcionarios
--
CREATE TABLE IF NOT EXISTS Funcionarios (
	id INT NOT NULL,
    Nome VARCHAR (75),
    DataNascimento DATE NOT NULL,
    Rua VARCHAR (75) NULL,
    Localidade VARCHAR (50) NULL,
    CodPostal VARCHAR (60) NULL,
    DataInicioServico DATE NULL,
    AnosServico INT NULL,
    Telefone1 VARCHAR (25) NULL,
    Telefone2 VARCHAR (25) NULL,
    eMail VARCHAR (100) NULL,
    Funcao INT NULL,
    Observacoes TEXT NULL,
    Chefe INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_Funcionarios_Funcao1 FOREIGN KEY (Funcao) REFERENCES Funcoes (id) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
    CONSTRAINT fk_Funcionarios_Chefe1 FOREIGN KEY (Chefe) REFERENCES Funcionarios (id)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Atividades
-- 
CREATE TABLE IF NOT EXISTS Atividades (
	id INT NOT NULL,
    Designacao VARCHAR (75) NOT NULL,
    PRIMARY KEY (id))
ENGINE = InnoDB;
 
    
-- Clientes
--
CREATE TABLE IF NOT EXISTS Clientes (
	id INT NOT NULL,
    Designacao VARCHAR (75) NULL,
    NrContribuinte INT NULL,
    Contacto VARCHAR (75) NULL,
    Atividade INT NULL,
    Rua VARCHAR (75) NULL,
    Localidade VARCHAR (50) NULL,
    CodPostal VARCHAR (60) NULL,
    Telefone VARCHAR (25) NULL,
    Fax VARCHAR (25) NULL,
    eMail VARCHAR (100) NULL,
    NrProcessos INT NULL DEFAULT 0,
    VolumeNegocios DECIMAL (12,2) NULL DEFAULT 0,
    Gerente INT NULL,
    Observacoes TEXT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_Clientes_Funcionarios1 FOREIGN KEY (Gerente) REFERENCES Funcionarios (id)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
    CONSTRAINT fk_Clientes_Atividades1 FOREIGN KEY (Atividade) REFERENCES Atividades (id)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
    

-- Processos
--
CREATE TABLE IF NOT EXISTS Processos (
	Nr INT NOT NULL,
    Cliente INT NULL,
    DataProcesso DATE NULL,
    DataAprovacao DATE NULL,
    DataEncerramento DATE NULL,
    FuncionarioAbriu INT NULL,
    FuncionarioAprovou INT NULL,
    FuncionarioEncerrou INT NULL,
    Descricao TEXT NULL,
    CustoMaterial DECIMAL (12,2) NULL DEFAULT 0,
    Designacao VARCHAR (75) NULL,
    CustoTarefas DECIMAL (12,2) NULL DEFAULT 0,
    CustoEquipamento DECIMAL (12,2) NULL DEFAULT 0,
    CustoFinal DECIMAL (12,2) NULL DEFAULT 0,
    Observacoes TEXT NULL,
    PRIMARY KEY (Nr),
    CONSTRAINT fk_Processos_Clientes1 FOREIGN KEY (Cliente) REFERENCES Clientes (id)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
    CONSTRAINT fk_Processos_Funcionarios1 FOREIGN KEY (FuncionarioAbriu) REFERENCES Funcionarios (id)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
    CONSTRAINT fk_Processos_Funcionarios2 FOREIGN KEY (FuncionarioAprovou)  REFERENCES Funcionarios (id)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
    CONSTRAINT fk_Processos_Funcionarios3 FOREIGN KEY (FuncionarioEncerrou)  REFERENCES Funcionarios (id)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Tarefas
--
CREATE TABLE IF NOT EXISTS Tarefas (
	id INT NOT NULL,
	Designacao VARCHAR (75) NOT NULL,
    CustoHora DECIMAL (12,2) NOT NULL,
    PRIMARY KEY (id))
ENGINE = InnoDB;
    

-- Fabricante
--
CREATE TABLE IF NOT EXISTS Fabricante (
	id INT NOT NULL,
    Designacao VARCHAR (75) NULL,
    Observacoes TEXT NULL,
    PRIMARY KEY (id))
ENGINE = InnoDB;


-- Equipamentos
--
CREATE TABLE IF NOT EXISTS Equipamentos (
	id INT NOT NULL,
	Designacao VARCHAR(75) NOT NULL,
	CustoHora DECIMAL(6,2) NOT NULL,
	Descricao TEXT NULL,
	Fabricante INT NULL,
	CustoAquisição DECIMAL(18,2) NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_Equipamentos_Fabricante1 FOREIGN KEY (Fabricante) REFERENCES Fabricante (id)
	ON DELETE NO ACTION 
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Material
--
CREATE TABLE IF NOT EXISTS Material (
	id INT NOT NULL,
	Designacao VARCHAR(75) NOT NULL,
	PrecoBase DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- Relatorios
--
CREATE TABLE IF NOT EXISTS Relatorios (
	Cliente INT NOT NULL,
	DataRegisto DATETIME NOT NULL,
	Funcionario INT NOT NULL,
	Tipo CHAR(1) NOT NULL,
	Descricao TEXT NOT NULL,
	PRIMARY KEY (Cliente, DataRegisto),
	CONSTRAINT fk_Relatorios_Clientes FOREIGN KEY (Cliente) REFERENCES Clientes (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
	CONSTRAINT fk_Relatorios_Funcionários1 FOREIGN KEY (Funcionario) REFERENCES Funcionarios (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- ProcessoDocumentos
--
CREATE TABLE IF NOT EXISTS ProcessoDocumentos (
	Processo INT NOT NULL,
	Nr INT NOT NULL,
	Descricao VARCHAR(75) NOT NULL,
	Ficheiro VARCHAR(100) NOT NULL,
	PRIMARY KEY (Processo, Nr),
	CONSTRAINT fk_ProcessoDocumentos_Processos1 FOREIGN KEY (Processo) REFERENCES Processos (Nr)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- ProcessosMaterialEquipamento
--
CREATE TABLE IF NOT EXISTS ProcessosMaterialEquipamento (
	Processo INT NOT NULL,
	Material INT NOT NULL,
	Equipamento INT NOT NULL,
	CustoMaterial DECIMAL(10,2) NULL DEFAULT 0,
	CustoEquipamento DECIMAL(10,2) NULL DEFAULT 0,
	TempoEquipamento INT NOT NULL,
	PRIMARY KEY (Processo, Material, Equipamento),
	CONSTRAINT fk_ProcessosMaterialEquipamento_Equipamento1 FOREIGN KEY (Equipamento) REFERENCES Equipamentos (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
	CONSTRAINT fk_ProcessosMaterialEquipamento_Material1 FOREIGN KEY (Material) REFERENCES Material (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
	CONSTRAINT fk_ProcessosMaterialEquipamento_Processos1 FOREIGN KEY (Processo) REFERENCES Processos (Nr)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- ProcessoTarefasFuncionarios
--
CREATE TABLE IF NOT EXISTS ProcessoTarefasFuncionarios (
	Processo INT NOT NULL,
    Tarefa INT NOT NULL,
    Funcionarios INT NOT NULL,
    Tempo INT,
    CustoTarefa DECIMAL (10,2),
    Observacoes TEXT,
    PRIMARY KEY (Processo, Tarefa, Funcionarios),
    CONSTRAINT fk_ProcessosTarefasFuncionarios_Processos1 FOREIGN KEY (Processo) REFERENCES Processos (Nr)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
	CONSTRAINT fk_ProcessosTarefasFuncionarios_Tarefa1  FOREIGN KEY (Tarefa) REFERENCES Tarefas (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
	CONSTRAINT fk_ProcessosTarefasFuncionarios_Funcionarios1 FOREIGN KEY (Funcionarios) REFERENCES Funcionarios (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- ------------------------
-- POVOAR BASE DE DADOS --
-- ------------------------

INSERT INTO Atividades (id, Designacao) VALUES (1,'Construção e Obras');
INSERT INTO Atividades (id, Designacao) VALUES (2,'Caça e Pesca');
INSERT INTO Atividades (id, Designacao) VALUES (3,'Comercio e Serviços');
INSERT INTO Atividades (id, Designacao) VALUES (4,'Vendas a Retalho');
INSERT INTO Atividades (id, Designacao) VALUES (5,'importação e Expertação');

INSERT INTO Fabricante (id, Designacao, Observacoes) VALUES (1,'Empresa de Equipamento do SUL','Empresa de Lisboa');
INSERT INTO Fabricante (id, Designacao, Observacoes) VALUES (2,'Empresa de Equipamentos do Norte','Empresa do Porto');
INSERT INTO Fabricante (id, Designacao, Observacoes) VALUES (3,'Empresa de Equipamentos do Centro','Empresa do Centro');
INSERT INTO Fabricante (id, Designacao, Observacoes) VALUES (4,'Empresa Espanhola de Equipamentos','Empresa de Espanha');
INSERT INTO Fabricante (id, Designacao, Observacoes) VALUES (5,'Empresa de Italiana','Itália');

INSERT INTO Equipamentos (id, Designacao, CustoHora, Descricao, Fabricante, CustoAquisição) VALUES (1,'Equipamento de Corte',150.00,'Para Corte',1,120000.00);
INSERT INTO Equipamentos (id, Designacao, CustoHora, Descricao, Fabricante, CustoAquisição) VALUES (2,'Equipamento de Montagem',200.00,'Para Montagem',2,300000.00);
INSERT INTO Equipamentos (id, Designacao, CustoHora, Descricao, Fabricante, CustoAquisição) VALUES (3,'Equipamento de Acabamento',180.00,'Para Acabamento',3,100000.00);
INSERT INTO Equipamentos (id, Designacao, CustoHora, Descricao, Fabricante, CustoAquisição) VALUES (4,'Equipamento de Embalagem',210.00,'Para Embalagem',4,240000.00);
INSERT INTO Equipamentos (id, Designacao, CustoHora, Descricao, Fabricante, CustoAquisição) VALUES (5,'Equipamento de Pintura',95.00,'Para Pintura',1,50000.00);
INSERT INTO Equipamentos (id, Designacao, CustoHora, Descricao, Fabricante, CustoAquisição) VALUES (6,'Equipamento de Transporte',430.00,'Para Transporte',5,500000.00);
INSERT INTO Equipamentos (id, Designacao, CustoHora, Descricao, Fabricante, CustoAquisição) VALUES (7,'Equipamento de ELevação',230.00,'Para Elevação',5,236000.00);
INSERT INTO Equipamentos (id, Designacao, CustoHora, Descricao, Fabricante, CustoAquisição) VALUES (8,'Equipamento de Lavagem',190.00,'Para Lavagem',1,100000.00);
INSERT INTO Equipamentos (id, Designacao, CustoHora, Descricao, Fabricante, CustoAquisição) VALUES (9,'Equipamento de Secagem',210.00,'Para Secagem',2,230000.00);

INSERT INTO Funcoes (id, Designacao) VALUES (1,'Gerente');
INSERT INTO Funcoes (id, Designacao) VALUES (2,'Diretor de Departamento');
INSERT INTO Funcoes (id, Designacao) VALUES (3,'Secretário');
INSERT INTO Funcoes (id, Designacao) VALUES (4,'Telefonista');
INSERT INTO Funcoes (id, Designacao) VALUES (5,'Gestor de Cliente');
INSERT INTO Funcoes (id, Designacao) VALUES (6,'Operador de Máquinas');
INSERT INTO Funcoes (id, Designacao) VALUES (7,'Porteiro');
INSERT INTO Funcoes (id, Designacao) VALUES (8,'Programador');
INSERT INTO Funcoes (id, Designacao) VALUES (9,'Técnico Superior');

INSERT INTO Material (id, Designacao, PrecoBase) VALUES (1,'Material Base',98.00);
INSERT INTO Material (id, Designacao, PrecoBase) VALUES (2,'Material Composto',102.00);
INSERT INTO Material (id, Designacao, PrecoBase) VALUES (3,'Material para Montar',57.00);
INSERT INTO Material (id, Designacao, PrecoBase) VALUES (4,'Material para Pintar',88.00);
INSERT INTO Material (id, Designacao, PrecoBase) VALUES (5,'Material para Compor',64.00);
INSERT INTO Material (id, Designacao, PrecoBase) VALUES (6,'Material Auxiliar',27.00);
INSERT INTO Material (id, Designacao, PrecoBase) VALUES (7,'Material de Acabamento',59.00);
INSERT INTO Material (id, Designacao, PrecoBase) VALUES (8,'Material de Embalagem',70.00);

INSERT INTO Funcionarios (id, Nome, DataNascimento, Rua, Localidade, CodPostal, DataInicioServico, AnosServico, Telefone1, Telefone2, eMail, Funcao, Observacoes, Chefe) VALUES (1,'Grande Chefe','1950-01-20','Rua Unknown','Braga','4700-002 BRAGA','1990-01-01',24,'96728888',NULL,'gc@unknownx.pt',1,'Patrão',1);
INSERT INTO Funcionarios (id, Nome, DataNascimento, Rua, Localidade, CodPostal, DataInicioServico, AnosServico, Telefone1, Telefone2, eMail, Funcao, Observacoes, Chefe) VALUES (2,'Primeiro Sub Chefe','1960-10-21','Rua de Baixo, 10','V.N.Famalicão','4900-011 FAMALICAO','1990-01-01',24,'93001001',NULL,'psc@unknownx.pt',2,'Sem',1);
INSERT INTO Funcionarios (id, Nome, DataNascimento, Rua, Localidade, CodPostal, DataInicioServico, AnosServico, Telefone1, Telefone2, eMail, Funcao, Observacoes, Chefe) VALUES (3,'Segundo Sub Chefe','1964-11-11','Rua de Baixo, 20','V.N.Famalicão','4900-011 FAMALICAO','1990-01-01',24,'93001002',NULL,'ssc@unknownx.pt',2,'Sem',1);
INSERT INTO Funcionarios (id, Nome, DataNascimento, Rua, Localidade, CodPostal, DataInicioServico, AnosServico, Telefone1, Telefone2, eMail, Funcao, Observacoes, Chefe) VALUES (4,'Terceiro Sub Chefe','1963-09-12','Rua de Baixo, 30','V.N.Famalicão','4900-011 FAMALICAO','1990-01-01',24,'93001003',NULL,'tsc@unknownx.pt',2,'Sem',1);
INSERT INTO Funcionarios (id, Nome, DataNascimento, Rua, Localidade, CodPostal, DataInicioServico, AnosServico, Telefone1, Telefone2, eMail, Funcao, Observacoes, Chefe) VALUES (5,'José Porteiro','1970-05-02','Rua de Cima, 30','Barcelos','4750-200 BARCELOS','1995-04-01',19,'93001203',NULL,'jp@unknownx.pt',7,'Sem',1);
INSERT INTO Funcionarios (id, Nome, DataNascimento, Rua, Localidade, CodPostal, DataInicioServico, AnosServico, Telefone1, Telefone2, eMail, Funcao, Observacoes, Chefe) VALUES (6,'Manuel Silva','1968-10-11','Rua do Sobe e Desce, 11','Braga','4700-002 BRAGA','1999-02-01',15,'93001203',NULL,'ms@unknownx.pt',5,'Sem',2);
INSERT INTO Funcionarios (id, Nome, DataNascimento, Rua, Localidade, CodPostal, DataInicioServico, AnosServico, Telefone1, Telefone2, eMail, Funcao, Observacoes, Chefe) VALUES (7,'António Marques','1972-04-03','Rua da Parte de Cima, 2','Braga','4700-003 BRAGA','1999-02-01',15,'93001204',NULL,'am@unknownx.pt',5,'Sem',2);
INSERT INTO Funcionarios (id, Nome, DataNascimento, Rua, Localidade, CodPostal, DataInicioServico, AnosServico, Telefone1, Telefone2, eMail, Funcao, Observacoes, Chefe) VALUES (8,'José Mourinho','1969-03-25','Avenida do Centro, 4','Braga','4700-000 BRAGA','1999-02-01',15,'93003333',NULL,'jm@unknownx.pt',5,'Sem',2);

INSERT INTO Tarefas (id, Designacao, CustoHora) VALUES (1,'Levantamento de Requisitos',25.00);
INSERT INTO Tarefas (id, Designacao, CustoHora) VALUES (2,'Programação de máquinas',40.00);
INSERT INTO Tarefas (id, Designacao, CustoHora) VALUES (3,'Tradução de Manuais',35.00);
INSERT INTO Tarefas (id, Designacao, CustoHora) VALUES (4,'Montagem de Equipamentos',30.00);
INSERT INTO Tarefas (id, Designacao, CustoHora) VALUES (5,'Embalagem',28.00);
INSERT INTO Tarefas (id, Designacao, CustoHora) VALUES (6,'Manutenção de Equipamento',35.00);
INSERT INTO Tarefas (id, Designacao, CustoHora) VALUES (7,'Gestão de Projeto',48.00);

INSERT INTO Clientes (id, Designacao, NrContribuinte, Contacto, Atividade, Rua, Localidade, CodPostal, Telefone, Fax, eMail, NrProcessos, VolumeNegocios, Gerente, Observacoes) VALUES (1,'Empresa de Produção Total',989100100,'Sr Silva',1,'Rua de Cima','Braga','4700-001 BRAGA','99100100','98100000','ept_geral@ept.pt',3,5000000.00,2,'Não Tem');
INSERT INTO Clientes (id, Designacao, NrContribuinte, Contacto, Atividade, Rua, Localidade, CodPostal, Telefone, Fax, eMail, NrProcessos, VolumeNegocios, Gerente, Observacoes) VALUES (2,'Empresa de Total',989100101,'Sr Manuel',3,'Rua de Baixo','Porto','4400-001 PORTO','99100101','98100000','edt_geral@ept.pt',3,4000000.00,3,'Não Tem');
INSERT INTO Clientes (id, Designacao, NrContribuinte, Contacto, Atividade, Rua, Localidade, CodPostal, Telefone, Fax, eMail, NrProcessos, VolumeNegocios, Gerente, Observacoes) VALUES (3,'Empresa do Faz Tudo',989100102,'Sr António Silva',5,'Rua do Meio','Braga','4700-001 BRAGA','99100103','98100000','eft_geral@ept.pt',1,450000.00,3,'Não Tem');
INSERT INTO Clientes (id, Designacao, NrContribuinte, Contacto, Atividade, Rua, Localidade, CodPostal, Telefone, Fax, eMail, NrProcessos, VolumeNegocios, Gerente, Observacoes) VALUES (4,'Empresa de Tudo Bom',989100103,'Sr José',1,'Avenida Principal','Vila do Conde','4480-001 VILA DO CONDE','99100104','98100000','etb_geral@ept.pt',1,5000000.00,4,'Não Tem');
INSERT INTO Clientes (id, Designacao, NrContribuinte, Contacto, Atividade, Rua, Localidade, CodPostal, Telefone, Fax, eMail, NrProcessos, VolumeNegocios, Gerente, Observacoes) VALUES (5,'Empresa de Vale Tudo',989100104,'Sr Pedro',4,'Avenida Central','Braga','4700-001 BRAGA','99100105','98100000','evt_geral@ept.pt',1,2300000.00,4,'Vai ter');
INSERT INTO Clientes (id, Designacao, NrContribuinte, Contacto, Atividade, Rua, Localidade, CodPostal, Telefone, Fax, eMail, NrProcessos, VolumeNegocios, Gerente, Observacoes) VALUES (6,'Empresa do Melhor',989100105,'Sr Rui Silva',4,'Rua Central','Porto','4400-001 PORTO','99100106','98100000','em_geral@ept.pt',1,10000000.00,2,'Não Tem');
INSERT INTO Clientes (id, Designacao, NrContribuinte, Contacto, Atividade, Rua, Localidade, CodPostal, Telefone, Fax, eMail, NrProcessos, VolumeNegocios, Gerente, Observacoes) VALUES (7,'Empresa de Transportes',989100106,'Sr Pedro Rocha',1,'Rua Principal','Barcelos','4750-001 BARCELOS','99100107','98100000','et_geral@ept.pt',0,304999.00,3,'Vai ter');
INSERT INTO Clientes (id, Designacao, NrContribuinte, Contacto, Atividade, Rua, Localidade, CodPostal, Telefone, Fax, eMail, NrProcessos, VolumeNegocios, Gerente, Observacoes) VALUES (8,'Empresa para Todos',989100107,'Sr Carlos Santos',3,'Avenida Lateral','Porto','4400-001 PORTO','99100108','98100000','epto_geral@ept.pt',0,10002000.00,2,'Não Tem');

INSERT INTO Processos (Nr, Cliente, DataProcesso, DataAprovacao, DataEncerramento, FuncionarioAbriu, FuncionarioAprovou, FuncionarioEncerrou, Descricao, CustoMaterial, Designacao, CustoEquipamento, CustoTarefas, CustoFinal, Observacoes) VALUES (1,1,'2014-07-20','2014-07-30',NULL,6,2,NULL,'Processo Geral C1',345.00,'Processo Nº1',3460.00,714.00,0.00,'Sem Obs');
INSERT INTO Processos (Nr, Cliente, DataProcesso, DataAprovacao, DataEncerramento, FuncionarioAbriu, FuncionarioAprovou, FuncionarioEncerrou, Descricao, CustoMaterial, Designacao, CustoEquipamento, CustoTarefas, CustoFinal, Observacoes) VALUES (2,1,'2014-07-15','2014-07-30',NULL,7,3,NULL,'Processo Geral C1',159.00,'Processo Nº2',1295.00,595.00,0.00,'Sem Obs');
INSERT INTO Processos (Nr, Cliente, DataProcesso, DataAprovacao, DataEncerramento, FuncionarioAbriu, FuncionarioAprovou, FuncionarioEncerrou, Descricao, CustoMaterial, Designacao, CustoEquipamento, CustoTarefas, CustoFinal, Observacoes) VALUES (3,2,'2014-10-27',NULL,NULL,7,NULL,NULL,'Processo Geral C2',0.00,'Processo Nº3',0.00,0.00,0.00,'Sem Obs');
INSERT INTO Processos (Nr, Cliente, DataProcesso, DataAprovacao, DataEncerramento, FuncionarioAbriu, FuncionarioAprovou, FuncionarioEncerrou, Descricao, CustoMaterial, Designacao, CustoEquipamento, CustoTarefas, CustoFinal, Observacoes) VALUES (4,3,'2014-07-02','2014-07-30',NULL,6,3,NULL,'Processo Geral C3',189.00,'Processo Nº4',1210.00,358.00,0.00,'Sem Obs');
INSERT INTO Processos (Nr, Cliente, DataProcesso, DataAprovacao, DataEncerramento, FuncionarioAbriu, FuncionarioAprovou, FuncionarioEncerrou, Descricao, CustoMaterial, Designacao, CustoEquipamento, CustoTarefas, CustoFinal, Observacoes) VALUES (5,4,'2014-08-02','2014-08-30',NULL,8,2,NULL,'Processo Geral C4',98.00,'Processo Nº5',1500.00,0.00,0.00,'Sem Obs');
INSERT INTO Processos (Nr, Cliente, DataProcesso, DataAprovacao, DataEncerramento, FuncionarioAbriu, FuncionarioAprovou, FuncionarioEncerrou, Descricao, CustoMaterial, Designacao, CustoEquipamento, CustoTarefas, CustoFinal, Observacoes) VALUES (6,2,'2014-10-02',NULL,NULL,6,NULL,NULL,'Processo Geral C2',316.00,'Processo Nº6',4990.00,0.00,0.00,'Sem Obs');
INSERT INTO Processos (Nr, Cliente, DataProcesso, DataAprovacao, DataEncerramento, FuncionarioAbriu, FuncionarioAprovou, FuncionarioEncerrou, Descricao, CustoMaterial, Designacao, CustoEquipamento, CustoTarefas, CustoFinal, Observacoes) VALUES (7,5,'2014-10-28','2014-10-30',NULL,8,3,NULL,'Processo Geral C5',168.00,'Processo Nº7',2310.00,295.00,0.00,'Sem Obs');
INSERT INTO Processos (Nr, Cliente, DataProcesso, DataAprovacao, DataEncerramento, FuncionarioAbriu, FuncionarioAprovou, FuncionarioEncerrou, Descricao, CustoMaterial, Designacao, CustoEquipamento, CustoTarefas, CustoFinal, Observacoes) VALUES (8,6,'2014-08-12','2014-08-30',NULL,6,2,NULL,'Processo Geral C6',0.00,'Processo Nº8',0.00,393.00,0.00,'Sem Obs');
INSERT INTO Processos (Nr, Cliente, DataProcesso, DataAprovacao, DataEncerramento, FuncionarioAbriu, FuncionarioAprovou, FuncionarioEncerrou, Descricao, CustoMaterial, Designacao, CustoEquipamento, CustoTarefas, CustoFinal, Observacoes) VALUES (9,2,'2014-09-23','2014-09-30',NULL,7,3,NULL,'Processo Geral C2',0.00,'Processo Nº9',0.00,0.00,0.00,'Sem Obs');
INSERT INTO Processos (Nr, Cliente, DataProcesso, DataAprovacao, DataEncerramento, FuncionarioAbriu, FuncionarioAprovou, FuncionarioEncerrou, Descricao, CustoMaterial, Designacao, CustoEquipamento, CustoTarefas, CustoFinal, Observacoes) VALUES (10,1,'2014-09-15','2014-09-30',NULL,7,2,NULL,'Processo Geral C1',0.00,'Processo Nº10',0.00,0.00,0.00,'Sem Obs');
INSERT INTO Processos (Nr, Cliente, DataProcesso, DataAprovacao, DataEncerramento, FuncionarioAbriu, FuncionarioAprovou, FuncionarioEncerrou, Descricao, CustoMaterial, Designacao, CustoEquipamento, CustoTarefas, CustoFinal, Observacoes) VALUES (11,1,'2007-09-15','2007-09-30',NULL,7,2,NULL,'Processo Geral C1',0.00,'Processo Nº11',0.00,0.00,0.00,'Sem Obs');

INSERT INTO Relatorios (Cliente, DataRegisto, Funcionario, Tipo, Descricao) VALUES (1,'2014-07-27 00:00:00',5,'B','Relatório de Acompanhamento');
INSERT INTO Relatorios (Cliente, DataRegisto, Funcionario, Tipo, Descricao) VALUES (1,'2014-10-01 00:00:00',6,'A','Relatório de Análise');
INSERT INTO Relatorios (Cliente, DataRegisto, Funcionario, Tipo, Descricao) VALUES (1,'2014-10-03 00:00:00',5,'B','Relatório de Acompanhamento');
INSERT INTO Relatorios (Cliente, DataRegisto, Funcionario, Tipo, Descricao) VALUES (2,'2014-07-13 00:00:00',6,'A','Relatório de Análise');
INSERT INTO Relatorios (Cliente, DataRegisto, Funcionario, Tipo, Descricao) VALUES (2,'2014-09-11 00:00:00',5,'A','Relatório de Análise');
INSERT INTO Relatorios (Cliente, DataRegisto, Funcionario, Tipo, Descricao) VALUES (3,'2014-07-01 00:00:00',4,'C','Relatório de Avaliação');
INSERT INTO Relatorios (Cliente, DataRegisto, Funcionario, Tipo, Descricao) VALUES (3,'2014-07-21 00:00:00',4,'C','Relatório de Avaliação');
INSERT INTO Relatorios (Cliente, DataRegisto, Funcionario, Tipo, Descricao) VALUES (3,'2014-08-20 00:00:00',6,'B','Relatório de Acompanhamento');
INSERT INTO Relatorios (Cliente, DataRegisto, Funcionario, Tipo, Descricao) VALUES (4,'2014-06-22 00:00:00',5,'A','Relatório de Análise');
INSERT INTO Relatorios (Cliente, DataRegisto, Funcionario, Tipo, Descricao) VALUES (4,'2014-09-22 00:00:00',6,'A','Relatório de Análise');
INSERT INTO Relatorios (Cliente, DataRegisto, Funcionario, Tipo, Descricao) VALUES (5,'2014-09-17 00:00:00',4,'C','Relatório de Avaliação');
INSERT INTO Relatorios (Cliente, DataRegisto, Funcionario, Tipo, Descricao) VALUES (6,'2014-03-28 00:00:00',5,'B','Relatório de Acompanhamento');


INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (1,1,'Documento 1','ficheiro11');
INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (1,2,'Documento 2','ficheiro12');
INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (1,3,'Documento 3','ficheiro13');
INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (1,4,'Documento 4','ficheiro14');
INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (2,1,'Documento 1','ficheiro21');
INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (2,2,'Documento 2','ficheiro22');
INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (2,3,'Documento 3','ficheiro23');
INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (3,1,'Documento 1','ficheiro31');
INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (3,2,'Documento 2','ficheiro32');
INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (3,3,'Documento 3','ficheiro33');
INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (4,1,'Documento 1','ficheiro41');
INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (5,1,'Documento 1','ficheiro51');
INSERT INTO ProcessoDocumentos (Processo, Nr, Descricao, Ficheiro) VALUES (5,2,'Documento 2','ficheiro52');

INSERT INTO ProcessoTarefasFuncionarios (Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes) VALUES (1,1,6,10,250.00,'Sem Obs');
INSERT INTO ProcessoTarefasFuncionarios (Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes) VALUES (1,4,6,8,240.00,'Sem Obs');
INSERT INTO ProcessoTarefasFuncionarios (Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes) VALUES (1,5,6,8,224.00,'Sem Obs');
INSERT INTO ProcessoTarefasFuncionarios (Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes) VALUES (2,1,7,7,175.00,'Sem Obs');
INSERT INTO ProcessoTarefasFuncionarios (Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes) VALUES (2,3,8,12,420.00,'Sem Obs');
INSERT INTO ProcessoTarefasFuncionarios (Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes) VALUES (4,1,8,2,50.00,'Sem Obs');
INSERT INTO ProcessoTarefasFuncionarios (Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes) VALUES (4,5,7,1,28.00,'Sem Obs');
INSERT INTO ProcessoTarefasFuncionarios (Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes) VALUES (4,6,7,8,280.00,'Sem Obs');
INSERT INTO ProcessoTarefasFuncionarios (Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes) VALUES (7,1,6,2,50.00,'Sem Obs');
INSERT INTO ProcessoTarefasFuncionarios (Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes) VALUES (7,3,6,7,245.00,'Sem Obs');
INSERT INTO ProcessoTarefasFuncionarios (Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes) VALUES (8,1,7,9,225.00,'Sem Obs');
INSERT INTO ProcessoTarefasFuncionarios (Processo, Tarefa, Funcionarios, Tempo, CustoTarefa, Observacoes) VALUES (8,5,7,6,168.00,'Sem Obs');

INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (1,1,2,98.00,2000.00,10);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (1,2,1,102.00,300.00,2);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (1,3,2,57.00,800.00,4);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (1,4,3,88.00,360.00,2);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (2,2,5,102.00,665.00,7);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (2,3,4,57.00,630.00,3);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (4,1,5,98.00,760.00,8);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (4,5,1,64.00,300.00,2);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (4,6,1,27.00,150.00,1);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (5,1,1,98.00,1500.00,10);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (6,1,2,98.00,1600.00,8);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (6,2,7,102.00,2760.00,12);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (6,3,7,57.00,230.00,1);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (6,7,2,59.00,400.00,2);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (7,1,3,98.00,1260.00,7);
INSERT INTO ProcessosMaterialEquipamento (Processo, Material, Equipamento, CustoMaterial, CustoEquipamento, TempoEquipamento) VALUES (7,8,4,70.00,1050.00,5);


--
-- Caso 6

-- a) Quais são os clientes ({id, Designacao, Contacto}) da empresa da cidade de ‘Braga’?
SELECT id,designacao,contacto FROM Clientes WHERE localidade = 'Braga';


-- b) Quais os clientes ({Designacao}) que tiveram processos registados e encerrados em ‘2014’?
SELECT Cl.Designacao 
	FROM Clientes AS Cl INNER JOIN Processos AS Pr
		ON Cl.id = Pr.Cliente 
	WHERE year(Pr.DataProcesso) = '2014' OR 
		year(Pr.DataEncerramento) = '2014';


-- c) Quais foram os documentos ({Descricao}) que foram entregues em projetos cujo custo final excedeu ‘1000000€’? 
SELECT Pd.Descricao
	FROM processodocumentos AS Pd INNER JOIN processos AS Pr
		ON Pd.Processo = Pr.Nr
	WHERE CustoFinal > '1000000';
    

-- d) Quais os foram os custos ({Cliente, CustoMaterial, CustoEquipamento e CustoFinal}) dos processos dos clientes ‘1’ e ‘11’ que foram aprovados entre ‘2013’ e ‘2014’?
SELECT Pr.Cliente, Pr.CustoMaterial, Pr.CustoEquipamento, Pr.CustoFinal
	FROM Processos AS Pr
	Where Pr.Cliente = '1' OR Pr.Cliente = '11' AND
		year(Pr.DataAprovacao) = '2013' AND year(Pr.DataAprovacao) = '2014';
        
        
-- e) Quais foram as tarefas ({id, Designacao}) que foram realizadas nos projetos do cliente ‘1’?
SELECT Tar.id, Tar.Designacao
	FROM Tarefas AS Tar INNER JOIN ProcessoTarefasFuncionarios AS Ptf
		ON Tar.id = Ptf.Tarefa
        INNER JOIN Processos as Pr
			ON Pr.Nr = Ptf.Processo
	WHERE Pr.Cliente = '1';
    

-- f) Que funções ({id, Designacao}) têm os funcionários que encerraram projetos de clientes que residem na cidade de ‘Vila Nova de Famalicão’?
SELECT F1.Id, F1.Designacao 
	FROM Funcoes as F1 INNER JOIN Funcionarios AS F2
		ON F1.id = F2.Funcao
        INNER JOIN Processos AS Pr
			ON F2.id = Pr.FuncionarioEncerrou
            INNER JOIN Clientes AS Cl
				ON Pr.Cliente = Cl.id
	WHERE Cl.Localidade = 'Vila Nova de Famalicão';
    

-- g) Quais dos funcionários da empresa ({Nome}) que residem em ‘V.N.Famalicão’ aprovaram projetos de clientes que também aí residem, durante o ano de 2007? 
SELECT F1.Nome 
	FROM Funcionarios AS F1 INNER JOIN Processos AS Pr
		ON F1.id = Pr.FuncionarioAprovou
        INNER JOIN Clientes AS Cl
			ON Pr.Cliente = Cl.Id
	WHERE F1.Localidade = 'V.N.Famalicão' OR Cl.Localidade = 'Famalicao' AND year(Pr.DataAprovacao) = '2007';
    
    
-- h) Quais são os endereços dos clientes e dos funcionários ({Nome, Rua, Localidade, CodPostal}) que moram em ‘São Martinho de Riba d’Aire’?



-- i) Quais são os fabricantes dos equipamentos ({id, Designacao}) que foram utilizados em processos de clientes geridos pelo funcionário ‘Felisberto da Costa Castro e Canto’? 
SELECT Fb.Id, Fb.Designacao
	FROM Fabricante AS Fb INNER JOIN Equipamentos AS Eq
		ON Fb.id = Eq.Fabricante
        INNER JOIN Processosmaterialequipamento AS Pme
			ON Eq.id = Pme.Equipamento
            INNER JOIN Processos AS Pr
				ON Pme.Processo = Pr.Nr
                INNER JOIN Clientes AS Cl
					ON Pr.Cliente = Cl.id
                    INNER JOIN Funcionarios As Func
						ON Cl.Gerente = Func.id
	WHERE Func.Nome = 'Felisberto da Costa Castro e Canto';
    
    
-- j) Quais foram os materiais ({id, Designacao, PrecoBase}) que foram utilizados com os equipamentos ‘1’ e ‘2’ em processos dos clientes ‘4’, ‘8’ e ‘34’?
SELECT Mt.id, Mt.Designacao, Mt.PrecoBase
	FROM Material AS Mt INNER JOIN ProcessosMaterialEquipamento AS Pme
		ON Mt.id = Pme.Material
        INNER JOIN Equipamentos AS Eq
			ON Pme.Equipamento = Eq.id
            INNER JOIN Processos AS Pr
				ON Pme.Processo = Pr.Nr
	WHERE Eq.id = '1' AND Eq.id = '2' AND Pr.Cliente = '4' OR Pr.Cliente = '8' OR Pr.Cliente = '34';
    
-- 
-- Caso 7

-- a) Quais são os clientes (“id”,”Designacao”) da empresa que têm um número de processos(“NrProcessos”) superior a 10 e um volume de negócios (“VolumeNegocios”) inferior a 50000€? 
SELECT Cl.Id, Cl.Designacao
	FROM Clientes AS Cl
    WHERE Cl.NrProcessos > '2' AND Cl.VolumeNegocios < '50000';
    
    
-- b) Quais foram os custos finais (CustoFinal) dos processos realizados para o cliente ‘Grupo Lusitano de Beneficência’ (Designacao)? 
SELECT Pr.CustoFinal 
	FROM Processos AS Pr INNER JOIN Clientes AS Cl
		ON Pr.Cliente = Cl.id
	WHERE Cl.Designacao = 'Grupo Lusitano de Beneficência';


-- c) Quais são as tarefas (“id”,”Designacao”) que foram realizadas em processos registados em ‘2014’ (“DataProcesso”) dos clientes ‘1’, ‘2’ e ‘3’? 
SELECT Tar.id, Tar.Designacao
	FROM Tarefas AS Tar INNER JOIN ProcessoTarefasFuncionarios As Ptf
		ON Tar.id = Ptf.Tarefa 
        INNER JOIN Processos AS Pr
			ON Ptf.Processo = Pr.Nr
	WHERE year(DataProcesso = '2014') AND Pr.Cliente IN (1,2,3);
    

-- d) Quais foram os funcionários da empresa (“Nome”) que realizaram tarefas de ‘Limpeza de chão de obra’ e ‘Pintura de paredes’ (“Designacao”) em processos dos clientes ‘1’, ‘2’ e ‘3’ (“Id”), entre ‘2013/10/01’ e ‘2014/09/01’ (“DataProcesso”)? 
SELECT Func.Nome 
	FROM Funcionarios AS Func INNER JOIN ProcessoTarefasFuncionarios AS Ptf
		ON Fun.id = Ptf.Funcionarios 
        INNER JOIN Processos AS Pr
			ON Ptf.Processo = Pr.Nr
            INNER JOIN Tarefas AS Trf
				ON Ptf.Tarefa = Trf.id
	WHERE Pr.DataProcesso BETWEEN '2013-10-01' AND '2014-09-01' AND Pr.Cliente IN (1,2,3) AND Trf.Designacao = 'Limpeza de chão de obra' OR Trf.Designacao = 'Pintura de paredes';
			

-- 19/11/2014
-- pertence = in

select nr from processos where year(dataaprovacao) = '2014'
and cliente in (select id from clientes where localidade = 'Braga'
and gerente in (select id from funcionarios where nome = 'Antonio Marques'));

-- count *: conta as linhas todoas
-- count x: conta as linhas onde o valor está diferente de null
-- count (distinct x): conta o número de registos diferentes
-- funcoes de agregação é no having
-- contar também pode ser feito com group by

select distinct localidade from clientes where
id in (select cliente from processos
group by cliente
having count(dataprocesso) = (select max(valor) from 
(select cliente, count(dataprocesso) valor from processos
group by cliente) a1));


select designacao from equipamentos where
id not in (select a1.equipamento from processosmaterialequipamento a1 join
(select nr from processos where
cliente in (select id from clientes where localidade = 'Braga')) a2
on a1.Processo = a2.nr);


select nr, CustoMaterial+CustoEquipamento+CustoTarefas from processos
order by 2 desc limit 1,2; -- order by 2 = segunda coluna; limit 1,2 = buscar o segundo e terceiro

-- devolver primeiro e quarto resgistos
select * from (select nr, CustoMaterial+CustoEquipamento+CustoTarefas from processos
order by 2 desc limit 1,1) a1
union
select * from (select nr, CustoMaterial+CustoEquipamento+CustoTarefas from processos
order by 2 desc limit 4,1) a2;

select designacao from tarefas where
id in (select tarefa from (
select a1.tarefa, count(*) from processotarefasfuncionarios a1 join -- select tarefas, porque vou contar tarefas
(select nr from processos where custotarefas > '100' and
cliente in (select id from clientes where localidade = 'Braga')) a2
on a1.processo = a2.nr
group by a1.Tarefa
order by 2 desc limit 3) a3); -- order by 2: = ordena pela 2 coluna = count. limit 3: = 3 primeiros

select week(current_date()), weekofyear(current_date());
select sum(CustoMaterial+CustoTarefas+CustoEquipamento) from processos
where year(DataEncerramento) = '2014' and week(DataEncerramento) in (4,5);


select avg(DataAprovacao-DataProcesso), max(DataAprovacao-DataAprovacao) from processos
select nr from processos where
DataAprovacao-DataProcesso = (select max(


