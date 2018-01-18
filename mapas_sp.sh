#!/bin/bash

ARQUIVO="mapas_sp.pdf"

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

LAB="-49/-26.5/-44/-27.25"

# localização data e hora

LOCDATA="-44.7 -27"

# posição logo ibama

POSLOGO="6.5c/23c"

# cabeçalhos

CAB1="-46.75 -20.89 INSTITUTO BRASILEIRO DO MEIO AMBIENTE E DOS RECURSOS NATURAIS RENOV\301VEIS"
CAB2="-46.75 -21.02 Diretoria de Prote\347\343o Ambiental - DIPRO"
CAB3="-46.75 -21.15 MAREADOS SUL/SUDESTE"

# posição legenda

POSLEG="1c/14c"

# escala

ESCALA="-Lg-47.66/-22.33+c-24+w50n+f+u"

# cidade de referência

LOCREF="-46.45 -23.9 Santos"

# região

NORTE=-22
SUL=-27.5
LESTE=-44.7
OESTE=-48.7

#
# PARÂMETROS DO GMT
#
#######################

REGIAO="-R$OESTE/$LESTE/$SUL/$NORTE"
PROJ="-JY-47.0/0.0/15" # -JYlon0/lat0width	Cylindrical equal area
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
