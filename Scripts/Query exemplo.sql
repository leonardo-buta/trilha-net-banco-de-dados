SELECT * FROM Produtos

SELECT COUNT(*) QuantidadeProdutos FROM Produtos

SELECT COUNT(*) QuantidadeProdutosTamanhoM FROM Produtos WHERE Tamanho = 'M'

SELECT SUM(Preco) PrecoTotal FROM Produtos

SELECT MAX(Preco) ProdutoMaisCaro FROM Produtos

SELECT MAX(Preco) ProdutoMaisCaroTamanhoM FROM Produtos WHERE Tamanho = 'M'

SELECT MIN(Preco) ProdutoMaisBarato FROM Produtos

SELECT MIN(Preco) ProdutoMaisBaratoTamanhoM FROM Produtos WHERE Tamanho = 'M'

SELECT AVG(Preco) FROM Produtos


SELECT 
	Nome + ', Cor: ' + Cor + ' - ' + Genero NomeProdutoCompleto,
	UPPER(Nome) Nome,
	LOWER(Cor) Cor
FROM Produtos

SELECT * FROM Produtos

ALTER TABLE Produtos
ADD DataCadastro DATETIME2

ALTER TABLE Produtos
DROP COLUMN DataCadastro

UPDATE Produtos SET DataCadastro = GETDATE()



SELECT 
	Nome + ', Cor: ' + Cor + ' - ' + Genero NomeProdutoCompleto,
	UPPER(Nome) Nome,
	LOWER(Cor) Cor
FROM Produtos


SELECT 
	Nome + ', Cor: ' + Cor + ' - ' + Genero NomeProdutoCompleto,
	UPPER(Nome) Nome,
	LOWER(Cor) Cor,
	FORMAT(DataCadastro, 'dd/MM/yyyy HH:mm') Data
FROM Produtos

SELECT * FROM Clientes

CREATE TABLE Enderecos
(
	Id INT IDENTITY(1, 1) PRIMARY KEY,
	IdCliente INT,
	Rua VARCHAR(255),
	Bairro VARCHAR(255),
	Cidade VARCHAR(255),
	Estado CHAR(2),

	CONSTRAINT FK_Cliente_Enderecos FOREIGN KEY(IdCliente)
	REFERENCES Clientes(Id)
)

SELECT
	Tamanho,
	COUNT(*) Quantidade
FROM Produtos
WHERE Tamanho <> ''
GROUP BY Tamanho
ORDER BY Quantidade DESC


SELECT * FROM CLIENTES
SELECT * FROM ENDERECOS

INSERT INTO Enderecos VALUES (4, 'Rua Teste', 'Bairro teste', 'Cidade teste', 'SP')

CREATE TABLE Enderecos (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	IdCliente int NULL,
	Rua varchar(255) NULL,
	Bairro varchar(255) NULL,
	Cidade varchar(255) NULL,
	Estado char(2) NULL,

	CONSTRAINT FK_Enderecos_Clientes FOREIGN KEY(IdCliente)
	REFERENCES Clientes(Id)
)

select * from Clientes where Id = 4
select * from Enderecos where IdCliente = 4


SELECT
	C.Nome,
	C.Sobrenome,
	C.Email,
	E.Rua,
	E.Bairro,
	E.Cidade,
	E.Estado
FROM
	Clientes C
INNER JOIN Enderecos E ON C.Id = E.IdCliente
WHERE C.Id = 4


SELECT * FROM Produtos

INSERT INTO Produtos (Nome, Preco, Tamanho, Genero, DataCadastro)
VALUES ('Mountain Bike Socks, M', 10, 'G', 'M', GETDATE())

ALTER TABLE Produtos
ADD UNIQUE(Nome)

SELECT * FROM Produtos

ALTER TABLE Produtos
ADD CONSTRAINT CHK_ColunaGenero CHECK(Genero = 'U' OR Genero = 'M' OR Genero = 'F')

INSERT INTO Produtos (Nome, Preco, Tamanho, Genero, DataCadastro)
VALUES ('Mountain Bike Socks2, M', 10, 'G', 'U', GETDATE())

SELECT * FROM Produtos


INSERT INTO Produtos (Nome, Preco, Tamanho, Genero)
VALUES ('Mountain Bike Socks 3, M', 10, 'G', 'U')

ALTER TABLE Produtos
ADD DEFAULT GETDATE() FOR DataCadastro

SELECT * FROM Produtos


INSERT INTO Produtos (Nome, Preco, Tamanho, Genero)
VALUES ('Mountain Bike Socks 3, M', 10, 'G', 'U')


ALTER TABLE Produtos
DROP CONSTRAINT UQ__Produtos__7D8FE3B2D9894E32

SELECT * FROM Produtos

INSERT INTO Produtos (Nome, Cor, Preco, Tamanho, Genero)
VALUES ('Mountain Bike Socks 4, M', 'Colorido', 10, 'G', 'U')

EXEC InserirNovoProduto
@Nome = 'NOVO PRODUTO PROCEDURE',
@Cor = 'COLORIDO',
@Preco = 50,
@Tamanho = 'G',
@Genero = 'U'


CREATE PROCEDURE InserirNovoProduto
@Nome varchar(255),
@Cor varchar(50),
@Preco decimal,
@Tamanho varchar(5),
@Genero char(1)

AS

INSERT INTO Produtos (Nome, Cor, Preco, Tamanho, Genero)
VALUES (@Nome, @Cor, @Preco, @Tamanho, @Genero)

SELECT * FROM Produtos WHERE Tamanho = 'M'

EXEC ObterProdutosPorTamanho 'P'
EXEC ObterTodosProdutos


CREATE PROCEDURE ObterTodosProdutos
AS
SELECT * FROM Produtos



CREATE PROCEDURE ObterProdutosPorTamanho
@TamanhoProduto VARCHAR(5)

AS

SELECT * FROM Produtos WHERE Tamanho = @TamanhoProduto

SELECT
	Nome,
	Preco,
	FORMAT(Preco - Preco / 100 * 10, 'N2') PrecoComDesconto
FROM Produtos WHERE Tamanho = 'M'

SELECT
	Nome,
	Preco,
	dbo.CalcularDesconto(Preco, 50) PrecoComDesconto
FROM Produtos WHERE Tamanho = 'M'



CREATE FUNCTION CalcularDesconto(@Preco DECIMAL(13, 2), @Porcentagem INT)
RETURNS DECIMAL(13, 2)

BEGIN
	RETURN @Preco - @Preco / 100 * @Porcentagem
END
