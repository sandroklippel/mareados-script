CREATE or REPLACE FUNCTION func_prof(valor integer) RETURNS integer AS $$
DECLARE
    retorno integer;
BEGIN
    IF valor > 0 THEN 
	    retorno := 0;
    ELSE
        retorno := valor;
    END IF;	
    RETURN retorno;
END;
$$
LANGUAGE plpgsql;

CREATE or REPLACE FUNCTION func_prof(valor real) RETURNS real AS $$
DECLARE
    retorno real;
BEGIN
    IF valor > 0.0 THEN 
        retorno := 0.0;
    ELSE
        retorno := valor;
    END IF; 
    RETURN retorno;
END;
$$
LANGUAGE plpgsql;

CREATE or REPLACE FUNCTION func_prof(valor double precision) RETURNS double precision AS $$
DECLARE
    retorno double precision;
BEGIN
    IF valor > 0.0 THEN 
        retorno := 0.0;
    ELSE
        retorno := valor;
    END IF; 
    RETURN retorno;
END;
$$
LANGUAGE plpgsql;