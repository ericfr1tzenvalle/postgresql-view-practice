--DROPS
DROP TABLE IF EXISTS ItemVenda;
DROP TABLE IF EXISTS NotaFiscal;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Departamento;



CREATE TABLE  Cliente 
(	CODCLIENTE serial, 
	NOME VARCHAR(100) NOT NULL, 
	CPF VARCHAR(15) UNIQUE, 
	EMAIL VARCHAR(50), 
	 CONSTRAINT "ClientePK" PRIMARY KEY (CODCLIENTE) 
) ;
CREATE TABLE  Departamento 
(	CODDEPARTAMENTO serial, 
	NOME VARCHAR(100), 
	 CONSTRAINT "DepartamentoPK" PRIMARY KEY (CODDEPARTAMENTO)
) ;
CREATE TABLE Funcionario
(
	codFuncionario serial,
	codDepartamento integer,
	CPF varchar(15) UNIQUE, 
	Nome varchar(50) NOT NULL,
	Salario numeric(7,2) NOT NULL ,
	DataNascimento date,
	Sexo varchar(1),
	Login varchar(50) UNIQUE,
	Senha text,
	codChefe int,
	CONSTRAINT "FuncionarioPK" PRIMARY KEY (codFuncionario),
	CONSTRAINT "CheckSexo" CHECK (Sexo = 'M' or Sexo = 'F'),
	CONSTRAINT "FuncionarioFKDepartamento" FOREIGN KEY (codDepartamento)
		REFERENCES Departamento (codDepartamento)
		on delete set null
		on update cascade,
	CONSTRAINT "FuncionarioFKChefe" FOREIGN KEY (codChefe)
		REFERENCES Funcionario (codFuncionario)
		on delete set null
		on update cascade
);

CREATE TABLE NotaFiscal
(
  codNotaFiscal serial,
  dataVenda date,
  codCliente integer,
  codFuncionario integer,
  CONSTRAINT "NotaFiscalPK" PRIMARY KEY (codNotaFiscal),
  CONSTRAINT "NotaFiscalFKCliente" FOREIGN KEY (codCliente)
      REFERENCES cliente (codcliente) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT "NotaFiscalFKFuncionario" FOREIGN KEY (codFuncionario)
      REFERENCES funcionario (codFuncionario) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Produto
(
	codProduto serial,
	descricao varchar(100) NOT NULL,
	precoUnit numeric(9,2) NOT NULL,
	qtdeEstoque integer NOT NULL,
	CONSTRAINT "ProdutoPK" PRIMARY KEY (codProduto)
);
CREATE TABLE ItemVenda
(
	codProduto integer,
	codNotaFiscal integer,
	quantidade numeric(6,3) NOT NULL,
	precoUnitVenda numeric(9,2) NOT NULL,

	CONSTRAINT "ItemVendaPK" PRIMARY KEY (codProduto, codNotaFiscal),
	CONSTRAINT "ItemVendaFKProduto" FOREIGN KEY (codProduto) 
		REFERENCES Produto (codProduto) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT "ItemVendaFKNotaFiscal" FOREIGN KEY (codNotaFiscal) 
		REFERENCES NotaFiscal (codNotaFiscal) 
);


--inserts	
--clientes
INSERT INTO cliente (nome,cpf,email)VALUES
( 'Maria Julia', '08736201', 'mariah1234@gmail.com'),
( 'Carlos André Cadutra', '8723436201', 'cadutra12@yahoo.com.br'),
( 'Jose Geraldo', '092887221', 'zegege3@hotmail.com'),
( 'Rita Maria Julia Toschini', '01225687321', 'ritinhatoschini@hotmail.com'),
( 'Adriano Carlos Fonseca', '98222187321', 'fonsecao88@gmail.com'),
( 'Paulo Lopes', '121232521', 'fonsecao88@gmail.com'),
( 'José Bruno Lázaro', '45698762433', 'lazarento@hotmail.com');

--deptos
INSERT INTO departamento (nome) VALUES ('TI'),('Marketing'),('Vendas'),('Gestão'),('Produção'),('novo depto');

--funcionarios
INSERT INTO funcionario (codDepartamento,codChefe,CPF,nome,salario,datanascimento,sexo,login,senha) VALUES 
--1
(4,null,'092887221', 'Jose Geraldo', 18765, to_date('02/03/1982','DD/MM/YYYY'), 'M', 'zeh', md5('zehS2')), 	
--2
(1,1,'08736201','Maria Julia', 3765, to_date('02/04/1985','DD/MM/YYYY'), 'F', 'mariah', md5('mariasinha')), 
--3
(4,null,'05722201','Sergio Boss', 15000, to_date('01/12/1975','DD/MM/YYYY'), 'M', 'sBoss', md5('TheBoss')),
--4
(2,1,'765527221', 'Jean Valjean', 4560.7, to_date('10/11/1950','DD/MM/YYYY'), 'M', 'jan', md5('tupeton')),
--5
(5,1,'12998762', 'Ricardo Tote', 1770, to_date('20/09/1997','DD/MM/YYYY'), 'M', 'Cadu', md5('ricardim')),
--6
(4,1,'828722121', 'Geraldo Julio Sperafico', 8765, to_date('28/02/1945','DD/MM/YYYY'), 'M', 'gjs', md5('chefinho')),
--7
(3,3,'121232521', 'Paulo Lopes', 5600, to_date('15/08/1999','DD/MM/YYYY'), 'M', 'lopes', md5('lopespower')),
--8
(5,5,'0344617221','Carla Montenegro', 7000.23,to_date('02/03/1995','DD/MM/YYYY'),'F','carla',md5('gatinha95')),	
--9
(3,7,'09232287221', 'Josefa Fátima', 4666, to_date('12/07/1970','DD/MM/YYYY'), 'F', 'josefa', md5('zehfinha')),
--10
(1,1,'45698762433', 'José Bruno Lázaro', 4200, to_date('12/07/2000','DD/MM/YYYY'), 'M', 'zeLaser', md5('lazarento')),
--11
(null,7,'09232547621', 'Josefa sem depto', 4900, to_date('12/07/1979','DD/MM/YYYY'), 'F', 'semAmiga', md5('semAmiga'));


INSERT INTO produto (descricao, precounit, qtdeEstoque) VALUES 
('achocolatado nescau', 6.7, 100),			--1
('leite integral Damby', 3.2, 300),			--2
('banana prata kg', 4.74, 50),				--3
('tomate gaucho kg', 8.21, 40),				--4
('maça argentina kg', 10.15, 60),			--5
('refrigerante coca-cola lata', 2.85, 500),		--6
('refrigerante coca-cola 2l', 5.15, 400),		--7
('refrigerante guaraná antartica lata', 2.75, 600),	--8
('refrigerante sukita 2l', 5, 450),			--9
('água mineral água da pedra 500ml', 2.15, 1000),	--10
('pão francês "little cacete" kg', 5.85, 200),		--11
('detergente líquido limpol', 3.15, 240),		--12
('shampo  Clear Men do CR7', 10.75, 30),		--13
('creme dental sorriso 4d', 4.99, 25),			--14
('biscoito nesfit sabor chocolate', 2.85, 70),		--15
('Smart TV LED 32" HD Samsung 32J4300 ', 1599.90, 8),	--16 
('papel higiênico neve 40m c/4', 6.15, 48),		--17
('pen drive kingston 4GB', 40.99, 10),			--18 
('cerveja coruja viva weiss', 15.99, 15),		--19
('refrigerante guaraná biri 2l', 1.99, 55),		--20
('erva mate tacapi sabor canela 500g', 7.99, 45); 	--21


--insert de 10 vendas

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '2 years', 6,1);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(1,1,1,6.5), (1,2,2,3.0), (1,4,1.23,10.5);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '1 year 62 days', 6,2);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES (2,3,1.54,	4.22),(2,6,4, 2.39);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '55 days', 5,3);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(3,7,3, 4.99),(3,10,6, 1.99),(3,11,0.54, 5.85),(3,2,3, 2.65);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '50 days', 8,4);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(4,12,1, 2.95),(4,14,3, 3.99),(4,13,2, 9.75),(4,21,1, 6.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '45 days', 6,5);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(5,20,10, 0.99), (5,15,3,  2.85), (5,19,2,  15.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '40 days', 5,6);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(6,16,1, 1699.90),(6,18,2, 45.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '30 days', 8,4);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES (7,20,12, 1.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '1 year 25 days', 6,1);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(8,2,12, 3.2), (8,11,0.3, 5.85), (8,21,1, 7.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '10 days', 6,4);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(9,6,2, 2.80),(9,7,3, 4.75),(9,9,1, 4.5);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '1 day', 3,4);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(10,6,2, 2.80),(10,2,3, 3.10),(10,21,2, 8.49);


-- ================================================
-- 1) View: Dados dos Funcionários com Departamento
-- ================================================
CREATE VIEW listar_funcionarios AS
SELECT
    f.nome,
    f.cpf,
    f.salario,
    f.dataNascimento,
    f.sexo,
    d.nome AS nomeDepartamento
FROM
    funcionario AS f
    LEFT JOIN departamento AS d ON f.coddepartamento = d.coddepartamento;

-- Para remover a view:
-- DROP VIEW listar_funcionarios;

-- Para consultar a view:
SELECT * FROM listar_funcionarios;

-- =============================================================
-- 2) View: Funcionários com Departamento e Nome do Chefe
-- =============================================================
CREATE VIEW listar_func_and_chef AS
SELECT
    f.nome AS nome_funcionario,
    f.cpf,
    f.salario,
    f.dataNascimento,
    f.sexo,
    d.nome AS nome_departamento,
    chefe.nome AS nome_chefe
FROM
    Funcionario AS f
    LEFT JOIN Departamento AS d ON f.coddepartamento = d.coddepartamento
    LEFT JOIN Funcionario AS chefe ON f.codchefe = chefe.codfuncionario;

SELECT * FROM listar_func_and_chef;

-- ========================================================
-- 3) View: Compras por Cliente (Nome, CPF, Total Comprado)
-- ========================================================
CREATE VIEW listar_compras AS
SELECT
    c.nome,
    c.cpf,
    COUNT(n.codcliente) AS numero_compras,
    COALESCE(SUM(i.precounitvenda * i.quantidade), 0.00) AS total_comprado
FROM
    cliente AS c
    LEFT JOIN notafiscal AS n ON c.codCliente = n.codCliente
    LEFT JOIN itemvenda AS i ON i.codnotafiscal = n.codnotafiscal
GROUP BY
    c.nome, c.cpf
ORDER BY
    numero_compras ASC;

-- DROP VIEW listar_compras;

SELECT * FROM listar_compras;

-- ============================================================================
-- 4) Views para diferentes tipos de junção entre Funcionários e Departamentos
-- ============================================================================

-- a) Apenas funcionários com departamentos e vice-versa (INNER JOIN)
DROP VIEW IF EXISTS listar_a_func_com_dep;
CREATE VIEW listar_a_func_com_dep AS
SELECT
    f.nome AS nome_funcionario,
    d.nome AS nome_departamento
FROM
    Funcionario AS f
    INNER JOIN Departamento AS d ON f.coddepartamento = d.coddepartamento;

SELECT * FROM listar_a_func_com_dep;

-- b) Todos os funcionários e somente departamentos relacionados (LEFT JOIN)
DROP VIEW IF EXISTS listar_b_todos_func;
CREATE VIEW listar_b_todos_func AS
SELECT
    f.nome AS nome_funcionario,
    d.nome AS nome_departamento
FROM
    Funcionario AS f
    LEFT JOIN Departamento AS d ON f.coddepartamento = d.coddepartamento;

SELECT * FROM listar_b_todos_func;

-- c) Todos os departamentos e apenas funcionários relacionados (RIGHT JOIN)
DROP VIEW IF EXISTS listar_c_todos_dep;
CREATE VIEW listar_c_todos_dep AS
SELECT
    f.nome AS nome_funcionario,
    d.nome AS nome_departamento
FROM
    Funcionario AS f
    RIGHT JOIN Departamento AS d ON f.coddepartamento = d.coddepartamento;

SELECT * FROM listar_c_todos_dep;

-- d) Todos os funcionários e todos os departamentos (FULL JOIN)
DROP VIEW IF EXISTS listar_d_todos_func_e_dep;
CREATE VIEW listar_d_todos_func_e_dep AS
SELECT
    f.nome AS nome_funcionario,
    d.nome AS nome_departamento
FROM
    Funcionario AS f
    FULL JOIN Departamento AS d ON f.coddepartamento = d.coddepartamento;

SELECT * FROM listar_d_todos_func_e_dep;

-- ============================================================
-- Inserção de Dados para Testes com Funcionários e Departamentos
-- ============================================================

-- Inserir 2 departamentos sem funcionários
INSERT INTO Departamento (nome) VALUES ('Inovação'), ('Qualidade');

-- Inserir 2 funcionários sem vínculo com departamento
INSERT INTO Funcionario (nome, cpf, salario, dataNascimento, sexo, coddepartamento, codchefe)
VALUES
    ('Carla Dias', '111.222.333-44', 3500.00, '1995-03-15', 'F', NULL, NULL),
    ('Bruno Rocha', '555.666.777-88', 4200.00, '1992-11-20', 'M', NULL, NULL);

-- Consultas para verificar as mudanças nas views
SELECT * FROM listar_a_func_com_dep;
SELECT * FROM listar_b_todos_func;
SELECT * FROM listar_c_todos_dep;
SELECT * FROM listar_d_todos_func_e_dep;

-- ========================================
-- 5) O que são índices e sua utilidade
-- ========================================
-- Um índice é uma estrutura de dados que permite acesso mais rápido a linhas específicas em uma tabela.
-- Funciona como o índice de um livro: facilita encontrar rapidamente o que se procura sem precisar percorrer tudo.

-- ================================================
-- 6) Criar um índice na coluna CPF da tabela Funcionario
-- ================================================
CREATE INDEX idx_funcionario_cpf ON Funcionario(cpf);

-- ================================================
-- 7) Otimizar busca por data de emissão na Nota Fiscal
-- ================================================
ALTER TABLE notafiscal ADD COLUMN dataemissao DATE;
CREATE INDEX idx_notafiscal_dataemissao ON notafiscal(dataemissao);

-- ================================================
-- 8) Controle de Transações em Banco de Dados
-- ================================================
-- Transações garantem que um conjunto de operações seja executado completamente ou nenhuma delas.
-- Principais comandos:
-- * BEGIN TRANSACTION: Inicia a transação
-- * COMMIT: Confirma as alterações
-- * ROLLBACK: Desfaz as alterações em caso de erro

-- ================================================
-- 9) Transação de venda com vários produtos
-- ================================================
BEGIN TRANSACTION;

DO $$
DECLARE
  nova_nota_id INT;
BEGIN
  -- Inserir nota fiscal
  INSERT INTO notafiscal (codcliente, codvendedor, dataemissao)
  VALUES (2, 3, NOW())
  RETURNING codnotafiscal INTO nova_nota_id;

  -- Inserir itens da venda
  INSERT INTO itemvenda (codnotafiscal, codproduto, quantidade, precounitvenda)
  VALUES
    (nova_nota_id, 3, 5, (SELECT precovenda FROM produto WHERE codproduto = 3)),
    (nova_nota_id, 5, 3, (SELECT precovenda FROM produto WHERE codproduto = 5)),
    (nova_nota_id, 8, 2, (SELECT precovenda FROM produto WHERE codproduto = 8));

EXCEPTION
  WHEN OTHERS THEN
    RAISE NOTICE 'Ocorreu um erro na transação. Executando ROLLBACK.';
    ROLLBACK;
    RAISE;
END $$;

COMMIT;





