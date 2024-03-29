import pandas as pd

def ler_planilha(caminho_arquivo):
    # Carregar a planilha Excel em um DataFrame do pandas
    df = pd.read_excel(caminho_arquivo)
    
    # Garantir que todas as células alfa-numéricas estejam em minúsculo
    df = df.applymap(lambda x: x.lower() if isinstance(x, str) else x)
    
    # Pegar as primeiras 5 colunas e as próximas 100 linhas
    df = df.iloc[:100, :5]
    
    # Converter as linhas do DataFrame em uma lista de tuplas
    lista_de_tuplas = [tuple(row) for row in df.values]
    
    return lista_de_tuplas

# Exemplo de uso
caminho_arquivo = 'ds_27_plans.xlsx'
lista_de_tuplas = ler_planilha(caminho_arquivo)
print(lista_de_tuplas)