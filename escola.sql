-- 1. Criar o banco de dados chamado ESCOLA
CREATE DATABASE ESCOLA;

-- 2. Ativar o banco de dados para deixá-lo pronto para o uso
USE ESCOLA;

-- 3. Criar a tabela ALUNO com os atributos solicitados
CREATE TABLE ALUNO (
    id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    endereco VARCHAR(255),
    -- Definindo o ID como a Chave Primária
    PRIMARY KEY (id)
);