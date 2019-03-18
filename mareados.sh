#!/bin/bash

# arquivos com resultados

ARQUIVOS="mareados.ods \
         mapas_rs.pdf \
         mapas_scpr.pdf \
         mapas_rj.pdf \
         mapas_sp.pdf \
         mapas_es.pdf"

# localização do arquivo WatercraftTracking.csv

ONIXSAT="/home/mareados/Downloads/WatercraftTracking.csv"

# nome do banco de dados PostGIS

BD="mareados"

# testa se o arquivo existe

if [[ ! -f $ONIXSAT ]]; then
	echo ""
	echo "  Arquivo WatercraftTracking.csv não econtrado!"
	sleep 5
	exit 0
fi

# processa arquivos WatercraftTracking.csv
# provenientes da OnixsatPreps gerando uma tabela
# onixsat no banco de dados postgresql/postgis

echo ""
echo "  processamento do arquivo WatercraftTracking.csv"
echo ""

# muda diretório atual
cd /home/mareados/Documentos/script

# remove as quatro primeiras linhas do arquivo WatercraftTracking (modificado NEWPREPS)
tail -n +4 $ONIXSAT  > /var/tmp/processa.csv

# extrai a data e hora dos dados de rastreamento (modificado NEWPREPS)
head -n 3 $ONIXSAT | awk -F ";" '/Data/ {print $4}' > datahora.txt

# remove arquivo WatercraftTracking
rm -f $ONIXSAT

# carrega os dados para o BD e pré-processa os dados (modificado NEWPREPS)
psql $BD &> /dev/null <<EOF
drop table if exists temporario;

create table temporario
(
	embarcacao varchar,
	dummy1 varchar,
	dummy2 varchar,
	dummy3 varchar,
	datahora varchar,
	latitude varchar,
	longitude varchar,
	dummy4 varchar,
	dummy5 varchar,
	dummy6 varchar,
	dummy7 varchar,
	velocidade varchar,
	direcao varchar,
	dummy8 varchar,
	status varchar,
	bateria varchar,
	categoria varchar,
	dummy9 varchar,
	msg varchar,
	situacao varchar
);

copy temporario from '/var/tmp/processa.csv' delimiter ';' CSV HEADER ENCODING 'latin1';

drop table if exists onixsat cascade;

create table onixsat as select trim(upper(embarcacao)) as embarcacao,
datahora::timestamp,
DMS2DD(latitude) as latdec,
DMS2DD(longitude) as londec,
st_setsrid(st_point(DMS2DD(longitude),DMS2DD(latitude)),4326) as geog,
replace(replace(velocidade, ' Nós',''), ',', '.')::numeric as veloc,
replace(direcao, ' º', '')::integer as direcao,
bateria from temporario where latitude is not null and longitude is not null and direcao is not null and direcao != ' º';

alter table onixsat add column id serial primary key;

grant select on onixsat to qgis;

drop table if exists temporario;
EOF

# remove arquivo temporário
rm -f /var/tmp/processa.csv

echo ""
echo "  produz relatórios"
echo ""

./relatorios.sh
./csv2ods.py
rm *.csv

echo ""
echo "  produz os mapas do RS"
echo ""

./mapas_rs.sh

echo ""
echo "  produz os mapas de SC/PR"
echo ""

./mapas_scpr.sh

echo ""
echo "  produz os mapas de SP"
echo ""

./mapas_sp.sh

echo ""
echo "  produz os mapas do RJ"
echo ""

./mapas_rj.sh

echo ""
echo "  produz os mapas do ES"
echo ""

./mapas_es.sh

DATAHORA=`cat datahora.txt`

echo ""
echo "  move arquivos para a pasta Boletins_enviados"
echo ""

DIRETORIO=`cat datahora.txt | tr '/ :' '_' | awk -F "_" '{printf "%s-%s-%s_%s%s",$3,$2,$1,$4,$5}'`
mkdir "/home/mareados/Documentos/Boletins_enviados/$DIRETORIO"

# arquivos mareados

for i in $ARQUIVOS; do
 	mv $i "/home/mareados/Documentos/Boletins_enviados/$DIRETORIO"
done
