-- 10 operadoras com maiores despesas em "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre
select id, nome_empresa, balanco_final from (
    select op.id, op.nome_empresa, sum(bf.valor_saldo_final) as balanco_final
    from operadoras_registradas op
    join balancetes_financeiros bf using(cod_ans)
	WHERE 
        bf.descricao_contabil = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
    AND bf.data_balancete >= date_trunc('quarter', current_date) - INTERVAL '3 months'
    group by op.id, op.nome_empresa
) order by balanco_final desc limit 10;

-- 10 operadoras com maiores despesas em "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último ano
select id, nome_empresa, balanco_final from (
    select op.id, op.nome_empresa, sum(bf.valor_saldo_final) as balanco_final
    from operadoras_registradas op
    join balancetes_financeiros bf using(cod_ans)
	WHERE 
        bf.descricao_contabil = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
    AND bf.data_balancete >= date_trunc('quarter', current_date) - INTERVAL '12 months'
    group by op.id, op.nome_empresa
) order by balanco_final desc limit 10;