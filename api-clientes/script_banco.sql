CREATE DATABASE IF NOT EXISTS sistema_cliente;
USE sistema_cliente;

-- =========================
-- TABELA: clientes
-- =========================

CREATE TABLE IF NOT EXISTS clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    status ENUM('ativo', 'inativo') DEFAULT 'ativo'
);

-- =========================
-- TABELA: produtos
-- =========================

CREATE TABLE IF NOT EXISTS produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0
);

-- =========================
-- TABELA: usuarios
-- =========================

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('admin', 'operador') DEFAULT 'operador',
    status ENUM('ativo', 'inativo') DEFAULT 'ativo',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- TABELA: pedidos
-- =========================

CREATE TABLE IF NOT EXISTS pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pendente', 'pago', 'cancelado') DEFAULT 'pendente',
    valor_total DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_pedidos_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(id)
);

-- =========================
-- TABELA: itens_pedido
-- =========================

CREATE TABLE IF NOT EXISTS itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_itens_pedido
        FOREIGN KEY (pedido_id)
        REFERENCES pedidos(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_itens_produto
        FOREIGN KEY (produto_id)
        REFERENCES produtos(id)
);

-- =========================
-- DADOS INICIAIS
-- =========================

INSERT INTO clientes (nome, email, telefone, status)
VALUES
('João Silva', 'joao@email.com', '11999999999', 'ativo');

INSERT INTO produtos (nome, descricao, preco, estoque)
VALUES
('Teclado', 'Teclado USB', 50.00, 10);

INSERT INTO usuarios (nome, email, senha, perfil, status)
VALUES
('Administrador', 'admin@email.com', '123456', 'admin', 'ativo');