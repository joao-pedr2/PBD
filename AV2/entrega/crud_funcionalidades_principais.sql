/*
 * ------------------------------------------------------------------
 * PROJETO: LOCADORA FALLSCAR (JOÃO PEDRO)
 * ARQUIVO: crud_funcionalidades_principais.sql
 * DESCRIÇÃO: Scripts de manipulação de dados (CRUD) simulando
 * o fluxo de negócio real: Locação -> Consulta -> Devolução -> Cancelamento.
 * ------------------------------------------------------------------
 */

USE locadora_fallscar_db;

-- ==================================================================
-- 1. CONSULTAR FROTA DISPONÍVEL (O "Catálogo")
-- Objetivo: Mostrar apenas carros com status 'DISPONIVEL' e seus preços.
-- ==================================================================
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


-- ==================================================================
-- 2. REALIZAR UMA LOCAÇÃO (A "Venda")
-- Cenário: O Cliente ID 2 (Erasmo) quer alugar o Carro ID 2 (Jeep)
-- Regra: Criar contrato E mudar status do carro para ALUGADO.
-- ==================================================================

-- Passo A: Definir variáveis de entrada (Simulando o formulário do site)
SET @id_cliente_escolhido = 2;
SET @id_carro_escolhido = 2; 
SET @dias = 15;
SET @id_preco_aplicado = 2; -- ID da tabela de preço do SUV
SET @valor_fechado = 4000.00; -- Preço de 15 dias do SUV

-- Passo B: Inserir o Contrato (Status 4 = ATIVO)
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

-- Passo C: Atualizar o Carro (Status 2 = ALUGADO)
-- Isso garante que ninguém mais alugue esse carro
UPDATE CARRO 
SET id_status = 2 
WHERE id_carro = @id_carro_escolhido;

-- Validação visual
SELECT 'Locação Realizada com Sucesso' AS Mensagem;


-- ==================================================================
-- 3. DEVOLUÇÃO DO VEÍCULO (O "Check-in")
-- Cenário: O carro voltou. Precisamos fechar o contrato e liberar o carro.
-- ==================================================================

-- Variável: Qual contrato está sendo encerrado?
SET @id_contrato_encerrar = (SELECT MAX(id_contrato) FROM CONTRATO_LOCACAO WHERE id_carro = 2);

-- Passo A: Finalizar o Contrato (Mudar status para 5 = FINALIZADO)
UPDATE CONTRATO_LOCACAO
SET id_status = 5
WHERE id_contrato = @id_contrato_encerrar;

-- Passo B: Liberar o Carro (Mudar status para 1 = DISPONIVEL)
UPDATE CARRO
SET id_status = 1, id_loja_atual = 1 -- Carro volta para a loja
WHERE id_carro = 2;

-- Passo C: Registrar Pagamento
INSERT INTO TRANSACAO_PAGAMENTO (
    codigo_transacao, valor_pago, metodo_pagamento, id_status, id_contrato
) VALUES (
    UUID(), 4000.00, 'CARTAO_CREDITO', 7, @id_contrato_encerrar
    -- Obs: Assumindo que criamos um status 'PAGO' (ID 7) no domínio, se não houver, use o ID disponível.
);

SELECT 'Devolução Processada e Carro Liberado' AS Mensagem;


-- ==================================================================
-- 4. CANCELAMENTO DE RESERVA (Soft Delete)
-- Regra Enterprise: Nunca deletamos o registro físico (DELETE FROM).
-- Apenas mudamos o status para CANCELADO para manter histórico.
-- ==================================================================

SET @id_contrato_cancelar = 1; -- Supondo que seja o contrato 1

-- Passo A: Marcar contrato como CANCELADO (Status 6)
UPDATE CONTRATO_LOCACAO
SET id_status = 6
WHERE id_contrato = @id_contrato_cancelar;

-- Passo B: Se o carro estava preso nesse contrato, liberar ele imediatamente
UPDATE CARRO
SET id_status = 1 -- Disponível
WHERE id_carro = (SELECT id_carro FROM CONTRATO_LOCACAO WHERE id_contrato = @id_contrato_cancelar);

SELECT 'Contrato Cancelado e Histórico Mantido' AS Mensagem;
