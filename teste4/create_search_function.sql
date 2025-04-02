CREATE OR REPLACE FUNCTION buscar_operadoras(
    param_cod_ans VARCHAR(6) DEFAULT NULL,
    param_nome_empresa VARCHAR(255) DEFAULT NULL,
    param_nome_fantasia VARCHAR(255) DEFAULT NULL,
    param_modalidade VARCHAR(100) DEFAULT NULL,
    param_endereco VARCHAR(255) DEFAULT NULL,
    param_numero_endereco VARCHAR(20) DEFAULT NULL,
    param_complemento_endereco VARCHAR(100) DEFAULT NULL,
    param_bairro VARCHAR(100) DEFAULT NULL,
    param_cidade VARCHAR(100) DEFAULT NULL,
    param_telefone_contato VARCHAR(20) DEFAULT NULL,
    param_telefone_fax VARCHAR(20) DEFAULT NULL,
    param_email_contato VARCHAR(100) DEFAULT NULL,
    param_nome_representante VARCHAR(255) DEFAULT NULL,
    param_cargo_representante VARCHAR(100) DEFAULT NULL,
    param_identificacao_cnpj CHAR(14) DEFAULT NULL,
    param_estado CHAR(2) DEFAULT NULL
)
RETURNS TABLE (
    id INTEGER,
    cod_ans VARCHAR(6),
    identificacao_cnpj CHAR(14),
    nome_empresa VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    endereco VARCHAR(255),
    numero_endereco VARCHAR(20),
    complemento_endereco VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2),
    codigo_postal CHAR(8),
    codigo_area CHAR(2),
    telefone_contato VARCHAR(20),
    telefone_fax VARCHAR(20),
    email_contato VARCHAR(100),
    nome_representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    regiao_comercializacao INT,
    data_registro DATE
) AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM operadoras_registradas
    WHERE 
        (param_cod_ans IS NULL OR operadoras_registradas.cod_ans = param_cod_ans) AND
        (param_nome_empresa IS NULL OR operadoras_registradas.nome_empresa ILIKE '%' || param_nome_empresa || '%') AND
        (param_nome_fantasia IS NULL OR operadoras_registradas.nome_fantasia ILIKE '%' || param_nome_fantasia || '%') AND
        (param_modalidade IS NULL OR operadoras_registradas.modalidade ILIKE '%' || param_modalidade || '%') AND
        (param_endereco IS NULL OR operadoras_registradas.endereco ILIKE '%' || param_endereco || '%') AND
        (param_numero_endereco IS NULL OR operadoras_registradas.numero_endereco = param_numero_endereco) AND
        (param_complemento_endereco IS NULL OR operadoras_registradas.complemento_endereco ILIKE '%' || param_complemento_endereco || '%') AND
        (param_bairro IS NULL OR operadoras_registradas.bairro ILIKE '%' || param_bairro || '%') AND
        (param_cidade IS NULL OR operadoras_registradas.cidade ILIKE '%' || param_cidade || '%') AND
        (param_telefone_contato IS NULL OR operadoras_registradas.telefone_contato = param_telefone_contato) AND
        (param_telefone_fax IS NULL OR operadoras_registradas.telefone_fax = param_telefone_fax) AND
        (param_email_contato IS NULL OR operadoras_registradas.email_contato ILIKE '%' || param_email_contato || '%') AND
        (param_nome_representante IS NULL OR operadoras_registradas.nome_representante ILIKE '%' || param_nome_representante || '%') AND
        (param_cargo_representante IS NULL OR operadoras_registradas.cargo_representante ILIKE '%' || param_cargo_representante || '%') AND
        (param_identificacao_cnpj IS NULL OR operadoras_registradas.identificacao_cnpj = param_identificacao_cnpj) AND
        (param_estado IS NULL OR operadoras_registradas.estado = param_estado);
END;
$$ LANGUAGE plpgsql;