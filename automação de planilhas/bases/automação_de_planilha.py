#AUTOMAÇÃO DE PLANILHAS
#1.IMPORTANDO BIBLIOTECAS
import pandas as pd
import os
import win32com.client as win
from datetime import datetime
#2.PASSANDO O CAMINHO DO ARQUIVO, IMPORTANDO, FAZENDO A JUNÇÃO.
arquivos = os.listdir('bases/bases')
tabela_consolidada = pd.DataFrame()
for nome_tabela in arquivos:
    tabela_vendas = pd.read_csv(os.path.join('bases/bases', nome_tabela))
    #Alterando a coluna Data de Venda, para Data.
    tabela_vendas['Data de Venda'] = pd.to_datetime('01/01/1900') + pd.to_timedelta(tabela_vendas['Data de Venda'], unit='d')
    tabela_consolidada = pd.concat([tabela_consolidada, tabela_vendas])
#transformando a base de csv para excel, alterando a ordem de valores da data e resetado o index.
tabela_consolidada =tabela_consolidada.sort_values('Data de Venda', ascending=False)
tabela_reset_index = tabela_consolidada.reset_index(drop=True, inplace=True)
tabela_consolidada.to_excel('Base_completa.xlsx', index=False)

#3.MANDANDO A BASE DE DADOS PARA O EMAIL DO CLIENTE.
outlook = win.Dispatch('outlook.application')
email = outlook.CreatItem(0)
email.To = 'dumice8@gmail.com'
data  = datetime.today().strftime("%d/%m/%Y")
email.Subject = f'Relatório das vendas {data}'
email.Body = f"""
Prezados, 
Segue o anexo do relatório de vendas {data} atualizado.
"""
caminho = os.getcwd()
anexo = os.path.join(caminho, 'Base_completa.xlsx')
email.Attachments.Add(anexo)
email.Send