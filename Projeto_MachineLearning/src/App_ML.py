import pandas as pd
import joblib
import streamlit as st

# Carrengando o modelo treinado
@st.cache_resource
def load_model():
    try:       
        return joblib.load("modelo_treinado.pkl")
        
    except Exception as e:
        st.error(f"Erro ao carregar o modelo: {e}")
    
modelo = load_model()


# Função de predição
def prever_obesidade(dados_usuario):
    df_usuario = pd.DataFrame([dados_usuario])
    print(df_usuario)
    pred = modelo.predict(df_usuario)
    if pred[0] == 0:
        return "Não obeso"
    else:
        return "Obeso"

# Interface Streamlit
st.title("🔮 Previsão de Obesidade com ML")
st.write(" Olá, seja bem-vindo(a) ao meu projeto de predição de obesidade com Machine Learning🧪") 


# Inputs para o usuario
genero = st.selectbox("Gênero (0 = Feminino, 1= Masculino)", [0, 1])  # ou ["Feminino", "Masculino"] se tiver transformado
idade = st.slider("Idade", 10, 100, 25)
history = st.selectbox("Histórico familiar de sobrepeso? (0 = Não, 1 = Sim)", [0, 1])
favc = st.selectbox("FAVC (Alto consumo de caloria?) (0 = Não, 1 = Sim)", [0, 1])
fcvc = st.slider("Frequência consumo de vegetais (1- Raramente, 2- Às vezes, 3- Sempre)", 1.0, 3.0, 2.0)
ncp = st.slider("NCP (Número de refeições)", 1.0, 4.0, 2.0)
caec = st.selectbox("CAEC (Quantidade de comida ingerida entre refeições)", [0, 1, 2, 3])
smoke = st.selectbox("Fuma? (0 = Não, 1 = Sim)", [0, 1])
ch2o = st.slider("Consumo de água diário", 1.0, 3.0, 2.0)
scc = st.selectbox("Monitora consumo calórico? (0 = Não, 1 = sim)", [0, 1])
faf = st.slider("Atividade física (horas)", 0.0, 3.0, 1.0)
tue = st.slider("Uso de tecnologia (horas)", 0.0, 2.0, 1.0)
calc = st.selectbox("Consumo de álcool", [0, 1, 2, 3])
automobile = st.selectbox("Usa carro? (0 = Não, 1= Sim)", [0, 1])
bike = st.selectbox("Usa bicicleta? (0 = Não, 1= Sim)", [0, 1])
motorbike = st.selectbox("Usa moto? (0 = Não, 1= Sim)", [0, 1])
public_transport = st.selectbox("Usa transporte público? (0 = Não, 1= Sim)", [0, 1])
walking = st.selectbox("Caminha? (0 = Não, 1= Sim)", [0, 1])

# Montando um dicionário com os dados do usuário
dados = {
    "Gender": genero,
    "Age": idade,
    "family_history_with_overweight": history,
    "FAVC": favc,
    "FCVC": fcvc,
    "NCP": ncp,
    "CAEC": caec,
    "SMOKE": smoke,
    "CH2O": ch2o,
    "SCC": scc,
    "FAF": faf,
    "TUE": tue,
    "CALC": calc,
    "Automobile": automobile,
    "Bike": bike,
    "Motorbike": motorbike,
    "Public_Transportation": public_transport,
    "Walking": walking
}

# Botão para prever
if st.button("Prever"):
    resultado = prever_obesidade(dados)
    st.success(f"🧠 Resultado do modelo: {resultado}")



