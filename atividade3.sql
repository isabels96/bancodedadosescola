-- =====================================================================
-- 1. CRIAÇÃO DO BANCO DE DADOS
-- =====================================================================
CREATE DATABASE CONTROLE_ESTOQUE;
USE CONTROLE_ESTOQUE;

-- =====================================================================
-- 2. CRIAÇÃO DAS TABELAS E ATRIBUTOS
-- =====================================================================

-- Tabela que armazena os produtos e a quantidade atual em estoque
CREATE TABLE PRODUTOS (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    quantidade_estoque INT NOT NULL
);

-- Tabela que registra as vendas realizadas
CREATE TABLE HISTORICO_VENDAS (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    quantidade_vendida INT NOT NULL,
    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_produto) REFERENCES PRODUTOS(id_produto)
);

-- =====================================================================
-- 3. INSERÇÃO DE DADOS INICIAIS (PRODUTOS)
-- =====================================================================
INSERT INTO PRODUTOS (nome_produto, quantidade_estoque) VALUES 
('Notebook Gamer', 10),
('Mouse Sem Fio', 50),
('Teclado Mecânico', 25);

-- Vamos consultar o estoque inicial para checar depois
SELECT * FROM PRODUTOS;


-- =====================================================================
-- 4. CRIAÇÃO DO TRIGGER (GATILHO)
-- =====================================================================
-- Mudamos o delimitador para que o banco não confunda o ";" do corpo do trigger com o fim do comando
DELIMITER $$

CREATE TRIGGER tgr_atualiza_estoque_venda
AFTER INSERT ON HISTORICO_VENDAS
FOR EACH ROW
BEGIN
    -- Atualiza a tabela PRODUTOS subtraindo a quantidade que acabou de ser vendida
    UPDATE PRODUTOS 
    SET quantidade_estoque = quantidade_estoque - NEW.quantidade_vendida
    WHERE id_produto = NEW.id_produto;
END$$

DELIMITER ;


-- =====================================================================
-- 5. TESTANDO O TRIGGER NA PRÁTICA
-- =====================================================================

-- O Notebook Gamer (id_produto = 1) tem 10 unidades no estoque.
-- Vamos simular a inserção (INSERT) de uma venda de 3 Notebooks:
INSERT INTO HISTORICO_VENDAS (id_produto, quantidade_vendida) VALUES (1, 3);


-- =====================================================================
-- 6. VERIFICAÇÃO DO RESULTADO
-- =====================================================================
-- Ao rodar o SELECT abaixo, você verá que o estoque do Notebook mudou de 10 para 7 automaticamente!
SELECT * FROM PRODUTOS;

-- Conferindo o registro na tabela de vendas
SELECT * FROM HISTORICO_VENDAS;