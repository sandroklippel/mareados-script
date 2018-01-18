CREATE OR REPLACE FUNCTION cidade_nome(geometry) RETURNS varchar AS $$
   SELECT cidade FROM locais WHERE st_covers(wkb_geometry, $1) ORDER BY nivel LIMIT 1;
$$ LANGUAGE SQL;