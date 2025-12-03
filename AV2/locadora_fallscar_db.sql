/*
 * ------------------------------------------------------------------
 * PROJETO: SISTEMA DE LOCADORA DE VEÍCULOS (BACKEND DB)
 * DESCRICAO: Script para criação da estrutura do banco de dados MySQL.
 * ALUNO: João Pedro Silva de Jesus 
 * ------------------------------------------------------------------
 */

CREATE DATABASE IF NOT EXISTS locadora_fallscar_db;
USE locadora_fallscar_db;

-- ==================================================================
-- GRUPO 1: DOMÍNIOS E CONFIGURAÇÕES GERAIS
-- Tabelas auxiliares para padronização de tipos e status
-- ==================================================================

-- Centraliza todos os status do sistema (Carro, Contrato, Pagamento)
CREATE TABLE DOMINIO_STATUS (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    tipo_entidade VARCHAR(50) NOT NULL COMMENT 'Ex: CARRO, CONTRATO, PAGAMENTO',
    valor_status VARCHAR(50) NOT NULL COMMENT 'Ex: DISPONIVEL, EM_MANUTENCAO, PAGO'
);

CREATE TABLE TIPO_LOJA (
    id_tipo_loja INT AUTO_INCREMENT PRIMARY KEY,
    nome_tipo VARCHAR(50) NOT NULL COMMENT 'Ex: AEROPORTO, CIDADE, QUIOSQUE'
);

CREATE TABLE NIVEL_ACESSO (
    id_nivel INT AUTO_INCREMENT PRIMARY KEY,
    nome_nivel VARCHAR(50) NOT NULL COMMENT 'Ex: ADMIN, BALCONISTA, GERENTE'
);

CREATE TABLE CIDADE (
    id_cidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL DEFAULT 'RJ'
);

-- ==================================================================
-- GRUPO 2: ESTRUTURA ORGANIZACIONAL E PESSOAS
-- ==================================================================

CREATE TABLE LOJA (
    id_loja INT AUTO_INCREMENT PRIMARY KEY,
    nome_loja VARCHAR(100) NOT NULL,
    endereco VARCHAR(200),
    id_cidade INT NOT NULL,
    id_tipo_loja INT NOT NULL,
    FOREIGN KEY (id_cidade) REFERENCES CIDADE(id_cidade),
    FOREIGN KEY (id_tipo_loja) REFERENCES TIPO_LOJA(id_tipo_loja)
);

CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    login VARCHAR(50) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    id_loja INT NOT NULL,
    id_nivel INT NOT NULL,
    FOREIGN KEY (id_loja) REFERENCES LOJA(id_loja),
    FOREIGN KEY (id_nivel) REFERENCES NIVEL_ACESSO(id_nivel)
);

CREATE TABLE CLIENTE (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    cnh VARCHAR(20) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE MOTORISTA (
    id_motorista INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnh VARCHAR(20) NOT NULL UNIQUE,
    status_disponibilidade BOOLEAN DEFAULT TRUE COMMENT 'Indica se está livre para viagem'
);

-- ==================================================================
-- GRUPO 3: FROTA E ATIVOS
-- Regras de precificação e cadastro de veículos
-- ==================================================================

CREATE TABLE CATEGORIA (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL COMMENT 'Ex: SUV, HATCH, SEDAN LUXO'
);

-- Tabela de preços baseada em pacotes de dias (Regra de Negócio Específica)
CREATE TABLE TABELA_PRECO (
    id_preco INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    preco_7_dias DECIMAL(10,2) NOT NULL,
    preco_15_dias DECIMAL(10,2) NOT NULL,
    preco_30_dias DECIMAL(10,2) NOT NULL,
    vigencia_inicio DATE,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);

CREATE TABLE CARRO (
    id_carro INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL UNIQUE,
    chassi VARCHAR(50) NOT NULL UNIQUE,
    modelo VARCHAR(50) NOT NULL,
    ano_fabricacao INT NOT NULL,
    nivel_combustivel DECIMAL(3,2) DEFAULT 1.00 COMMENT 'Escala 0.0 a 1.0',
    id_status INT NOT NULL,
    id_categoria INT NOT NULL,
    id_loja_atual INT NOT NULL,
    FOREIGN KEY (id_status) REFERENCES DOMINIO_STATUS(id_status),
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria),
    FOREIGN KEY (id_loja_atual) REFERENCES LOJA(id_loja)
);

CREATE TABLE ACESSORIO (
    id_acessorio INT AUTO_INCREMENT PRIMARY KEY,
    nome_acessorio VARCHAR(100) NOT NULL COMMENT 'GPS, CADEIRINHA, SEGURO_EXTRA',
    preco_diaria DECIMAL(10,2) NOT NULL
);

-- ==================================================================
-- GRUPO 4: CORE DO NEGÓCIO - TRANSAÇÕES E AUDITORIA
-- ==================================================================

CREATE TABLE CONTRATO_LOCACAO (
    id_contrato INT AUTO_INCREMENT PRIMARY KEY,
    codigo_contrato VARCHAR(20) NOT NULL UNIQUE,
    data_retirada DATETIME NOT NULL,
    data_prevista_devolucao DATETIME NOT NULL,
    dias_contratados INT NOT NULL COMMENT 'Define qual faixa de preço será usada',
    
    -- Valores financeiros congelados no momento do contrato
    valor_diaria_acordado DECIMAL(10,2) NOT NULL,
    valor_acessorios DECIMAL(10,2) DEFAULT 0.00,
    valor_total DECIMAL(10,2) NOT NULL,
    
    canal_reserva VARCHAR(20) COMMENT 'APP, WEB, BALCAO',
    
    -- Relacionamentos
    id_status INT NOT NULL,
    id_cliente INT NOT NULL,
    id_carro INT NOT NULL,
    id_loja_retirada INT NOT NULL,
    id_motorista INT, -- Nullable: Motorista é opcional
    id_preco INT NOT NULL, -- Referência à tabela de preço usada no cálculo
    
    FOREIGN KEY (id_status) REFERENCES DOMINIO_STATUS(id_status),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_carro) REFERENCES CARRO(id_carro),
    FOREIGN KEY (id_loja_retirada) REFERENCES LOJA(id_loja),
    FOREIGN KEY (id_motorista) REFERENCES MOTORISTA(id_motorista),
    FOREIGN KEY (id_preco) REFERENCES TABELA_PRECO(id_preco)
);

-- Tabela Associativa N:M para vincular múltiplos acessórios ao contrato
CREATE TABLE LOCACAO_ACESSORIO (
    id_loc_acessorio INT AUTO_INCREMENT PRIMARY KEY,
    id_contrato INT NOT NULL,
    id_acessorio INT NOT NULL,
    quantidade INT DEFAULT 1,
    FOREIGN KEY (id_contrato) REFERENCES CONTRATO_LOCACAO(id_contrato),
    FOREIGN KEY (id_acessorio) REFERENCES ACESSORIO(id_acessorio)
);

CREATE TABLE TRANSACAO_PAGAMENTO (
    id_transacao INT AUTO_INCREMENT PRIMARY KEY,
    codigo_transacao VARCHAR(50),
    valor_pago DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
    metodo_pagamento VARCHAR(30) COMMENT 'CREDITO, DEBITO, PIX',
    id_status INT NOT NULL,
    id_contrato INT NOT NULL,
    FOREIGN KEY (id_status) REFERENCES DOMINIO_STATUS(id_status),
    FOREIGN KEY (id_contrato) REFERENCES CONTRATO_LOCACAO(id_contrato)
);

CREATE TABLE MANUTENCAO (
    id_manutencao INT AUTO_INCREMENT PRIMARY KEY,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME,
    custo DECIMAL(10,2),
    descricao_servico TEXT,
    id_carro INT NOT NULL,
    id_loja_responsavel INT NOT NULL,
    FOREIGN KEY (id_carro) REFERENCES CARRO(id_carro),
    FOREIGN KEY (id_loja_responsavel) REFERENCES LOJA(id_loja)
);

-- Auditoria de ações críticas no sistema
CREATE TABLE LOG_SISTEMA (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    acao_detalhada TEXT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);
