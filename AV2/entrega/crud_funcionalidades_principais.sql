USE locadora_fallscar_db;

-- CONSULTAR FROTA DISPONÍVEL
SELECT 
    c.id_carro,
    c.modelo,
    cat.nome_categoria,
    l.nome_loja AS onde_esta,
    CONCAT('R$ ', tp.preco_7_dias) AS valor_pacote_semanal
FROM CARRO c
JOIN DOMINIO_STATUS ds ON c.id_status = ds.id_status
JOIN CATEGORIA cat ON c.id_categoria = cat.id_categoria
JOIN LOJA l ON c.id_loja_atual = l.id_loja
LEFT JOIN TABELA_PRECO tp ON cat.id_categoria = tp.id_categoria
WHERE ds.valor_status = 'DISPONIVEL';

-- REALIZAR LOCAÇÃO 
SET @id_cliente_escolhido = 2;
SET @id_carro_escolhido = 2; 
SET @dias = 15;
SET @id_preco_aplicado = 2; -- ID da tabela de preço do SUV
SET @valor_fechado = 4000.00; -- Preço de 15 dias do SUV

-- Inserir o Contrato (id_status 4 = ATIVO)
INSERT INTO CONTRATO_LOCACAO (
    codigo_contrato, data_retirada, data_prevista_devolucao, dias_contratados,
    valor_diaria_acordado, valor_total, canal_reserva,
    id_status, id_cliente, id_carro, id_loja_retirada, id_preco
) VALUES (
    CONCAT('WEB-', UUID_SHORT()), -- Gera código único
    NOW(), 
    DATE_ADD(NOW(), INTERVAL @dias DAY), 
    @dias,
    (@valor_fechado / @dias), -- Calcula diária média
    @valor_fechado, 
    'BALCAO',
    4, -- ID 4 é 'ATIVO' na tabela DOMINIO_STATUS
    @id_cliente_escolhido, 
    @id_carro_escolhido, 
    1, -- Loja Galeão
    @id_preco_aplicado
);

-- Atualizar o Carro (id_status 2 = ALUGADO)
UPDATE CARRO 
SET id_status = 2 
WHERE id_carro = @id_carro_escolhido;

-- Validação visual
SELECT 'Locação Realizada com Sucesso' AS Mensagem;

-- DEVOLUÇÃO DO VEÍCULO

SET @id_contrato_encerrar = (SELECT MAX(id_contrato) FROM CONTRATO_LOCACAO WHERE id_carro = 2);

-- Finalizar o Contrato (Mudar id_status para 5 = FINALIZADO)
UPDATE CONTRATO_LOCACAO
SET id_status = 5
WHERE id_contrato = @id_contrato_encerrar;

-- Passo B: Liberar o Carro (Mudar status para 1 = DISPONIVEL)
UPDATE CARRO
SET id_status = 1, id_loja_atual = 1 -- Carro volta para a loja
WHERE id_carro = 2;

-- Registrar Pagamento
INSERT INTO TRANSACAO_PAGAMENTO (
    codigo_transacao, valor_pago, metodo_pagamento, id_status, id_contrato
) VALUES (
    UUID(), 4000.00, 'CARTAO_CREDITO', 7, @id_contrato_encerrar
    -- Obs: Assumindo que criamos um status 'PAGO' (ID 7) no domínio, se não houver, use o ID disponível.
);

SELECT 'Devolução Processada e Carro Liberado' AS Mensagem;

-- CANCELAMENTO DE RESERVA
SET @id_contrato_cancelar = 1; -- Supondo que seja o contrato 1

-- contrato  CANCELADO (id_status = 6)
UPDATE CONTRATO_LOCACAO
SET id_status = 6
WHERE id_contrato = @id_contrato_cancelar;

-- liberar carro
UPDATE CARRO
SET id_status = 1 -- Disponível
WHERE id_carro = (SELECT id_carro FROM CONTRATO_LOCACAO WHERE id_contrato = @id_contrato_cancelar);

SELECT 'Contrato Cancelado e Histórico Mantido' AS Mensagem;

-- TESTANDO O DELETE
-- Professor, por mais que não seja muito adequado usar o DELETE com o banco de dados, implementei por ter sido solicitado pelo senhor.

-- Teste: registro errado só para ver como o delete funciona
INSERT INTO CARRO (modelo, placa, id_status, id_categoria, id_loja_atual)
VALUES ('Carro Teste Delete', 'DEL-9999', 1, 1, 1); 

SET @id_carro_para_excluir = (SELECT id_carro FROM CARRO WHERE placa = 'DEL-9999');

-- Visualizar antes de apagar
SELECT * FROM CARRO WHERE id_carro = @id_carro_para_excluir;

-- Exclusão 
DELETE FROM CARRO
WHERE id_carro = @id_carro_para_excluir;

-- Validação visual
SELECT 'Registro Excluído Definitivamente' AS Mensagem;
