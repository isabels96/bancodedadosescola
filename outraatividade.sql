-- =====================================================================
-- 1. CRIAÇÃO DA BASE DE DADOS
-- =====================================================================
CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;

-- =====================================================================
-- 2. CRIAÇÃO DAS TABELAS E ATRIBUTOS (COM CHAVES ESTRANGEIRAS)
-- =====================================================================

-- Criando a tabela CLIENTE
CREATE TABLE CLIENTE (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (id_cliente)
);

-- Criando a tabela PEDIDO (Relacionada com CLIENTE via Chave Estrangeira)
CREATE TABLE PEDIDO (
    id_pedido INT NOT NULL AUTO_INCREMENT,
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    id_cliente INT NOT NULL,
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

-- Criando a tabela ITEM_PEDIDO (Relacionada com PEDIDO)
CREATE TABLE ITEM_PEDIDO (
    id_item INT NOT NULL AUTO_INCREMENT,
    produto VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    id_pedido INT NOT NULL,
    PRIMARY KEY (id_item),
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido)
);

-- =====================================================================
-- 3. INSERÇÃO DE DADOS (POPULANDO O BANCO)
-- =====================================================================

-- Inserindo Clientes
INSERT INTO CLIENTE (nome, email) VALUES 
('Ana Silva', 'ana.silva@email.com'),
('Bruno Costa', 'bruno.costa@email.com'),
('Carlos Souza', 'carlos.souza@email.com');

-- Inserindo Pedidos
INSERT INTO PEDIDO (data_pedido, valor_total, id_cliente) VALUES 
('2026-05-10', 150.00, 1), -- Pedido da Ana
('2026-05-12', 350.50, 1), -- Outro pedido da Ana
('2026-05-15', 89.90, 2);   -- Pedido do Bruno
-- Nota: Carlos Souza não fez nenhum pedido ainda.

-- Inserindo Itens dos Pedidos
INSERT INTO ITEM_PEDIDO (produto, quantidade, preco_unitario, id_pedido) VALUES 
('Livro de SQL', 1, 50.00, 1),
('Curso de Banco de Dados', 1, 100.00, 1),
('Teclado Mecânico', 1, 350.50, 2),
('Mouse Gamer', 1, 89.90, 3);

-- =====================================================================
-- 4. CONSULTAS UTILIZANDO COMANDOS JOINS
-- =====================================================================

-- CONSULTA 1: INNER JOIN
-- Retorna apenas os clientes que possuem pedidos cadastrados.
SELECT 
    C.nome AS Nome_Cliente, 
    P.id_pedido AS Numero_Pedido, 
    P.data_pedido AS Data, 
    P.valor_total AS Total
FROM CLIENTE C
INNER JOIN PEDIDO P ON C.id_cliente = P.id_cliente;


-- CONSULTA 2: LEFT JOIN
-- Retorna TODOS os clientes, mesmo aqueles que nunca fizeram um pedido (como o Carlos).
SELECT 
    C.nome AS Nome_Cliente, 
    P.id_pedido AS Numero_Pedido, 
    P.valor_total AS Total
FROM CLIENTE C
LEFT JOIN PEDIDO P ON C.id_cliente = P.id_cliente;


-- CONSULTA 3: JOIN MÚLTIPLO (CLIENTE + PEDIDO + ITEM_PEDIDO)
-- Junta as três tabelas para listar o cliente e quais produtos exatos ele comprou.
SELECT 
    C.nome AS Nome_Cliente,
    P.id_pedido AS Numero_Pedido,
    I.produto AS Produto_Comprado,
    I.quantidade AS Qtd
FROM CLIENTE C
INNER JOIN PEDIDO P ON C.id_cliente = P.id_cliente
INNER JOIN ITEM_PEDIDO I ON P.id_pedido = I.id_pedido;