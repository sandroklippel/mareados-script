CREATE OR REPLACE FUNCTION local_nome(geometry) RETURNS varchar AS $$
   SELECT nome FROM locais WHERE st_covers(wkb_geometry, $1) ORDER BY nivel LIMIT 1;
$$ LANGUAGE SQL;