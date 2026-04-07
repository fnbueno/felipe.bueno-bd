DROP DATABASE IF EXISTS Locadora;
CREATE DATABASE Locadora;
USE Locadora;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    telefone VARCHAR(15),
    email VARCHAR(100),
    PRIMARY KEY (id_cliente)
);

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT,
    PRIMARY KEY (id_categoria)
);

CREATE TABLE veiculo (
    id_veiculo INT AUTO_INCREMENT,
    modelo VARCHAR(100),
    placa VARCHAR(10) UNIQUE,
    id_categoria INT,
    status VARCHAR(20),
    PRIMARY KEY (id_veiculo),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT,
    id_cliente INT,
    id_veiculo INT,
    data_reserva DATETIME,
    status VARCHAR(20),
    PRIMARY KEY (id_reserva),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);

CREATE TABLE contrato (
    id_contrato INT AUTO_INCREMENT,
    id_reserva INT,
    data_inicio DATE,
    data_fim DATE,
    valor_total DECIMAL(10,2),
    PRIMARY KEY (id_contrato),
    FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva)
);

CREATE TABLE devolucao (
    id_devolucao INT AUTO_INCREMENT,
    id_contrato INT,
    data_devolucao DATE,
    status VARCHAR(20),
    PRIMARY KEY (id_devolucao),
    FOREIGN KEY (id_contrato) REFERENCES contrato(id_contrato)
);

CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT,
    id_contrato INT,
    valor DECIMAL(10,2),
    metodo VARCHAR(50),
    status VARCHAR(20),
    PRIMARY KEY (id_pagamento),
    FOREIGN KEY (id_contrato) REFERENCES contrato(id_contrato)
);

CREATE TABLE multa (
    id_multa INT AUTO_INCREMENT,
    id_veiculo INT,
    descricao TEXT,
    valor DECIMAL(10,2),
    PRIMARY KEY (id_multa),
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);

CREATE TABLE manutencao (
    id_manutencao INT AUTO_INCREMENT,
    id_veiculo INT,
    descricao TEXT,
    data_manutencao DATE,
    custo DECIMAL(10,2),
    PRIMARY KEY (id_manutencao),
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);

INSERT INTO cliente (nome, cpf, telefone, email) VALUES
('João Silva', '11111111111', '11999999999', 'joao@gmail.com'),
('Maria Souza', '22222222222', '11988888888', 'maria@gmail.com'),
('Pedro Lima', '33333333333', '11977777777', 'pedro@gmail.com'),
('Ana Costa', '44444444444', '11966666666', 'ana@gmail.com'),
('Lucas Rocha', '55555555555', '11955555555', 'lucas@gmail.com');

INSERT INTO categoria (nome, descricao) VALUES
('Econômico', 'Carros baratos'),
('SUV', 'Carros grandes'),
('Sedan', 'Carros confortáveis'),
('Luxo', 'Carros premium'),
('Esportivo', 'Carros rápidos');

INSERT INTO veiculo (modelo, placa, id_categoria, status) VALUES
('Onix', 'ABC1234', 1, 'Disponível'),
('HB20', 'DEF5678', 1, 'Disponível'),
('Compass', 'GHI9012', 2, 'Alugado'),
('Corolla', 'JKL3456', 3, 'Disponível'),
('BMW X1', 'MNO7890', 4, 'Manutenção');

INSERT INTO reserva (id_cliente, id_veiculo, data_reserva, status) VALUES
(1, 1, '2026-04-01 10:00:00', 'Ativa'),
(2, 2, '2026-04-02 11:00:00', 'Ativa'),
(3, 3, '2026-04-03 12:00:00', 'Cancelada'),
(4, 4, '2026-04-04 13:00:00', 'Ativa'),
(5, 5, '2026-04-05 14:00:00', 'Ativa');

INSERT INTO contrato (id_reserva, data_inicio, data_fim, valor_total) VALUES
(1, '2026-04-01', '2026-04-05', 500.00),
(2, '2026-04-02', '2026-04-06', 600.00),
(3, '2026-04-03', '2026-04-07', 700.00),
(4, '2026-04-04', '2026-04-08', 800.00),
(5, '2026-04-05', '2026-04-09', 900.00);

INSERT INTO devolucao (id_contrato, data_devolucao, status) VALUES
(1, '2026-04-05', 'Concluída'),
(2, '2026-04-06', 'Concluída'),
(3, '2026-04-07', 'Pendente'),
(4, '2026-04-08', 'Concluída'),
(5, '2026-04-09', 'Pendente');

INSERT INTO pagamento (id_contrato, valor, metodo, status) VALUES
(1, 500.00, 'Cartão', 'Pago'),
(2, 600.00, 'Pix', 'Pago'),
(3, 700.00, 'Boleto', 'Pendente'),
(4, 800.00, 'Cartão', 'Pago'),
(5, 900.00, 'Pix', 'Pendente');

INSERT INTO multa (id_veiculo, descricao, valor) VALUES
(1, 'Atraso', 50.00),
(2, 'Dano leve', 100.00),
(3, 'Multa trânsito', 150.00),
(4, 'Atraso', 80.00),
(5, 'Dano grave', 300.00);

INSERT INTO manutencao (id_veiculo, descricao, data_manutencao, custo) VALUES
(1, 'Troca de óleo', '2026-03-01', 200.00),
(2, 'Revisão geral', '2026-03-05', 300.00),
(3, 'Pneu', '2026-03-10', 400.00),
(4, 'Freio', '2026-03-15', 250.00),
(5, 'Motor', '2026-03-20', 1000.00);

SHOW TABLES like "manutencao";
