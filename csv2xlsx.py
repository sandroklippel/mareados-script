#!/usr/bin/env python

from tablib import Databook, Dataset

arquivos = ['monitorando.csv',
            'portos.csv',
            'nomar_rs.csv',
            'nomar_scpr.csv',
            'nomar_sp.csv',
            'nomar_rj.csv',
            'nomar_es.csv',
            'sem_preps.csv']

nomes = ['monitoramento',
         'porto',
         'RS',
         'SCPR',
         'SP',
         'RJ',
         'ES',
         'desligou preps']

data = Databook()

for i in xrange(len(arquivos)):
        try:
            sheet = Dataset().load(open(arquivos[i]).read())
            sheet.title = nomes[i]
            data.add_sheet(sheet)

        except:
            pass

with open('mareados.xlsx', 'wb') as f:
    f.write(data.xlsx)
