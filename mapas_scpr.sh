#!/bin/bash

ARQUIVO="mapas_scpr.pdf"

# nome do banco de dados PostGIS

BD="mareados"


# simbolo de velocidade zero

ZEROVELOC=-Sx0.05i

# arquivos com isóbatas

PROF30="DHN30m.gmt"
PROF50="DHN50m.gmt"
PROF100="GEBCO100m.gmt"
PROF200="GEBCO200m.gmt"
PROF1000="GEBCO1000m.gmt"

# rótulos das isóbatas

ROT30="30"
ROT50="50"
ROT100="100"
ROT200="200"
ROT1000="1000"

# localização dos rótulos das isóbatas

LAB="-51/-30.4/-47/-30.4"

# localização data e hora

LOCDATA="-47 -30"

# posição logo ibama

POSLOGO="6.5c/23c"

# cabeçalhos

CAB1="-49 -23.69 INSTITUTO BRASILEIRO DO MEIO AMBIENTE E DOS RECURSOS NATURAIS RENOV\301VEIS"
CAB2="-49 -23.82 Diretoria de Prote\347\343o Ambiental - DIPRO"
CAB3="-49 -23.95 MAREADOS SUL/SUDESTE"

# posição legenda

POSLEG="1c/15.5c"

# escala

ESCALA="-Lg-50/-25+c-27+w50n+f+u"

# cidade de referência

LOCREF="-48.661944 -26.907778 Itaja\355"

# região

NORTE=-24.5
SUL=-30.5
LESTE=-47
OESTE=-51

#
# PARÂMETROS DO GMT
#
#######################

REGIAO="-R$OESTE/$LESTE/$SUL/$NORTE"
PROJ="-JY-49.0/0.0/15" # -JYlon0/lat0width	Cylindrical equal area
ANOT="-Baf"

gmt set FORMAT_GEO_MAP ddd:mm:ssF FONT_ANNOT_PRIMARY 8p MAP_FRAME_TYPE plain

# data e hora do rastreamento utilizado

DATAHORA=`cat datahora.txt`

# executa os mapas programados .map para SC

touch arqmaps.txt

for i in maps/*.map; do
	source $i
	echo -n "`basename $i .map`.pdf " >> arqmaps.txt
done

# junta os mapas (.pdf)

pdfunite `cat arqmaps.txt` $ARQUIVO

rm -f `cat arqmaps.txt`
rm -f arqmaps.txt
