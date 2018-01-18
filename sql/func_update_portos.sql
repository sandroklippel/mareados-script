CREATE OR REPLACE FUNCTION func_update_portos() RETURNS boolean AS $$
   DROP TABLE IF EXISTS portos;
   CREATE TABLE portos AS SELECT st_collect(wkb_geometry) AS wkb_geometry FROM locais WHERE nivel = 3;
   SELECT true;
$$ LANGUAGE SQL;