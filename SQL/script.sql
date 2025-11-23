-- 1. Criação do Banco de Dados (se não existir)
CREATE DATABASE IF NOT EXISTS user2;

-- 2. Seleciona o Banco para uso
USE user2;

-- Opcional: Se quiser limpar tudo e começar do zero, descomente as linhas abaixo:
-- DROP TABLE IF EXISTS tbproduto;
-- DROP TABLE IF EXISTS tbusuario;

-- 3. Tabela de Usuários (tbusuario)
-- Inclui a coluna 'foto' para o perfil
CREATE TABLE IF NOT EXISTS tbusuario (
    idusuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    login VARCHAR(50) NOT NULL UNIQUE,
    senha VARCHAR(50) NOT NULL,
    idade INT,
    sexo VARCHAR(20),
    email VARCHAR(100),
    telefone VARCHAR(20),
    permissao TINYINT(1) DEFAULT 0, -- 0 = Comprador, 1 = Vendedor
    foto VARCHAR(255) DEFAULT NULL  -- Caminho da foto de perfil (ex: "nome_foto.jpg")
);

-- 4. Tabela de Produtos (tbproduto)
-- Inclui a coluna 'imagem' e a Chave Estrangeira ligando ao Usuário
CREATE TABLE IF NOT EXISTS tbproduto (
    idproduto INT AUTO_INCREMENT PRIMARY KEY,
    produto VARCHAR(150) NOT NULL,
    descricao TEXT,
    preco INT, -- Mantido INT para compatibilidade com sua DAO atual
    contato VARCHAR(50),
    idusuario INT NOT NULL,
    imagem VARCHAR(255) DEFAULT NULL, -- Caminho da foto do produto
    
    -- Cria a relação: Um produto pertence a um usuário
    FOREIGN KEY (idusuario) REFERENCES tbusuario(idusuario) ON DELETE CASCADE
);

-- 5. Inserção de um Usuário Administrador (Para testes iniciais)
-- Login: admin / Senha: 1234
INSERT IGNORE INTO tbusuario (nome, login, senha, idade, sexo, email, telefone, permissao) 
VALUES ('Administrador', 'admin', '1234', 30, 'Masculino', 'admin@semeia.com', '27 99999-9999', 1);

-- Confirmação
SELECT * FROM tbusuario;