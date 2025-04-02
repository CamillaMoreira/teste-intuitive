COPY operadoras_registradas (
    cod_ans, identificacao_cnpj, nome_empresa, nome_fantasia, modalidade, endereco, 
    numero_endereco, complemento_endereco, bairro, cidade, estado, codigo_postal,
    codigo_area, telefone_contato, telefone_fax, email_contato, nome_representante, 
    cargo_representante, regiao_comercializacao, data_registro
)
FROM 'C:\camillaRepos\teste-python\teste3\3_donwload\Relatorio_cadop.csv'
DELIMITER ';' 
CSV HEADER 
ENCODING 'UTF8';

COPY temp_balancetes (
    data_balancete, cod_ans, codigo_contabil, descricao_contabil, 
    valor_saldo_inicial, valor_saldo_final
)
FROM 'C:\camillaRepos\teste-python\teste3\3_donwload\1T2023.csv'
DELIMITER ';' 
CSV HEADER 
ENCODING 'UTF8';

COPY temp_balancetes (
    data_balancete, cod_ans, codigo_contabil, descricao_contabil, 
    valor_saldo_inicial, valor_saldo_final
)
FROM 'C:\camillaRepos\teste-python\teste3\3_donwload\1T2024.csv'
DELIMITER ';' 
CSV HEADER 
ENCODING 'UTF8';

COPY temp_balancetes (
    data_balancete, cod_ans, codigo_contabil, descricao_contabil, 
    valor_saldo_inicial, valor_saldo_final
)
FROM 'C:\camillaRepos\teste-python\teste3\3_donwload\2t2023.csv'
DELIMITER ';' 
CSV HEADER 
ENCODING 'UTF8';

COPY temp_balancetes (
    data_balancete, cod_ans, codigo_contabil, descricao_contabil, 
    valor_saldo_inicial, valor_saldo_final
)
FROM 'C:\camillaRepos\teste-python\teste3\3_donwload\2T2024.csv'
DELIMITER ';' 
CSV HEADER 
ENCODING 'UTF8';

COPY temp_balancetes (
    data_balancete, cod_ans, codigo_contabil, descricao_contabil, 
    valor_saldo_inicial, valor_saldo_final
)
FROM 'C:\camillaRepos\teste-python\teste3\3_donwload\3T2023.csv'
DELIMITER ';' 
CSV HEADER 
ENCODING 'UTF8';

COPY temp_balancetes (
    data_balancete, cod_ans, codigo_contabil, descricao_contabil, 
    valor_saldo_inicial, valor_saldo_final
)
FROM 'C:\camillaRepos\teste-python\teste3\3_donwload\3T2024.csv'
DELIMITER ';' 
CSV HEADER 
ENCODING 'UTF8';

COPY temp_balancetes_formato_data_especifico (
    data_balancete, cod_ans, codigo_contabil, descricao_contabil, 
    valor_saldo_inicial, valor_saldo_final
)
FROM 'C:\camillaRepos\teste-python\teste3\3_donwload\4T2023.csv'
DELIMITER ';' 
CSV HEADER 
ENCODING 'UTF8';

COPY temp_balancetes (
    data_balancete, cod_ans, codigo_contabil, descricao_contabil, 
    valor_saldo_inicial, valor_saldo_final
)
FROM 'C:\camillaRepos\teste-python\teste3\3_donwload\4T2024.csv'
DELIMITER ';' 
CSV HEADER 
ENCODING 'UTF8';


INSERT INTO balancetes_financeiros (
    data_balancete, cod_ans, codigo_contabil, descricao_contabil, 
    valor_saldo_inicial, valor_saldo_final
)
SELECT 
    TO_DATE(data_balancete, 'YYYY/MM/DD'),
    cod_ans,
    codigo_contabil,
    descricao_contabil,
    REPLACE(valor_saldo_inicial, ',', '.')::DECIMAL(15,2),
    REPLACE(valor_saldo_final, ',', '.')::DECIMAL(15,2)
FROM temp_balancetes;

INSERT INTO balancetes_financeiros (
    data_balancete, cod_ans, codigo_contabil, descricao_contabil, 
    valor_saldo_inicial, valor_saldo_final
)
SELECT 
    TO_DATE(data_balancete, 'DD/MM/YYYY'),
    cod_ans,
    codigo_contabil,
    descricao_contabil,
    REPLACE(valor_saldo_inicial, ',', '.')::DECIMAL(15,2),
    REPLACE(valor_saldo_final, ',', '.')::DECIMAL(15,2)
FROM temp_balancetes_formato_data_especifico;

