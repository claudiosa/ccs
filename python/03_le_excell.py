import pandas as pd
from datetime import datetime



# Ler a planilha do Excel
caminho_do_arquivo_excel = 'ds_27_plans.xlsx'   #'caminho/para/o/arquivo.xlsx'
nome_da_planilha = 'locomotives'  # Nome da planilha que você deseja ler

coluna_para_convert = 'location'
#coluna_para_convert = 'id'

# Carregar o arquivo Excel em um DataFrame do pandas
dados_excel = pd.read_excel(caminho_do_arquivo_excel, sheet_name=nome_da_planilha)

# Extrair os dados da coluna desejada e convertê-los em uma matriz
aux = dados_excel[coluna_para_convert].values

matriz = []
for item in aux:
    valor_absoluto = item.lower()
    matriz.append(valor_absoluto)   


# Imprimir a matriz resultante
print("Tamanho da Matriz:", len(matriz))
print(matriz)


