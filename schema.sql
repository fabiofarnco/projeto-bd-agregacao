-- =========================================
-- SISTEMA DE GESTÃO DE PROJETOS E EQUIPES
-- =========================================

-- Tabela de funcionários
CREATE TABLE funcionario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    supervisor_id INTEGER REFERENCES funcionario(id)
);

-- Tabela de dependentes
CREATE TABLE dependente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    funcionario_id INTEGER NOT NULL,
    CONSTRAINT fk_funcionario
        FOREIGN KEY (funcionario_id)
        REFERENCES funcionario(id)
        ON DELETE CASCADE
);

-- Tabela de projetos
CREATE TABLE projeto (
    id SERIAL PRIMARY KEY,
    nome_projeto VARCHAR(100) NOT NULL
);

-- Tabela de alocação de equipamentos
CREATE TABLE alocacao_equipamento (
    id SERIAL PRIMARY KEY,
    funcionario_id INTEGER,
    projeto_id INTEGER,
    nome_equipamento VARCHAR(100),
    FOREIGN KEY (funcionario_id) REFERENCES funcionario(id),
    FOREIGN KEY (projeto_id) REFERENCES projeto(id)
);

-- =========================================
-- INSERÇÃO DE DADOS
-- =========================================

INSERT INTO funcionario (nome, supervisor_id) VALUES
('Carlos', NULL),
('Ana', 1),
('João', 1);

INSERT INTO dependente (nome, funcionario_id) VALUES
('Lucas', 1),
('Mariana', 2);

INSERT INTO projeto (nome_projeto) VALUES
('Sistema Web'),
('App Mobile');

INSERT INTO alocacao_equipamento (funcionario_id, projeto_id, nome_equipamento) VALUES
(1, 1, 'Notebook'),
(2, 2, 'Tablet');

-- =========================================
-- CONSULTA PARA MOSTRAR FUNCIONÁRIO E SUPERVISOR
-- =========================================

SELECT
    f.nome AS funcionario,
    s.nome AS supervisor
FROM funcionario f
LEFT JOIN funcionario s
    ON f.supervisor_id = s.id;
