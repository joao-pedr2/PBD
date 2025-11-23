-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 22/11/2025 às 21:55
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

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



CREATE TABLE `acessorio` (
  `id_acessorio` int(11) NOT NULL,
  `nome_acessorio` varchar(100) NOT NULL,
  `preco_diaria` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `carro` (
  `id_carro` int(11) NOT NULL,
  `placa` varchar(10) NOT NULL,
  `chassi` varchar(30) NOT NULL,
  `nivel_combustivel` decimal(3,2) DEFAULT NULL,
  `id_status` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_loja_atual` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `carro` (`id_carro`, `placa`, `chassi`, `nivel_combustivel`, `id_status`, `id_categoria`, `id_loja_atual`) VALUES
(100, 'ABC-1234', '9BWZZZ', 1.00, 10, 1, 1);


CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `nome_categoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `categoria` (`id_categoria`, `nome_categoria`) VALUES
(1, 'BASICO'),
(2, 'SUV'),
(3, 'LUXO');


CREATE TABLE `cidade` (
  `id_cidade` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `cidade` (`id_cidade`, `nome`) VALUES
(1, 'São Paulo');


CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `cnh` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


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


CREATE TABLE `dominio_status` (
  `id_status` int(11) NOT NULL,
  `tipo_entidade` varchar(50) NOT NULL,
  `valor_status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `dominio_status` (`id_status`, `tipo_entidade`, `valor_status`) VALUES
(10, 'Carro', 'LIVRE'),
(11, 'Carro', 'ALUGADO'),
(12, 'Carro', 'MANUTENCAO'),
(20, 'Contrato', 'ATIVO'),
(21, 'Contrato', 'FINALIZADO'),
(22, 'Contrato', 'CANCELADO'),
(30, 'Pagamento', 'PAGO'),
(31, 'Pagamento', 'PENDENTE');


CREATE TABLE `locacao_acessorio` (
  `id_loc_acessorio` int(11) NOT NULL,
  `id_contrato` int(11) NOT NULL,
  `id_acessorio` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `log_sistema` (
  `id_log` int(11) NOT NULL,
  `data_hora` datetime NOT NULL,
  `acao_detalhada` varchar(255) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `loja` (
  `id_loja` int(11) NOT NULL,
  `nome_loja` varchar(100) NOT NULL,
  `id_cidade` int(11) NOT NULL,
  `id_tipo_loja` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `loja` (`id_loja`, `nome_loja`, `id_cidade`, `id_tipo_loja`) VALUES
(1, 'Loja Congonhas', 1, 1);


CREATE TABLE `manutencao` (
  `id_manutencao` int(11) NOT NULL,
  `data_inicio` datetime NOT NULL,
  `data_fim` datetime DEFAULT NULL,
  `custo` decimal(10,2) DEFAULT NULL,
  `id_carro` int(11) NOT NULL,
  `id_loja_responsavel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `motorista` (
  `id_motorista` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `cnh` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE `nivel_acesso` (
  `id_nivel` int(11) NOT NULL,
  `nome_nivel` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `nivel_acesso` (`id_nivel`, `nome_nivel`) VALUES
(1, 'ADMIN'),
(2, 'ATENDENTE');


CREATE TABLE `tabela_preco` (
  `id_preco` int(11) NOT NULL,
  `preco_7_dias` decimal(10,2) NOT NULL,
  `preco_15_dias` decimal(10,2) NOT NULL,
  `preco_30_dias` decimal(10,2) NOT NULL,
  `id_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `tabela_preco` (`id_preco`, `preco_7_dias`, `preco_15_dias`, `preco_30_dias`, `id_categoria`) VALUES
(1, 700.00, 1400.00, 2500.00, 1);

CREATE TABLE `tipo_loja` (
  `id_tipo_loja` int(11) NOT NULL,
  `nome_tipo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `tipo_loja` (`id_tipo_loja`, `nome_tipo`) VALUES
(1, 'AEROPORTO'),
(2, 'CIDADE');


CREATE TABLE `transacao_pagamento` (
  `id_transacao` int(11) NOT NULL,
  `codigo_transacao` varchar(100) DEFAULT NULL,
  `valor_pago` decimal(10,2) NOT NULL,
  `data_pagamento` datetime NOT NULL,
  `id_status` int(11) NOT NULL,
  `id_contrato` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `login` varchar(50) NOT NULL,
  `id_loja` int(11) DEFAULT NULL,
  `id_nivel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `acessorio`
  ADD PRIMARY KEY (`id_acessorio`);

ALTER TABLE `carro`
  ADD PRIMARY KEY (`id_carro`),
  ADD UNIQUE KEY `placa` (`placa`),
  ADD UNIQUE KEY `chassi` (`chassi`),
  ADD KEY `id_status` (`id_status`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_loja_atual` (`id_loja_atual`);


ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);


ALTER TABLE `cidade`
  ADD PRIMARY KEY (`id_cidade`);


ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `cpf` (`cpf`);


ALTER TABLE `contrato_locacao`
  ADD PRIMARY KEY (`id_contrato`),
  ADD UNIQUE KEY `codigo_contrato` (`codigo_contrato`),
  ADD KEY `id_status` (`id_status`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_carro` (`id_carro`),
  ADD KEY `id_loja_retirada` (`id_loja_retirada`),
  ADD KEY `id_motorista` (`id_motorista`),
  ADD KEY `id_preco` (`id_preco`);


ALTER TABLE `dominio_status`
  ADD PRIMARY KEY (`id_status`);


ALTER TABLE `locacao_acessorio`
  ADD PRIMARY KEY (`id_loc_acessorio`),
  ADD KEY `id_contrato` (`id_contrato`),
  ADD KEY `id_acessorio` (`id_acessorio`);


ALTER TABLE `log_sistema`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_usuario` (`id_usuario`);


ALTER TABLE `loja`
  ADD PRIMARY KEY (`id_loja`),
  ADD KEY `id_cidade` (`id_cidade`),
  ADD KEY `id_tipo_loja` (`id_tipo_loja`);


ALTER TABLE `manutencao`
  ADD PRIMARY KEY (`id_manutencao`),
  ADD KEY `id_carro` (`id_carro`),
  ADD KEY `id_loja_responsavel` (`id_loja_responsavel`);


ALTER TABLE `motorista`
  ADD PRIMARY KEY (`id_motorista`);


ALTER TABLE `nivel_acesso`
  ADD PRIMARY KEY (`id_nivel`);


ALTER TABLE `tabela_preco`
  ADD PRIMARY KEY (`id_preco`),
  ADD KEY `id_categoria` (`id_categoria`);


ALTER TABLE `tipo_loja`
  ADD PRIMARY KEY (`id_tipo_loja`);


ALTER TABLE `transacao_pagamento`
  ADD PRIMARY KEY (`id_transacao`),
  ADD KEY `id_status` (`id_status`),
  ADD KEY `id_contrato` (`id_contrato`);


ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `login` (`login`),
  ADD KEY `id_loja` (`id_loja`),
  ADD KEY `id_nivel` (`id_nivel`);


ALTER TABLE `carro`
  ADD CONSTRAINT `carro_ibfk_1` FOREIGN KEY (`id_status`) REFERENCES `dominio_status` (`id_status`),
  ADD CONSTRAINT `carro_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`),
  ADD CONSTRAINT `carro_ibfk_3` FOREIGN KEY (`id_loja_atual`) REFERENCES `loja` (`id_loja`);


ALTER TABLE `contrato_locacao`
  ADD CONSTRAINT `contrato_locacao_ibfk_1` FOREIGN KEY (`id_status`) REFERENCES `dominio_status` (`id_status`),
  ADD CONSTRAINT `contrato_locacao_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `contrato_locacao_ibfk_3` FOREIGN KEY (`id_carro`) REFERENCES `carro` (`id_carro`),
  ADD CONSTRAINT `contrato_locacao_ibfk_4` FOREIGN KEY (`id_loja_retirada`) REFERENCES `loja` (`id_loja`),
  ADD CONSTRAINT `contrato_locacao_ibfk_5` FOREIGN KEY (`id_motorista`) REFERENCES `motorista` (`id_motorista`),
  ADD CONSTRAINT `contrato_locacao_ibfk_6` FOREIGN KEY (`id_preco`) REFERENCES `tabela_preco` (`id_preco`);


ALTER TABLE `locacao_acessorio`
  ADD CONSTRAINT `locacao_acessorio_ibfk_1` FOREIGN KEY (`id_contrato`) REFERENCES `contrato_locacao` (`id_contrato`),
  ADD CONSTRAINT `locacao_acessorio_ibfk_2` FOREIGN KEY (`id_acessorio`) REFERENCES `acessorio` (`id_acessorio`);


ALTER TABLE `log_sistema`
  ADD CONSTRAINT `log_sistema_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);


ALTER TABLE `loja`
  ADD CONSTRAINT `loja_ibfk_1` FOREIGN KEY (`id_cidade`) REFERENCES `cidade` (`id_cidade`),
  ADD CONSTRAINT `loja_ibfk_2` FOREIGN KEY (`id_tipo_loja`) REFERENCES `tipo_loja` (`id_tipo_loja`);


ALTER TABLE `manutencao`
  ADD CONSTRAINT `manutencao_ibfk_1` FOREIGN KEY (`id_carro`) REFERENCES `carro` (`id_carro`),
  ADD CONSTRAINT `manutencao_ibfk_2` FOREIGN KEY (`id_loja_responsavel`) REFERENCES `loja` (`id_loja`);


ALTER TABLE `tabela_preco`
  ADD CONSTRAINT `tabela_preco_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`);


ALTER TABLE `transacao_pagamento`
  ADD CONSTRAINT `transacao_pagamento_ibfk_1` FOREIGN KEY (`id_status`) REFERENCES `dominio_status` (`id_status`),
  ADD CONSTRAINT `transacao_pagamento_ibfk_2` FOREIGN KEY (`id_contrato`) REFERENCES `contrato_locacao` (`id_contrato`);


ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_loja`) REFERENCES `loja` (`id_loja`),
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`id_nivel`) REFERENCES `nivel_acesso` (`id_nivel`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
