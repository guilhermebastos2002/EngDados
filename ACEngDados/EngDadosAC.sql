-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS LavanderiaAutomatica;
USE LavanderiaAutomatica;

-- Tabela Cliente
CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(100),
    Data_Cadastro DATE NOT NULL,
    Saldo_Creditos DECIMAL(10, 2) DEFAULT 0.00,
    Referencia_ID_Cliente INT,
    FOREIGN KEY (Referencia_ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Máquina
CREATE TABLE Maquina (
    ID_Maquina INT AUTO_INCREMENT PRIMARY KEY,
    Tipo ENUM('Lavadora', 'Secadora') NOT NULL,
    Estado ENUM('Disponível', 'Ocupada', 'Em Manutenção') NOT NULL,
    Localizacao VARCHAR(100),
    Data_Aquisicao DATE,
    Ultima_Manutencao DATE
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    Valor DECIMAL(10, 2) NOT NULL,
    Metodo_Pagamento ENUM('Dinheiro', 'Cartão', 'Carteira Digital') NOT NULL,
    Data_Hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Notificação
CREATE TABLE Notificacao (
    ID_Notificacao INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    Tipo_Notificacao ENUM('SMS', 'Email', 'App') NOT NULL,
    Mensagem TEXT,
    Data_Hora_Envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Fidelidade
CREATE TABLE Fidelidade (
    ID_Fidelidade INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    Pontos_Acumulados INT DEFAULT 0,
    Data_Atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Empregado
CREATE TABLE Empregado (
    ID_Empregado INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) NOT NULL UNIQUE,
    Endereco VARCHAR(255),
    Salario DECIMAL(10, 2),
    Genero ENUM('Masculino', 'Feminino', 'Outro'),
    Tipo_Empregado ENUM('Contratado', 'Terceirizado') NOT NULL,
    CTPS VARCHAR(20),
    CNPJ_Empresa_Terceirizada VARCHAR(14),
    Unidade_ID INT,
    Supervisor_ID_Empregado INT,
    FOREIGN KEY (Supervisor_ID_Empregado) REFERENCES Empregado(ID_Empregado)
);

-- Tabela Unidade
CREATE TABLE Unidade (
    ID_Unidade INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(255),
    Telefone VARCHAR(20),
    Gerente_ID_Empregado INT,
    FOREIGN KEY (Gerente_ID_Empregado) REFERENCES Empregado(ID_Empregado)
);

-- Atualizar tabela Empregado para adicionar chave estrangeira Unidade_ID após a criação de Unidade
ALTER TABLE Empregado ADD CONSTRAINT FK_Unidade_Empregado FOREIGN KEY (Unidade_ID) REFERENCES Unidade(ID_Unidade);

-- Inserção de dados na tabela Cliente
INSERT INTO Cliente (Nome, Endereco, Telefone, Email, Data_Cadastro, Saldo_Creditos)
VALUES 
('Alice Silva', 'Rua das Flores, 123', '1111-1111', 'alice@example.com', '2023-01-01', 50.00),
('Bob Costa', 'Av. Central, 456', '2222-2222', 'bob@example.com', '2023-01-02', 30.00),
('Carlos Souza', 'Praça da Liberdade, 789', '3333-3333', 'carlos@example.com', '2023-01-03', 20.00),
('Diana Lima', 'Rua Nova, 101', '4444-4444', 'diana@example.com', '2023-01-04', 40.00),
('Eva Martins', 'Av. Paulista, 202', '5555-5555', 'eva@example.com', '2023-01-05', 10.00);

-- Inserção de dados na tabela Maquina
INSERT INTO Maquina (Tipo, Estado, Localizacao, Data_Aquisicao, Ultima_Manutencao)
VALUES 
('Lavadora', 'Disponível', 'Sala 1', '2022-01-01', '2023-01-01'),
('Secadora', 'Disponível', 'Sala 2', '2022-02-01', '2023-02-01'),
('Lavadora', 'Em Manutenção', 'Sala 1', '2022-03-01', '2023-03-01'),
('Secadora', 'Ocupada', 'Sala 2', '2022-04-01', '2023-04-01'),
('Lavadora', 'Disponível', 'Sala 3', '2022-05-01', '2023-05-01');

-- Inserção de dados na tabela Pagamento
INSERT INTO Pagamento (ID_Cliente, Valor, Metodo_Pagamento)
VALUES 
(1, 25.00, 'Dinheiro'),
(2, 15.00, 'Cartão'),
(3, 10.00, 'Carteira Digital'),
(4, 20.00, 'Dinheiro'),
(5, 5.00, 'Cartão');

-- Inserção de dados na tabela Notificacao
INSERT INTO Notificacao (ID_Cliente, Tipo_Notificacao, Mensagem)
VALUES 
(1, 'SMS', 'Sua roupa está pronta para ser retirada.'),
(2, 'Email', 'Pagamento confirmado.'),
(3, 'App', 'Você recebeu uma nova notificação.'),
(4, 'SMS', 'Sua roupa está pronta para ser retirada.'),
(5, 'Email', 'Pagamento confirmado.');

-- Inserção de dados na tabela Fidelidade
INSERT INTO Fidelidade (ID_Cliente, Pontos_Acumulados)
VALUES 
(1, 100),
(2, 50),
(3, 75),
(4, 120),
(5, 30);

-- Inserção de dados na tabela Unidade
INSERT INTO Unidade (Nome, Endereco, Telefone, Gerente_ID_Empregado)
VALUES 
('Unidade Central', 'Rua Principal, 100', '1111-2222', NULL),
('Unidade Norte', 'Av. Norte, 200', '2222-3333', NULL),
('Unidade Sul', 'Av. Sul, 300', '3333-4444', NULL);

-- Inserção de dados na tabela Empregado
INSERT INTO Empregado (Nome, CPF, Endereco, Salario, Genero, Tipo_Empregado, CTPS, CNPJ_Empresa_Terceirizada, Unidade_ID, Supervisor_ID_Empregado)
VALUES 
('Fernando Dias', '12345678901', 'Rua A, 10', 3000.00, 'Masculino', 'Contratado', 'CTPS123', NULL, 1, NULL),
('Gabriela Nunes', '23456789012', 'Rua B, 20', 2500.00, 'Feminino', 'Terceirizado', NULL, '12345678000100', 2, 1),
('Irene Cardoso', '34567890123', 'Rua C, 30', 2800.00, 'Feminino', 'Terceirizado', NULL, '23456789000100', 1, 2),
('João Almeida', '56789012345', 'Rua D, 40', 3200.00, 'Masculino', 'Contratado', 'CTPS456', NULL, 2, 1);

-- Atualizações
UPDATE Cliente SET Saldo_Creditos = 60.00 WHERE ID_Cliente = 1;
UPDATE Maquina SET Estado = 'Disponível' WHERE ID_Maquina = 3;
UPDATE Pagamento SET Valor = 30.00 WHERE ID_Pagamento = 1;
UPDATE Fidelidade SET Pontos_Acumulados = 150 WHERE ID_Cliente = 1;
UPDATE Notificacao SET Mensagem = 'Atualização da notificação' WHERE ID_Notificacao = 3;
UPDATE Unidade SET Gerente_ID_Empregado = 1 WHERE ID_Unidade = 1;
UPDATE Empregado SET Salario = 3500.00 WHERE ID_Empregado = 1;

-- Deleções
DELETE FROM Pagamento WHERE ID_Pagamento = 3;
DELETE FROM Notificacao WHERE ID_Notificacao = 3;
DELETE FROM Fidelidade WHERE ID_Fidelidade = 3;
DELETE FROM Cliente WHERE ID_Cliente = 3;
DELETE FROM Maquina WHERE ID_Maquina = 3;
DELETE FROM Unidade WHERE ID_Unidade = 3;
DELETE FROM Empregado WHERE ID_Empregado = 3;

-- 1. Join entre Cliente e Pagamento
SELECT Cliente.Nome, Pagamento.Valor, Pagamento.Metodo_Pagamento, Pagamento.Data_Hora
FROM Cliente
JOIN Pagamento ON Cliente.ID_Cliente = Pagamento.ID_Cliente;

-- 2. Group By e Having para somar créditos de clientes
SELECT Nome, SUM(Saldo_Creditos) AS Total_Creditos
FROM Cliente
GROUP BY Nome
HAVING Total_Creditos > 20;

-- 3. Order By para listar clientes pelo saldo de créditos
SELECT Nome, Saldo_Creditos
FROM Cliente
ORDER BY Saldo_Creditos DESC;

-- 4. Subquery para encontrar o cliente com mais pontos de fidelidade
SELECT Nome
FROM Cliente
WHERE ID_Cliente = (SELECT ID_Cliente FROM Fidelidade ORDER BY Pontos_Acumulados DESC LIMIT 1);

-- 5. Listar máquinas disponíveis
SELECT * FROM Maquina
WHERE Estado = 'Disponível';

-- 6. Join entre Cliente e Notificação para listar notificações
SELECT Cliente.Nome, Notificacao.Tipo_Notificacao, Notificacao.Mensagem, Notificacao.Data_Hora_Envio
FROM Cliente
JOIN Notificacao ON Cliente.ID_Cliente = Notificacao.ID_Cliente;

-- 7. Contar número de pagamentos por cliente
SELECT Cliente.Nome, COUNT(Pagamento.ID_Pagamento) AS Numero_Pagamentos
FROM Cliente
JOIN Pagamento ON Cliente.ID_Cliente = Pagamento.ID_Cliente
GROUP BY Cliente.Nome;

-- 8. Listar clientes que não possuem saldo de créditos
SELECT * FROM Cliente
WHERE Saldo_Creditos = 0;

-- 9. Listar todos os clientes com suas pontuações de fidelidade
SELECT Cliente.Nome, Fidelidade.Pontos_Acumulados
FROM Cliente
JOIN Fidelidade ON Cliente.ID_Cliente = Fidelidade.ID_Cliente;

-- 10. Subquery para encontrar o total de pontos acumulados por clientes
SELECT Nome, (SELECT SUM(Pontos_Acumulados) FROM Fidelidade WHERE Cliente.ID_Cliente = Fidelidade.ID_Cliente) AS Total_Pontos
FROM Cliente;

-- 11. Join entre Unidade e Empregado para listar empregados com suas unidades
SELECT Unidade.Nome AS Nome_Unidade, Empregado.Nome AS Nome_Empregado, Empregado.Salario
FROM Unidade
JOIN Empregado ON Unidade.ID_Unidade = Empregado.Unidade_ID;

-- 12. Listar empregados com supervisores
SELECT E1.Nome AS Nome_Empregado, E2.Nome AS Nome_Supervisor
FROM Empregado E1
LEFT JOIN Empregado E2 ON E1.Supervisor_ID_Empregado = E2.ID_Empregado;

-- 13. Listar empregados com o tipo e unidade
SELECT Empregado.Nome, Empregado.Tipo_Empregado, Unidade.Nome AS Nome_Unidade
FROM Empregado
JOIN Unidade ON Empregado.Unidade_ID = Unidade.ID_Unidade;

-- 14. Contar empregados por unidade
SELECT Unidade.Nome AS Nome_Unidade, COUNT(Empregado.ID_Empregado) AS Numero_Empregados
FROM Unidade
JOIN Empregado ON Unidade.ID_Unidade = Empregado.Unidade_ID
GROUP BY Unidade.Nome;

-- 15. Listar todos os gerentes com suas unidades
SELECT E.Nome AS Nome_Gerente, U.Nome AS Nome_Unidade
FROM Empregado E
JOIN Unidade U ON E.ID_Empregado = U.Gerente_ID_Empregado;

-- Criação da View
CREATE VIEW ClientePagamento AS
SELECT Cliente.Nome AS Nome_Cliente, Cliente.Email, Pagamento.Valor, Pagamento.Metodo_Pagamento, Pagamento.Data_Hora
FROM Cliente
JOIN Pagamento ON Cliente.ID_Cliente = Pagamento.ID_Cliente;

-- Consultando dados da View
SELECT * FROM ClientePagamento
WHERE Valor > 20.00;

