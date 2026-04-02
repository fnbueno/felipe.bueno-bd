CREATE DATABASE IF NOT EXISTS Loja;
USE Loja;


CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(15),
    data_nascimento DATE,
    genero VARCHAR(20),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_cliente VARCHAR(20) DEFAULT 'Ativo',
    PRIMARY KEY (id_cliente)
);

CREATE TABLE IF NOT EXISTS enderecos (
    id_endereco INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    rua VARCHAR(100),
    numero VARCHAR(10),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    cep VARCHAR(10),
    complemento VARCHAR(100),
    PRIMARY KEY (id_endereco),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);


CREATE TABLE IF NOT EXISTS produtos (
    id_produto INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    categoria VARCHAR(50),
    marca VARCHAR(50),
    preco DECIMAL(8,2) NOT NULL,
    custo DECIMAL(8,2),
    estoque INT NOT NULL CHECK (estoque >= 0),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_produto VARCHAR(20) DEFAULT 'Ativo',
    PRIMARY KEY (id_produto)
);

CREATE TABLE IF NOT EXISTS variacoes_produto (
    id_variacao INT AUTO_INCREMENT,
    id_produto INT NOT NULL,
    tamanho VARCHAR(10),
    cor VARCHAR(30),
    estoque INT NOT NULL,
    PRIMARY KEY (id_variacao),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

CREATE TABLE IF NOT EXISTS pedidos (
    id_pedido INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL,
    forma_pagamento VARCHAR(50),
    valor_total DECIMAL(10,2),
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE IF NOT EXISTS itens_pedido (
    id_item INT AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_variacao INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(8,2) NOT NULL,
    subtotal DECIMAL(10,2),
    PRIMARY KEY (id_item),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_variacao) REFERENCES variacoes_produto(id_variacao)
);

CREATE TABLE IF NOT EXISTS pagamentos (
    id_pagamento INT AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    metodo VARCHAR(50),
    status_pagamento VARCHAR(50),
    data_pagamento DATETIME,
    PRIMARY KEY (id_pagamento),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

INSERT INTO clientes (nome, cpf, email, telefone, data_nascimento, genero) VALUES
('João Silva', '12345678901', 'joao@gmail.com', '11999999999', '2000-05-10', 'Masculino'),
('Maria Souza', '23456789012', 'maria@gmail.com', '11988888888', '1998-08-20', 'Feminino'),
('Pedro Lima', '34567890123', 'pedro@gmail.com', '11977777777', '1995-02-15', 'Masculino'),
('Ana Costa', '45678901234', 'ana@gmail.com', '11966666666', '2001-11-30', 'Feminino'),
('Lucas Rocha', '56789012345', 'lucas@gmail.com', '11955555555', '1999-07-25', 'Masculino');

INSERT INTO produtos (nome, descricao, categoria, marca, preco, custo, estoque) VALUES
('Camiseta Básica', 'Camiseta de algodão', 'Camiseta', 'Nike', 79.90, 40.00, 100),
('Calça Jeans', 'Calça jeans azul', 'Calça', 'Levis', 150.00, 80.00, 50),
('Jaqueta', 'Jaqueta de inverno', 'Jaqueta', 'Adidas', 300.00, 180.00, 30),
('Tênis Esportivo', 'Tênis confortável', 'Calçado', 'Puma', 350.00, 200.00, 25),
('Boné', 'Boné ajustável', 'Acessório', 'New Era', 90.00, 45.00, 60);


INSERT INTO variacoes_produto (id_produto, tamanho, cor, estoque) VALUES
(1, 'M', 'Preto', 30),
(1, 'G', 'Branco', 20),
(2, '42', 'Azul', 15),
(3, 'G', 'Preto', 10),
(4, '40', 'Branco', 12);


INSERT INTO pedidos (id_cliente, status, forma_pagamento, valor_total) VALUES
(1, 'Finalizado', 'Cartão', 159.80),
(2, 'Pendente', 'Pix', 150.00),
(3, 'Cancelado', 'Boleto', 300.00),
(4, 'Finalizado', 'Cartão', 350.00),
(5, 'Pendente', 'Pix', 90.00);

INSERT INTO itens_pedido (id_pedido, id_variacao, quantidade, preco_unitario, subtotal) VALUES
(1, 1, 2, 79.90, 159.80),
(2, 3, 1, 150.00, 150.00),
(3, 4, 1, 300.00, 300.00),
(4, 5, 1, 350.00, 350.00),
(5, 2, 1, 90.00, 90.00);

INSERT INTO pagamentos (id_pedido, valor, metodo, status_pagamento, data_pagamento) VALUES
(1, 159.80, 'Cartão', 'Aprovado', '2026-03-01 10:00:00'),
(2, 150.00, 'Pix', 'Pendente', NULL),
(3, 300.00, 'Boleto', 'Cancelado', NULL),
(4, 350.00, 'Cartão', 'Aprovado', '2026-03-04 16:20:00'),
(5, 90.00, 'Pix', 'Pendente', NULL);