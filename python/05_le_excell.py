import pandas as pd
from datetime import datetime

def converter_para_valor_absoluto(data_horario_str):
    # Converter a string para um objeto datetime
    data_horario = datetime.strptime(data_horario_str, '%Y-%m-%dT%H:%M:%SZ')
    
     # Converter o objeto datetime para um valor absoluto do tipo inteiro
    valor_absoluto = int(data_horario.timestamp())
        
    return valor_absoluto

def ler_planilha(caminho_arquivo):
    # Carregar a planilha Excel em um DataFrame do pandas
    df = pd.read_excel(caminho_arquivo)
    
    # Garantir que todas as células alfa-numéricas estejam em minúsculo
    df = df.applymap(lambda x: x.lower() if isinstance(x, str) else x)
    
    # Pegar as primeiras 5 colunas e as próximas 100 linhas
    df = df.iloc[:100, :5]
    
    # Converter as datas e horários nas colunas 3 e 5 para valores absolutos
    df.iloc[:, 2] = df.iloc[:, 2].apply(converter_para_valor_absoluto)
    df.iloc[:, 4] = df.iloc[:, 4].apply(converter_para_valor_absoluto)
    
    # Converter as linhas do DataFrame em uma lista de tuplas
    lista_de_tuplas = [tuple(row) for row in df.values]
    
    return lista_de_tuplas

# Exemplo de uso
caminho_arquivo = 'ds_locomotive_plan.xlsx'
lista_de_tuplas = ler_planilha(caminho_arquivo)
print(lista_de_tuplas)