#!/bin/bash

ARQUIVO="mapas_rj.pdf"

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

LAB="-45.5/-24.5/-44.5/-25.5"

# localização data e hora

LOCDATA="-41.5 -25"

# posição logo ibama

POSLOGO="6.5c/23c"

# cabeçalhos

CAB1="-43.5 -19.27 INSTITUTO BRASILEIRO DO MEIO AMBIENTE E DOS RECURSOS NATURAIS RENOV\301VEIS"
CAB2="-43.5 -19.4 Diretoria de Prote\347\343o Ambiental - DIPRO"
CAB3="-43.5 -19.53 MAREADOS SUL/SUDESTE"

# posição legenda

POSLEG="1.2c/14.75c"

# escala

ESCALA="-Lg-44.5/-20.5+c-23+w50n+f+u"

# cidade de referência

LOCREF="-43 -22.5 Rio de Janeiro"

# região

NORTE=-20.25
SUL=-25.5
LESTE=-41.5
OESTE=-45.5

#
# PARÂMETROS DO GMT
#
#######################

REGIAO="-R$OESTE/$LESTE/$SUL/$NORTE"
PROJ="-JY-43.0/0.0/15" # -JYlon0/lat0width	Cylindrical equal area
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
