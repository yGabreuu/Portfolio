'''Este código é apenas um script aonde ele analisa em tempo real a finanças,
da petrobras,bancodobrasil e central eletrica brasileira. Caso queira saber aonde eu adquirir.
Yohooh.finance. Para visualização de dados eu decidir usar o POWER BI caso queira ver está disponivel,
no perfil do meu linkedin.'''

#importando bibliotecas
import yfinance as yf
import pandas as pd

'''função para carregar os meus dados, com a biblioteca yfinance eu chamo um ticket que se comunica
com a base de dados do yahooh.finance, aonde na função ela faz a automoção do meu dataframe'''
def carregamento_dados(ingresso):
    data_base = yf.Ticker(
        ingresso
        ).history('1y')
    
    data_base.reset_index(
        inplace=True
        )
    data_base['Ingresso'] = ingresso.split('.')[0]
    return data_base

#3 variaveis que possui a chave de comunicação, chamando minha função.
petrobras_dados = carregamento_dados('PBR')
BancoBR_dados = carregamento_dados('BBAS3.SA')
central_eletrica =  carregamento_dados('EBR')

#processo para descobrir se realmente minha base de dados foi preenchida
petrobras_dados.head(5)
BancoBR_dados.head(5)
central_eletrica.head(5)
#aqui eu faço outra base dados na qual eu passo o metodo concat para juntar as minhas 3 bases de dados
tabela_consolidada = pd.DataFrame()
tabela_consolidada = pd.concat(
    [petrobras_dados,BancoBR_dados,central_eletrica]
    )

#pegando a informação da minha base de dados nova, os tipo de cada columa e se há numeros vazios(NA)
tabela_consolidada.info()
tabela_consolidada.select_dtypes([float,int]).\
    describe().transpose()
tabela_consolidada.isnull().sum()

#laço de repetição aonde é resposavel por transformar meus dados que eu queira em tipo inteiro
for coluna in ['Volume','Dividends','Stock Splits']:
    tabela_consolidada[coluna] = \
        tabela_consolidada[coluna].\
            astype('int64')
#print para saber quantas lunhas e colunas o dataframe possui
print(f'Existem {tabela_consolidada.shape[0]} linhas e \
{tabela_consolidada.shape[1]} coluna')

#renomeando tabelas.
tabela_consolidada = tabela_consolidada.rename(
    columns={'Open':'Abrir','High':'Alto',
             'Low':'Baixo','Close':'Fechado',
             'Dividends':'Dividendo','Stock Splits':'Ações'
             }
                                               )
#enfim  a parte a final, salvando meu dataframe em csv.
tabela_consolidada.head(5)
tabela_consolidada.to_csv('financia.csv',index=False)






