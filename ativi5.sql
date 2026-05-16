CREATE OR REPLACE FUNCTION total_clientes_por_dia(data_consulta DATE)
RETURNS INTEGER AS $$
DECLARE
    total_cadastrados INTEGER;
BEGIN
    -- Conta quantos clientes foram cadastrados na data informada
    SELECT COUNT(*) 
    INTO total_cadastrados
    FROM clientes
    WHERE DATE(data_cadastro) = data_consulta;

    -- Retorna o valor final encontrado
    RETURN total_cadastrados;
END;
$$ LANGUAGE plpgsql;