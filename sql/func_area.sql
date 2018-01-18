CREATE OR REPLACE FUNCTION func_area_nome(geometry) RETURNS varchar AS $$
   SELECT descricao FROM areas_zee_sudeste_sul WHERE st_covers(geom, $1) LIMIT 1;
$$ LANGUAGE SQL;