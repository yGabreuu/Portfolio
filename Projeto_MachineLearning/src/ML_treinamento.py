import pandas as pd 
import numpy as  np
import joblib
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import  classification_report, confusion_matrix
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler




df_obesidade = pd.read_csv(r'C:\Users\Gabriel\OneDrive\Documentos\Portfolio_1\Projeto_MachineLearning\notebooks\arquivo_obesidade.csv')

df_obesidade['Age'] = df_obesidade['Age'].astype(int)
dados_agrupado = df_obesidade['Age'].sort_values()


media_refeicao = df_obesidade['NCP'].mean()
df_obesidade['NCP'] = df_obesidade['NCP'].replace(4, media_refeicao)

'''passando valores para o modelo de treino e teste, valores_x recebe a minha primeira coluna até a penultima
modelo valores_y recebe a última coluna NObeyesdad a qual iremos usar como classificação.'''
valores_x = df_obesidade.iloc[:,:-1].values
valores_y = df_obesidade.iloc[:, 18].values
print(valores_x.shape)
'''dividindo os dados em treinamente e teste, passando  40% dos meus dados como treinamento'''
valores_x_train , valores_x_teste , valores_y_train , valores_y_teste =  train_test_split(
    valores_x, valores_y, train_size=0.80, random_state=42
    )

'''dicionário com 3 classes para saber qual é o melhor para se usar no meu dataset'''

modelos = {'KNN': KNeighborsClassifier(),
           'RandomForest':RandomForestClassifier(),
           'LogisticRegression':LogisticRegression()}

'''função que recebe os valores_y e valores_x, faz o treinamento do meu dados e retorna a avalição de cada classe'''
def treinar_and_avaliar(modelos, x_train, x_teste,y_train, y_teste):
    avaliação_de_modelo = {}
    for estancia, objeto in modelos.items():
        objeto.fit(x_train, y_train)
        avaliação_de_modelo[estancia] = objeto.score(x_teste, y_teste)
    return avaliação_de_modelo

print(treinar_and_avaliar(modelos=modelos, x_train=valores_x_train, x_teste=valores_x_teste,
                    y_train=valores_y_train, y_teste=valores_y_teste))

'''OBS: Bom antes de passar alguns parametrôs presente neste código, eu tinha rodado ele, mas observei que o meu modelo
estava decorando (overfitting) ao invés de aprender então, refiz o código passando alguns parametros para prevenir overfitting'''

'''com o resultado da avaliação em mãos o modelo que teve a melhor avaliação foi o RandomForest então iremos usa-lo,
a variavel "classificação" ela recebe a classificação do meu modelo randomforest, com um número de estimação(arvore) de 140, max_depth 
para prevenir overfitting forçando cada arvore a tomar decisões generelizada ao invés de decorar, min_samples_split e min_samples_leaf
isso impede a criação de folhas que representem muito poucos dados, o que poderia introduzir ruido nas previsões
'''
escala_1 = StandardScaler()
valores_x_train = escala_1.fit_transform(valores_x_train)
valores_x_teste = escala_1.transform(valores_x_teste)

classificaçao = RandomForestClassifier(n_estimators=100, max_depth=9, min_samples_split=9,
                                min_samples_leaf=3)

'''avaliação do meu modelo'''
scores = cross_val_score(classificaçao, valores_x_train, valores_y_train, cv=5)
print("Validação cruzada: ", scores)
print('Média da validação cruzada', scores.mean())

#parte de treinamento do modelo
classificaçao.fit(valores_x_train, valores_y_train)

'''previsões e avaliando o conjunto de treinamento pra ter uma avalição se meu modelo está decorando ou generalizando'''
y_treinamento_pred = classificaçao.predict(valores_x_train)
matrix_treinamento = confusion_matrix(valores_y_train, y_treinamento_pred)
report_treinamento = classification_report(valores_y_train, y_treinamento_pred)


print(matrix_treinamento)
print('Relatório do meu conjunto de treinamento')
print(report_treinamento)

'''previsões e avaliando o meu conjunto de teste para fazer uma comparação com meu modelo de treinamento'''
y_predict = classificaçao.predict(valores_x_teste)
matrix_teste = confusion_matrix(valores_y_teste, y_predict)
report_teste = classification_report(valores_y_teste, y_predict)

print(matrix_teste)
print('Relatório do meu conjunto de teste')
print(report_teste)

'''Gráfico relatório do meu conjunto de teste'''


joblib.dump(classificaçao , 'modelo_treinado.pkl')

