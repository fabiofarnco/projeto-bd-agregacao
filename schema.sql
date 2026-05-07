-- ======================================
-- TABELA FUNCIONARIO (AUTORRELACIONAMENTO)
-- ======================================

CREATE TABLE funcionario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    supervisor_id INTEGER,

    CONSTRAINT fk_supervisor
    FOREIGN KEY (supervisor_id)
    REFERENCES funcionario(id)
);

-- ======================================
-- TABELA DEPENDENTE (ENTIDADE FRACA)
-- ======================================

CREATE TABLE dependente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    funcionario_id INTEGER NOT NULL,

    CONSTRAINT fk_funcionario
    FOREIGN KEY (funcionario_id)
    REFERENCES funcionario(id)
    ON DELETE CASCADE
);

-- ======================================
-- TABELA PROJETO
-- ======================================

CREATE TABLE projeto (
    id SERIAL PRIMARY KEY,
    nome_projeto VARCHAR(100) NOT NULL
);

-- ======================================
-- AGREGAÇÃO
-- FUNCIONARIO + PROJETO + EQUIPAMENTO
-- ======================================

CREATE TABLE alocacao_equipamento (
    id SERIAL PRIMARY KEY,

    funcionario_id INTEGER NOT NULL,
    projeto_id INTEGER NOT NULL,

    nome_equipamento VARCHAR(100) NOT NULL,

    CONSTRAINT fk_funcionario_alocacao
    FOREIGN KEY (funcionario_id)
    REFERENCES funcionario(id),

    CONSTRAINT fk_projeto_alocacao
    FOREIGN KEY (projeto_id)
    REFERENCES projeto(id)
);

-- ======================================
-- INSERTS PARA TESTE
-- ======================================

INSERT INTO funcionario (nome, supervisor_id)
VALUES
('Ana', NULL),
('Carlos', 1),
('Marina', 1),
('João', 2);

INSERT INTO dependente (nome, funcionario_id)
VALUES
('Pedro', 2),
('Julia', 2),
('Lucas', 3);

INSERT INTO projeto (nome_projeto)
VALUES
('Sistema Financeiro'),
('Portal Web');

INSERT INTO alocacao_equipamento
(funcionario_id, projeto_id, nome_equipamento)
VALUES
(2, 1, 'Notebook Dell'),
(3, 1, 'Monitor LG'),
(4, 2, 'Notebook Lenovo');

-- ======================================
-- SELECT FUNCIONARIO E SUPERVISOR
-- ======================================

SELECT
    f.nome AS funcionario,
    s.nome AS supervisor
FROM funcionario f
LEFT JOIN funcionario s
ON f.supervisor_id = s.id;

-- ======================================
-- SELECT DEPENDENTES
-- ======================================

SELECT
    d.nome AS dependente,
    f.nome AS funcionario
FROM dependente d
JOIN funcionario f
ON d.funcionario_id = f.id;

-- ======================================
-- SELECT EQUIPAMENTOS
-- ======================================

SELECT
    f.nome AS funcionario,
    p.nome_projeto,
    a.nome_equipamento
FROM alocacao_equipamento a
JOIN funcionario f
ON a.funcionario_id = f.id
JOIN projeto p
ON a.projeto_id = p.id;
