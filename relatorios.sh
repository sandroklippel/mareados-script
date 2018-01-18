#!/bin/bash

# nome do banco de dados PostGIS

BD="mareados"

# obtem a data e a hora do arquivo de rastreamento

DATAHORA=`cat datahora.txt`

# executa os relatorios programados .rpt

for i in reports/*.rpt; do
	source $i
	echo $NOMES > $ARQUIVO
	psql -F ',' -A -t -c "select $CAMPOS from $TABELAS where $CONDICOES order by $ORDEM;" $BD >> $ARQUIVO
done