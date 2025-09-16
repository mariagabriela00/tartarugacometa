-- Arquivo: tartaruga_cometa
-- Descrição: Script de criação do banco de dados para o sistema Tartaruga Cometa
-- Autor: Maria Gabriela
-- Data: 04/09/2025

-- Criar o banco de dados
DROP DATABASE IF EXISTS tartaruga_cometa;
CREATE DATABASE tartaruga_cometa;
USE tartaruga_cometa;

-- Tabela para armazenar os remetentes
CREATE TABLE tb_remetente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_pessoa ENUM('Física', 'Jurídica') NOT NULL,
    cpf_cnpj VARCHAR(20) NOT NULL UNIQUE,
    nome_razao_social VARCHAR(100) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para armazenar os destinatários
CREATE TABLE tb_destinatario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_pessoa ENUM('Física', 'Jurídica') NOT NULL,
    cpf_cnpj VARCHAR(20) NOT NULL UNIQUE,
    nome_razao_social VARCHAR(100) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para armazenar os produtos
CREATE TABLE tb_produto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    peso DECIMAL(10,2) NOT NULL,
    volume DECIMAL(10,2) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para armazenar as entregas
CREATE TABLE tb_entrega (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_remetente INT NOT NULL,
    id_destinatario INT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_entrega TIMESTAMP NULL,
    status ENUM('Pendente', 'Em trânsito', 'Entregue', 'Cancelada') DEFAULT 'Pendente',
    observacoes TEXT,
    valor_frete DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (id_remetente) REFERENCES tb_remetente(id) ON DELETE CASCADE,
    FOREIGN KEY (id_destinatario) REFERENCES tb_destinatario(id) ON DELETE CASCADE
);

-- Tabela de relacionamento entre entregas e produtos
CREATE TABLE tb_entrega_produto (
    id_entrega INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_entrega, id_produto),
    FOREIGN KEY (id_entrega) REFERENCES tb_entrega(id) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES tb_produto(id) ON DELETE CASCADE
);

-- Tabela para histórico de status das entregas
CREATE TABLE tb_historico_status (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_entrega INT NOT NULL,
    status_anterior ENUM('Pendente', 'Em trânsito', 'Entregue', 'Cancelada'),
    status_novo ENUM('Pendente', 'Em trânsito', 'Entregue', 'Cancelada') NOT NULL,
    data_mudanca TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    observacao TEXT,
    FOREIGN KEY (id_entrega) REFERENCES tb_entrega(id) ON DELETE CASCADE
);

-- Inserir alguns dados de exemplo
INSERT INTO tb_remetente (tipo_pessoa, cpf_cnpj, nome_razao_social, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
('Jurídica', '12.345.678/0001-90', 'Loja Cometa Ltda', 'Rua das Flores', '123', 'Sala 101', 'Centro', 'São Paulo', 'SP', '01234-567'),
('Física', '123.456.789-00', 'João da Silva', 'Avenida Brasil', '456', 'Ap 202', 'Jardins', 'Rio de Janeiro', 'RJ', '12345-678');

INSERT INTO tb_destinatario (tipo_pessoa, cpf_cnpj, nome_razao_social, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
('Física', '987.654.321-00', 'Maria Oliveira', 'Rua das Palmeiras', '789', 'Casa 2', 'Vila Nova', 'Belo Horizonte', 'MG', '98765-432'),
('Jurídica', '98.765.432/0001-10', 'Empresa Estrela ME', 'Avenida Paulista', '1001', 'Conjunto 500', 'Bela Vista', 'São Paulo', 'SP', '01310-100');

INSERT INTO tb_produto (nome, descricao, peso, volume, valor) VALUES
('Notebook Gamer', 'Notebook com placa de vídeo dedicada', 2.5, 0.03, 3500.00),
('Smartphone', 'Smartphone Android com 128GB', 0.3, 0.002, 1200.00),
('Monitor 24"', 'Monitor LED Full HD', 4.2, 0.05, 899.90);

INSERT INTO tb_entrega (id_remetente, id_destinatario, status, observacoes, valor_frete) VALUES
(1, 1, 'Entregue', 'Entregue no período da tarde', 25.50),
(2, 2, 'Em trânsito', 'Produto frágil - manusear com cuidado', 18.75);

INSERT INTO tb_entrega_produto (id_entrega, id_produto, quantidade) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 3);

INSERT INTO tb_historico_status (id_entrega, status_anterior, status_novo, data_mudanca, observacao) VALUES
(1, NULL, 'Pendente', NOW() - INTERVAL 5 DAY, 'Entrega registrada no sistema'),
(1, 'Pendente', 'Em trânsito', NOW() - INTERVAL 3 DAY, 'Entrega despachada para transporte'),
(1, 'Em trânsito', 'Entregue', NOW() - INTERVAL 1 DAY, 'Entrega realizada com sucesso'),
(2, NULL, 'Pendente', NOW() - INTERVAL 2 DAY, 'Entrega registrada no sistema'),
(2, 'Pendente', 'Em trânsito', NOW() - INTERVAL 1 DAY, 'Entrega em transporte');

-- Criar índices para melhorar performance
CREATE INDEX idx_remetente_cpf_cnpj ON tb_remetente(cpf_cnpj);
CREATE INDEX idx_destinatario_cpf_cnpj ON tb_destinatario(cpf_cnpj);
CREATE INDEX idx_entrega_status ON tb_entrega(status);
CREATE INDEX idx_entrega_data ON tb_entrega(data_criacao);
CREATE INDEX idx_historico_entrega ON tb_historico_status(id_entrega);

-- Exibir mensagem de conclusão
SELECT 'Banco de dados Tartaruga Cometa criado com sucesso!' AS Status;



