-- Status Carros
INSERT INTO DOMINIO_STATUS (tipo_entidade, valor_status) VALUES 
('CARRO', 'DISPONIVEL'),    -- ID 1
('CARRO', 'ALUGADO'),       -- ID 2
('CARRO', 'EM_MANUTENCAO'); -- ID 3

-- Status Contratos
INSERT INTO DOMINIO_STATUS (tipo_entidade, valor_status) VALUES 
('CONTRATO', 'ATIVO'),      -- ID 4
('CONTRATO', 'FINALIZADO'), -- ID 5
('CONTRATO', 'CANCELADO');  -- ID 6

-- Tipos de Loja e Níveis de Acesso
INSERT INTO TIPO_LOJA (nome_tipo) VALUES ('AEROPORTO'), ('CENTRO_CIDADE');
INSERT INTO NIVEL_ACESSO (nome_nivel) VALUES ('ADMINISTRADOR'), ('ATENDENTE');
INSERT INTO CIDADE (nome, uf) VALUES ('Rio de Janeiro', 'RJ'), ('São Paulo', 'SP');

-- Lojas
INSERT INTO LOJA (nome_loja, endereco, id_cidade, id_tipo_loja) VALUES 
('Falls Car Galeão', 'Terminal 2 - Desembarque', 1, 1), -- Aeroporto RJ
('Falls Car Paulista', 'Av Paulista 1000', 2, 2);       -- Centro SP

-- Usuários 
INSERT INTO USUARIO (nome, login, senha_hash, id_loja, id_nivel) VALUES 
('João Admin', 'admin', 'hash_seguro_123', 1, 1),
('Maria Atendente', 'maria.silva', 'hash_vendas_456', 1, 2);

-- Clientes
INSERT INTO CLIENTE (nome, cpf, cnh, email) VALUES 
('Roberto Carlos', '123.456.789-00', '1122334455', 'rc@email.com'),
('Erasmo Carlos', '987.654.321-00', '9988776655', 'erasmo@email.com');

-- Motoristas
INSERT INTO MOTORISTA (nome, cnh, status_disponibilidade) VALUES 
('Motorista Particular 01', 'CNH_PRO_01', TRUE);

-- Categorias
INSERT INTO CATEGORIA (nome_categoria) VALUES ('ECONOMICO'), ('SUV DE LUXO');

-- Tabela de Preços
INSERT INTO TABELA_PRECO (id_categoria, preco_7_dias, preco_15_dias, preco_30_dias, vigencia_inicio) VALUES 
(1, 700.00, 1400.00, 2500.00, '2024-01-01'),  -- Econômico (aprox 100/dia)
(2, 2100.00, 4000.00, 7500.00, '2024-01-01'); -- SUV (aprox 300/dia)

-- Carros
-- id_status 1 = DISPONIVEL
INSERT INTO CARRO (placa, chassi, modelo, ano_fabricacao, id_status, id_categoria, id_loja_atual) VALUES 
('ABC-1111', 'CHASSI_001', 'Fiat Mobi', 2023, 1, 1, 1),     -- Mobi no Galeão
('XYZ-9999', 'CHASSI_002', 'Jeep Commander', 2024, 1, 2, 1); -- Jeep no Galeão

-- Acessórios
INSERT INTO ACESSORIO (nome_acessorio, preco_diaria) VALUES 
('GPS', 15.00), ('Cadeira de Bebê', 20.00);

-- SIMULAÇÃO DE OPERAÇÃO

-- contrato ATIVO (id_status = 4)
INSERT INTO CONTRATO_LOCACAO (
    codigo_contrato, data_retirada, data_prevista_devolucao, dias_contratados,
    valor_diaria_acordado, valor_total, canal_reserva,
    id_status, id_cliente, id_carro, id_loja_retirada, id_preco
) VALUES (
    'CONTRATO_2025_001', NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 7,
    100.00, 700.00, 'WEB',
    4, 1, 1, 1, 1
);

-- status do carro para alugado (id_status = 2)
UPDATE CARRO SET id_status = 2 WHERE id_carro = 1;
