-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geraÃ§Ã£o: 26/11/2025 Ã s 20:17
-- VersÃ£o do servidor: 10.4.32-MariaDB
-- VersÃ£o do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `falls_car_db`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `acessorio`
--

CREATE TABLE `acessorio` (
  `id_acessorio` int(11) NOT NULL,
  `nome_acessorio` varchar(100) NOT NULL,
  `preco_diaria` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `carro`
--

CREATE TABLE `carro` (
  `id_carro` int(11) NOT NULL,
  `fabricante` varchar(50) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `placa` varchar(10) NOT NULL,
  `chassi` varchar(30) NOT NULL,
  `nivel_combustivel` decimal(3,2) DEFAULT NULL,
  `id_status` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_loja_atual` int(11) NOT NULL,
  `url_imagem` varchar(500) DEFAULT 'https://cdn-icons-png.flaticon.com/512/3202/3202926.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `carro`
--

INSERT INTO `carro` (`id_carro`, `fabricante`, `modelo`, `placa`, `chassi`, `nivel_combustivel`, `id_status`, `id_categoria`, `id_loja_atual`, `url_imagem`) VALUES
(1001, 'Fiat', 'Mobi Like', 'MOB-2023', '9BW1001', 1.00, 10, 1, 1, NULL),
(1002, 'Fiat', 'Mobi Trekking', 'MOB-2024', '9BW1002', 1.00, 10, 1, 2, NULL),
(1003, 'Renault', 'Kwid Zen', 'KWI-1010', '9BW1003', 1.00, 10, 1, 1, NULL),
(1004, 'Renault', 'Kwid Outsider', 'KWI-2020', '9BW1004', 1.00, 10, 1, 3, NULL),
(1005, 'VW', 'Gol MPI', 'GOL-5555', '9BW1005', 0.80, 10, 1, 1, NULL),
(1006, 'VW', 'Polo Track', 'POL-1000', '9BW1006', 1.00, 10, 1, 2, NULL),
(1007, 'Hyundai', 'HB20 Sense', 'HBV-2020', '9BW1007', 1.00, 10, 1, 1, NULL),
(1008, 'Hyundai', 'HB20 Vision', 'HBV-2021', '9BW1008', 0.90, 10, 1, 2, NULL),
(1009, 'Chevrolet', 'Onix Joy', 'ONX-1000', '9BW1009', 1.00, 10, 1, 3, NULL),
(1010, 'Chevrolet', 'Onix Plus', 'ONX-2000', '9BW1010', 1.00, 10, 1, 1, NULL),
(1011, 'Fiat', 'Argo Drive', 'ARG-1111', '9BW1011', 1.00, 10, 1, 2, NULL),
(1012, 'Fiat', 'Cronos', 'CRO-2222', '9BW1012', 1.00, 10, 1, 1, NULL),
(1013, 'Peugeot', '208 Like', 'PEU-2080', '9BW1013', 1.00, 10, 1, 3, NULL),
(1014, 'Citroen', 'C3 Live', 'CIT-3000', '9BW1014', 1.00, 10, 1, 1, NULL),
(1015, 'Renault', 'Stepway', 'STP-4000', '9BW1015', 1.00, 10, 1, 2, NULL),
(2001, 'Toyota', 'Corolla XEi', 'COR-2023', '9BW2001', 1.00, 10, 2, 1, NULL),
(2002, 'Toyota', 'Corolla Altis', 'COR-2024', '9BW2002', 1.00, 10, 2, 2, NULL),
(2003, 'Honda', 'Civic Touring', 'CIV-1010', '9BW2003', 1.00, 10, 2, 1, NULL),
(2004, 'Honda', 'City Sedan', 'CTY-2020', '9BW2004', 1.00, 10, 2, 3, NULL),
(2005, 'Chevrolet', 'Cruze LTZ', 'CRZ-5555', '9BW2005', 0.80, 10, 2, 1, NULL),
(2006, 'Chevrolet', 'Cruze Premier', 'CRZ-6666', '9BW2006', 1.00, 10, 2, 2, NULL),
(2007, 'VW', 'Virtus Highline', 'VIR-1000', '9BW2007', 1.00, 10, 2, 1, NULL),
(2008, 'VW', 'Jetta GLI', 'JET-2000', '9BW2008', 1.00, 10, 2, 2, NULL),
(2009, 'Nissan', 'Sentra Exclusive', 'SEN-3000', '9BW2009', 1.00, 10, 2, 3, NULL),
(2010, 'Nissan', 'Versa', 'VER-4000', '9BW2010', 1.00, 10, 2, 1, NULL),
(2011, 'Kia', 'Cerato', 'CER-5000', '9BW2011', 1.00, 10, 2, 1, NULL),
(2012, 'Hyundai', 'HB20S', 'HBS-6000', '9BW2012', 1.00, 10, 2, 2, NULL),
(2013, 'Fiat', 'Fastback', 'FST-7000', '9BW2013', 1.00, 10, 2, 3, NULL),
(2014, 'Toyota', 'Yaris Sedan', 'YAR-8000', '9BW2014', 1.00, 10, 2, 1, NULL),
(2015, 'Honda', 'HR-V EXL', 'HRV-9000', '9BW2015', 1.00, 10, 2, 2, NULL),
(3001, 'Jeep', 'Compass Longitude', 'CMP-3001', '9BW3001', 1.00, 10, 3, 1, NULL),
(3002, 'Jeep', 'Renegade Sport', 'RNG-3002', '9BW3002', 1.00, 10, 3, 2, NULL),
(3003, 'Jeep', 'Commander', 'CMD-3003', '9BW3003', 1.00, 10, 3, 3, NULL),
(3004, 'VW', 'T-Cross Highline', 'TCR-3004', '9BW3004', 1.00, 10, 3, 1, NULL),
(3005, 'VW', 'Nivus', 'NIV-3005', '9BW3005', 1.00, 10, 3, 2, NULL),
(3006, 'VW', 'Taos', 'TAO-3006', '9BW3006', 1.00, 10, 3, 3, NULL),
(3007, 'Chevrolet', 'Tracker Premier', 'TRK-3007', '9BW3007', 1.00, 10, 3, 1, NULL),
(3008, 'Chevrolet', 'Equinox', 'EQN-3008', '9BW3008', 1.00, 10, 3, 2, NULL),
(3009, 'Toyota', 'Corolla Cross', 'CCR-3009', '9BW3009', 1.00, 10, 3, 1, NULL),
(3010, 'Toyota', 'SW4 Diamond', 'SW4-3010', '9BW3010', 1.00, 10, 3, 3, NULL),
(4001, 'BMW', '320i M Sport', 'BMW-4001', '9BW4001', 1.00, 10, 4, 1, NULL),
(4002, 'BMW', 'X1', 'BMW-4002', '9BW4002', 1.00, 10, 4, 2, NULL),
(4003, 'BMW', 'X5', 'BMW-4003', '9BW4003', 1.00, 10, 4, 3, NULL),
(4004, 'Mercedes', 'C180', 'MER-4004', '9BW4004', 1.00, 10, 4, 1, NULL),
(4005, 'Mercedes', 'GLA 200', 'MER-4005', '9BW4005', 1.00, 10, 4, 2, NULL),
(4006, 'Audi', 'A3 Sedan', 'AUD-4006', '9BW4006', 1.00, 10, 4, 1, NULL),
(4007, 'Audi', 'Q3', 'AUD-4007', '9BW4007', 1.00, 10, 4, 3, NULL),
(4008, 'Volvo', 'XC60', 'VOL-4008', '9BW4008', 1.00, 10, 4, 1, NULL),
(4009, 'Land Rover', 'Discovery', 'LDR-4009', '9BW4009', 1.00, 10, 4, 2, NULL),
(4010, 'Porsche', 'Macan', 'POR-4010', '9BW4010', 1.00, 10, 4, 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `nome_categoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `nome_categoria`) VALUES
(1, 'BASICO'),
(2, 'SUV'),
(3, 'LUXO'),
(4, 'LUXO');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cidade`
--

CREATE TABLE `cidade` (
  `id_cidade` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cidade`
--

INSERT INTO `cidade` (`id_cidade`, `nome`) VALUES
(1, 'SÃ£o Paulo'),
(2, 'Rio de Janeiro'),
(3, 'Curitiba');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `cnh` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nome`, `cpf`, `cnh`) VALUES
(1, 'Sr. Water Falls', '000.000.000-01', 'CNH-123456');

-- --------------------------------------------------------

--
-- Estrutura para tabela `contrato_locacao`
--

CREATE TABLE `contrato_locacao` (
  `id_contrato` int(11) NOT NULL,
  `codigo_contrato` varchar(20) NOT NULL,
  `data_retirada` date NOT NULL,
  `dias_contratados` int(11) NOT NULL,
  `canal_reserva` varchar(50) NOT NULL,
  `valor_diaria_acordado` decimal(10,2) NOT NULL,
  `valor_acessorios` decimal(10,2) NOT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  `id_status` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_carro` int(11) NOT NULL,
  `id_loja_retirada` int(11) NOT NULL,
  `id_motorista` int(11) DEFAULT NULL,
  `id_preco` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `contrato_locacao`
--

INSERT INTO `contrato_locacao` (`id_contrato`, `codigo_contrato`, `data_retirada`, `dias_contratados`, `canal_reserva`, `valor_diaria_acordado`, `valor_acessorios`, `valor_total`, `id_status`, `id_cliente`, `id_carro`, `id_loja_retirada`, `id_motorista`, `id_preco`) VALUES
(16616, 'CTR-16616', '2025-11-26', 15, 'Site', 1400.00, 0.00, 1600.00, 21, 1, 1013, 1, 15, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `dominio_status`
--

CREATE TABLE `dominio_status` (
  `id_status` int(11) NOT NULL,
  `tipo_entidade` varchar(50) NOT NULL,
  `valor_status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `dominio_status`
--

INSERT INTO `dominio_status` (`id_status`, `tipo_entidade`, `valor_status`) VALUES
(10, 'Carro', 'LIVRE'),
(11, 'Carro', 'ALUGADO'),
(12, 'Carro', 'MANUTENCAO'),
(20, 'Contrato', 'ATIVO'),
(21, 'Contrato', 'FINALIZADO'),
(22, 'Contrato', 'CANCELADO'),
(30, 'Pagamento', 'PAGO'),
(31, 'Pagamento', 'PENDENTE');

-- --------------------------------------------------------

--
-- Estrutura para tabela `locacao_acessorio`
--

CREATE TABLE `locacao_acessorio` (
  `id_loc_acessorio` int(11) NOT NULL,
  `id_contrato` int(11) NOT NULL,
  `id_acessorio` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_sistema`
--

CREATE TABLE `log_sistema` (
  `id_log` int(11) NOT NULL,
  `data_hora` datetime NOT NULL,
  `acao_detalhada` varchar(255) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `loja`
--

CREATE TABLE `loja` (
  `id_loja` int(11) NOT NULL,
  `nome_loja` varchar(100) NOT NULL,
  `id_cidade` int(11) NOT NULL,
  `id_tipo_loja` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `loja`
--

INSERT INTO `loja` (`id_loja`, `nome_loja`, `id_cidade`, `id_tipo_loja`) VALUES
(1, 'Loja Congonhas', 1, 1),
(2, 'Aeroporto GaleÃ£o (RJ)', 2, 1),
(3, 'Centro Rio (RJ)', 2, 2),
(4, 'Aeroporto Afonso Pena (PR)', 3, 1),
(5, 'Centro Curitiba (PR)', 3, 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `manutencao`
--

CREATE TABLE `manutencao` (
  `id_manutencao` int(11) NOT NULL,
  `data_inicio` datetime NOT NULL,
  `data_fim` datetime DEFAULT NULL,
  `custo` decimal(10,2) DEFAULT NULL,
  `id_carro` int(11) NOT NULL,
  `id_loja_responsavel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `motorista`
--

CREATE TABLE `motorista` (
  `id_motorista` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `cnh` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `motorista`
--

INSERT INTO `motorista` (`id_motorista`, `nome`, `cnh`) VALUES
(2, 'Carlos Oliveira (28 anos)', 'CNH-102030'),
(3, 'Fernanda Santos (34 anos)', 'CNH-405060'),
(4, 'Roberto Almeida (45 anos)', 'CNH-708090'),
(5, 'Juliana Lima (29 anos)', 'CNH-112233'),
(6, 'Marcelo Souza (52 anos)', 'CNH-445566'),
(7, 'PatrÃ­cia Rocha (31 anos)', 'CNH-778899'),
(8, 'Ricardo Mendes (39 anos)', 'CNH-001122'),
(9, 'Camila Ferreira (26 anos)', 'CNH-334455'),
(10, 'Lucas Pereira (30 anos)', 'CNH-667788'),
(11, 'Vanessa Costa (41 anos)', 'CNH-990011'),
(12, 'Bruno Carvalho (27 anos)', 'CNH-223344'),
(13, 'Aline Martins (35 anos)', 'CNH-556677'),
(14, 'Eduardo Silva (48 anos)', 'CNH-889900'),
(15, 'Beatriz Gomes (24 anos)', 'CNH-123123'),
(16, 'Gustavo Ribeiro (33 anos)', 'CNH-456456');

-- --------------------------------------------------------

--
-- Estrutura para tabela `nivel_acesso`
--

CREATE TABLE `nivel_acesso` (
  `id_nivel` int(11) NOT NULL,
  `nome_nivel` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `nivel_acesso`
--

INSERT INTO `nivel_acesso` (`id_nivel`, `nome_nivel`) VALUES
(1, 'ADMIN'),
(2, 'ATENDENTE');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tabela_preco`
--

CREATE TABLE `tabela_preco` (
  `id_preco` int(11) NOT NULL,
  `preco_7_dias` decimal(10,2) NOT NULL,
  `preco_15_dias` decimal(10,2) NOT NULL,
  `preco_30_dias` decimal(10,2) NOT NULL,
  `id_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tabela_preco`
--

INSERT INTO `tabela_preco` (`id_preco`, `preco_7_dias`, `preco_15_dias`, `preco_30_dias`, `id_categoria`) VALUES
(1, 700.00, 1400.00, 2500.00, 1),
(2, 950.00, 1800.00, 3500.00, 2),
(3, 1500.00, 2900.00, 5600.00, 3),
(4, 2500.00, 4800.00, 9000.00, 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_loja`
--

CREATE TABLE `tipo_loja` (
  `id_tipo_loja` int(11) NOT NULL,
  `nome_tipo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tipo_loja`
--

INSERT INTO `tipo_loja` (`id_tipo_loja`, `nome_tipo`) VALUES
(1, 'AEROPORTO'),
(2, 'CIDADE');

-- --------------------------------------------------------

--
-- Estrutura para tabela `transacao_pagamento`
--

CREATE TABLE `transacao_pagamento` (
  `id_transacao` int(11) NOT NULL,
  `codigo_transacao` varchar(100) DEFAULT NULL,
  `valor_pago` decimal(10,2) NOT NULL,
  `data_pagamento` datetime NOT NULL,
  `id_status` int(11) NOT NULL,
  `id_contrato` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `transacao_pagamento`
--

INSERT INTO `transacao_pagamento` (`id_transacao`, `codigo_transacao`, `valor_pago`, `data_pagamento`, `id_status`, `id_contrato`) VALUES
(1123, 'PGT-WEB', 1600.00, '2025-11-26 16:07:23', 30, 16616);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `login` varchar(50) NOT NULL,
  `id_loja` int(11) DEFAULT NULL,
  `id_nivel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Ãndices para tabelas despejadas
--

--
-- Ãndices de tabela `acessorio`
--
ALTER TABLE `acessorio`
  ADD PRIMARY KEY (`id_acessorio`);

--
-- Ãndices de tabela `carro`
--
ALTER TABLE `carro`
  ADD PRIMARY KEY (`id_carro`),
  ADD UNIQUE KEY `placa` (`placa`),
  ADD UNIQUE KEY `chassi` (`chassi`),
  ADD KEY `id_status` (`id_status`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_loja_atual` (`id_loja_atual`);

--
-- Ãndices de tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Ãndices de tabela `cidade`
--
ALTER TABLE `cidade`
  ADD PRIMARY KEY (`id_cidade`);

--
-- Ãndices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `cpf` (`cpf`);

--
-- Ãndices de tabela `contrato_locacao`
--
ALTER TABLE `contrato_locacao`
  ADD PRIMARY KEY (`id_contrato`),
  ADD UNIQUE KEY `codigo_contrato` (`codigo_contrato`),
  ADD KEY `id_status` (`id_status`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_carro` (`id_carro`),
  ADD KEY `id_loja_retirada` (`id_loja_retirada`),
  ADD KEY `id_motorista` (`id_motorista`),
  ADD KEY `id_preco` (`id_preco`);

--
-- Ãndices de tabela `dominio_status`
--
ALTER TABLE `dominio_status`
  ADD PRIMARY KEY (`id_status`);

--
-- Ãndices de tabela `locacao_acessorio`
--
ALTER TABLE `locacao_acessorio`
  ADD PRIMARY KEY (`id_loc_acessorio`),
  ADD KEY `id_contrato` (`id_contrato`),
  ADD KEY `id_acessorio` (`id_acessorio`);

--
-- Ãndices de tabela `log_sistema`
--
ALTER TABLE `log_sistema`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Ãndices de tabela `loja`
--
ALTER TABLE `loja`
  ADD PRIMARY KEY (`id_loja`),
  ADD KEY `id_cidade` (`id_cidade`),
  ADD KEY `id_tipo_loja` (`id_tipo_loja`);

--
-- Ãndices de tabela `manutencao`
--
ALTER TABLE `manutencao`
  ADD PRIMARY KEY (`id_manutencao`),
  ADD KEY `id_carro` (`id_carro`),
  ADD KEY `id_loja_responsavel` (`id_loja_responsavel`);

--
-- Ãndices de tabela `motorista`
--
ALTER TABLE `motorista`
  ADD PRIMARY KEY (`id_motorista`);

--
-- Ãndices de tabela `nivel_acesso`
--
ALTER TABLE `nivel_acesso`
  ADD PRIMARY KEY (`id_nivel`);

--
-- Ãndices de tabela `tabela_preco`
--
ALTER TABLE `tabela_preco`
  ADD PRIMARY KEY (`id_preco`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Ãndices de tabela `tipo_loja`
--
ALTER TABLE `tipo_loja`
  ADD PRIMARY KEY (`id_tipo_loja`);

--
-- Ãndices de tabela `transacao_pagamento`
--
ALTER TABLE `transacao_pagamento`
  ADD PRIMARY KEY (`id_transacao`),
  ADD KEY `id_status` (`id_status`),
  ADD KEY `id_contrato` (`id_contrato`);

--
-- Ãndices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `login` (`login`),
  ADD KEY `id_loja` (`id_loja`),
  ADD KEY `id_nivel` (`id_nivel`);

--
-- RestriÃ§Ãµes para tabelas despejadas
--

--
-- RestriÃ§Ãµes para tabelas `carro`
--
ALTER TABLE `carro`
  ADD CONSTRAINT `carro_ibfk_1` FOREIGN KEY (`id_status`) REFERENCES `dominio_status` (`id_status`),
  ADD CONSTRAINT `carro_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`),
  ADD CONSTRAINT `carro_ibfk_3` FOREIGN KEY (`id_loja_atual`) REFERENCES `loja` (`id_loja`);

--
-- RestriÃ§Ãµes para tabelas `contrato_locacao`
--
ALTER TABLE `contrato_locacao`
  ADD CONSTRAINT `contrato_locacao_ibfk_1` FOREIGN KEY (`id_status`) REFERENCES `dominio_status` (`id_status`),
  ADD CONSTRAINT `contrato_locacao_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `contrato_locacao_ibfk_3` FOREIGN KEY (`id_carro`) REFERENCES `carro` (`id_carro`),
  ADD CONSTRAINT `contrato_locacao_ibfk_4` FOREIGN KEY (`id_loja_retirada`) REFERENCES `loja` (`id_loja`),
  ADD CONSTRAINT `contrato_locacao_ibfk_5` FOREIGN KEY (`id_motorista`) REFERENCES `motorista` (`id_motorista`),
  ADD CONSTRAINT `contrato_locacao_ibfk_6` FOREIGN KEY (`id_preco`) REFERENCES `tabela_preco` (`id_preco`);

--
-- RestriÃ§Ãµes para tabelas `locacao_acessorio`
--
ALTER TABLE `locacao_acessorio`
  ADD CONSTRAINT `locacao_acessorio_ibfk_1` FOREIGN KEY (`id_contrato`) REFERENCES `contrato_locacao` (`id_contrato`),
  ADD CONSTRAINT `locacao_acessorio_ibfk_2` FOREIGN KEY (`id_acessorio`) REFERENCES `acessorio` (`id_acessorio`);

--
-- RestriÃ§Ãµes para tabelas `log_sistema`
--
ALTER TABLE `log_sistema`
  ADD CONSTRAINT `log_sistema_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- RestriÃ§Ãµes para tabelas `loja`
--
ALTER TABLE `loja`
  ADD CONSTRAINT `loja_ibfk_1` FOREIGN KEY (`id_cidade`) REFERENCES `cidade` (`id_cidade`),
  ADD CONSTRAINT `loja_ibfk_2` FOREIGN KEY (`id_tipo_loja`) REFERENCES `tipo_loja` (`id_tipo_loja`);

--
-- RestriÃ§Ãµes para tabelas `manutencao`
--
ALTER TABLE `manutencao`
  ADD CONSTRAINT `manutencao_ibfk_1` FOREIGN KEY (`id_carro`) REFERENCES `carro` (`id_carro`),
  ADD CONSTRAINT `manutencao_ibfk_2` FOREIGN KEY (`id_loja_responsavel`) REFERENCES `loja` (`id_loja`);

--
-- RestriÃ§Ãµes para tabelas `tabela_preco`
--
ALTER TABLE `tabela_preco`
  ADD CONSTRAINT `tabela_preco_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`);

--
-- RestriÃ§Ãµes para tabelas `transacao_pagamento`
--
ALTER TABLE `transacao_pagamento`
  ADD CONSTRAINT `transacao_pagamento_ibfk_1` FOREIGN KEY (`id_status`) REFERENCES `dominio_status` (`id_status`),
  ADD CONSTRAINT `transacao_pagamento_ibfk_2` FOREIGN KEY (`id_contrato`) REFERENCES `contrato_locacao` (`id_contrato`);

--
-- RestriÃ§Ãµes para tabelas `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_loja`) REFERENCES `loja` (`id_loja`),
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`id_nivel`) REFERENCES `nivel_acesso` (`id_nivel`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
