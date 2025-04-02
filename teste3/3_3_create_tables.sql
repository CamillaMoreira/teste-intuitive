CREATE TABLE IF NOT EXISTS operadoras_registradas (
    id SERIAL PRIMARY KEY,
    cod_ans VARCHAR(6) UNIQUE NOT NULL,
    identificacao_cnpj CHAR(14) NOT NULL CHECK (LENGTH(identificacao_cnpj) = 14),
    nome_empresa VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    endereco VARCHAR(255),
    numero_endereco VARCHAR(20),
    complemento_endereco VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2) NOT NULL CHECK (estado IN 
    ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA',
     'MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN',
     'RS','RO','RR','SC','SP','SE','TO')),
    codigo_postal CHAR(8) CHECK (LENGTH(codigo_postal) = 8),
    codigo_area CHAR(2) CHECK (LENGTH(codigo_area) = 2),
    telefone_contato VARCHAR(20),
    telefone_fax VARCHAR(20),
    email_contato VARCHAR(100) CHECK (email_contato LIKE '%@%.%'),
    nome_representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    regiao_comercializacao INT,
    data_registro DATE DEFAULT CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS balancetes_financeiros (
    id_balancete SERIAL PRIMARY KEY,
    data_balancete DATE NOT NULL DEFAULT CURRENT_DATE,
    cod_ans VARCHAR(6) NOT NULL,
    codigo_contabil VARCHAR(20) NOT NULL,
    descricao_contabil TEXT,
    valor_saldo_inicial DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    valor_saldo_final DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_cod_ans FOREIGN KEY (cod_ans) REFERENCES operadoras_registradas(cod_ans) ON DELETE CASCADE
);

CREATE INDEX idx_operadoras_estado ON operadoras_registradas(estado);
CREATE INDEX idx_balancetes_cod_ans ON balancetes_financeiros(cod_ans);
CREATE INDEX idx_balancetes_data ON balancetes_financeiros(data_balancete);
CREATE INDEX idx_balancetes_conta ON balancetes_financeiros(codigo_contabil);

-- usei somente para fazer o replace dos valores númericos com delimitador , (virgula) ao inves de . (ponto)
CREATE TEMP TABLE temp_balancetes (
    data_balancete TEXT,
    cod_ans VARCHAR(6),
    codigo_contabil VARCHAR(20),
    descricao_contabil TEXT,
    valor_saldo_inicial TEXT,
    valor_saldo_final TEXT
);

-- essa foi só porque um dos csv estava com o formato de data diferente dos demais
CREATE TEMP TABLE temp_balancetes_formato_data_especifico (
    data_balancete TEXT,
    cod_ans VARCHAR(6),
    codigo_contabil VARCHAR(20),
    descricao_contabil TEXT,
    valor_saldo_inicial TEXT,
    valor_saldo_final TEXT
);