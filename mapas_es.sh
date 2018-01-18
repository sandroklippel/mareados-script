#!/bin/bash

ARQUIVO="mapas_es.pdf"

# nome do banco de dados PostGIS

BD="mareados"


# simbolo de velocidade zero

ZEROVELOC=-Sx0.05i

# arquivos com isóbatas GEBCO GRID 2008

PROF30="DHN30m_SE.gmt"
PROF50="grid100.gmt"
PROF100="grid250.gmt"
PROF200="grid500.gmt"
PROF1000="GEBCO1000m.gmt"

# rótulos das isóbatas

ROT30="30"
ROT50="100"
ROT100="250"
ROT200="500"
ROT1000="1000"

# localização dos rótulos das isóbatas

LAB="-42/-22/-40.25/-23"

# localização data e hora

LOCDATA="-39 -22.75"

# posição logo ibama

POSLOGO="6.5c/23c"

# cabeçalhos

CAB1="-41 -16.87 INSTITUTO BRASILEIRO DO MEIO AMBIENTE E DOS RECURSOS NATURAIS RENOV\301VEIS"
CAB2="-41 -17 Diretoria de Prote\347\343o Ambiental - DIPRO"
CAB3="-41 -17.13 MAREADOS SUL/SUDESTE"

# posição legenda

POSLEG="1.2c/14.75c"

# escala

ESCALA="-Lg-42/-18.25+c-20+w50n+f+u"

# cidade de referência

LOCREF="-40.35 -20.25 Vit\363ria"

# região

NORTE=-18
SUL=-23.25
LESTE=-39
OESTE=-43

#
# PARÂMETROS DO GMT
#
#######################

REGIAO="-R$OESTE/$LESTE/$SUL/$NORTE"
PROJ="-JY-41.0/0.0/15" # -JYlon0/lat0width	Cylindrical equal area
ANOT="-Baf"

gmt set FORMAT_GEO_MAP ddd:mm:ssF FONT_ANNOT_PRIMARY 8p MAP_FRAME_TYPE plain

# data e hora do rastreamento utilizado

DATAHORA=`cat datahora.txt`

# executa os mapas programados .map para SP

touch arqmaps.txt

for i in maps/*.map; do
	source $i
	echo -n "`basename $i .map`.pdf " >> arqmaps.txt
done

# junta os mapas (.pdf)

pdfunite `cat arqmaps.txt` $ARQUIVO

rm -f `cat arqmaps.txt`
rm -f arqmaps.txt
