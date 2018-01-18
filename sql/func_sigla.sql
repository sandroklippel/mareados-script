CREATE OR REPLACE FUNCTION sigla_nome(geometry) RETURNS varchar AS $$
   SELECT sigla FROM locais WHERE st_covers(wkb_geometry, $1) ORDER BY nivel LIMIT 1;
$$ LANGUAGE SQL;