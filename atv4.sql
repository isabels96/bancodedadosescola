-- =====================================================================
-- 1. CRIAÇÃO DO BANCO DE DADOS E TABELAS
-- =====================================================================
CREATE DATABASE SISTEMA_VENDAS;
USE SISTEMA_VENDAS;

-- Tabela que armazena o cadastro dos produtos
CREATE TABLE PRODUTOS (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela que registra o histórico de compras/vendas diárias
CREATE TABLE VENDAS (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    quantidade_comprada INT NOT NULL,
    data_venda DATE NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES PRODUTOS(id_produto)
);

-- =====================================================================
-- 2. POPULANDO O BANCO COM DADOS DE TESTE
-- =====================================================================
INSERT INTO PRODUTOS (nome_produto, preco) VALUES 
('Mouse Pad', 25.00),
('Teclado Sem Fio', 120.00),
('Monitor 24 Polegadas', 850.00);

-- Inserindo vendas em datas diferentes para testar o filtro do relatório
INSERT INTO VENDAS (id_produto, quantidade_comprada, data_venda) VALUES 
(1, 5, '2026-05-15'),  -- 5 Mouse Pads no dia 15
(2, 2, '2026-05-15'),  -- 2 Teclados no dia 15
(1, 3, '2026-05-15'),  -- +3 Mouse Pads no dia 15 (Total do dia deve ser 8)
(3, 1, '2026-05-16'),  -- 1 Monitor no dia 16
(2, 4, '2026-05-16');  -- 4 Teclados no dia 16

-- =====================================================================
-- 3. CRIAÇÃO DA STORED PROCEDURE
-- =====================================================================
DELIMITER $$

CREATE PROCEDURE GerarRelatorioVendasDiarias(IN data_pesquisa DATE)
BEGIN
    -- O corpo da procedure executa um agrupamento (SUM) filtrando pela data recebida
    SELECT 
        P.nome_produto AS "Produto",
        SUM(V.quantidade_comprada) AS "Quantidade Total Comprada",
        data_pesquisa AS "Data do Relatório"
    FROM VENDAS V
    INNER JOIN PRODUTOS P ON V.id_produto = P.id_produto
    WHERE V.data_venda = data_pesquisa
    GROUP BY P.nome_produto;
END$$

DELIMITER ;

-- =====================================================================
-- 4. COMO VER FUNCIONAR (CHAMANDO A PROCEDURE)
-- =====================================================================

-- Para rodar o levantamento do dia 15 de Maio de 2026, use o comando CALL:
CALL GerarRelatorioVendasDiarias('2026-05-15');

-- Para rodar o levantamento do dia 16 de Maio de 2026, basta mudar o parâmetro:
CALL GerarRelatorioVendasDiarias('2026-05-16');