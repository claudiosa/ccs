import pandas as pd
from datetime import datetime



def converter_para_valor_absoluto(data_horario_str):
    # Converter a string para um objeto datetime
    data_horario = datetime.strptime(data_horario_str, '%Y-%m-%dT%H:%M:%SZ')
    
    # Converter o objeto datetime para um valor absoluto
    valor_absoluto = data_horario.timestamp()
    
    return valor_absoluto



# Ler a planilha do Excel
caminho_do_arquivo_excel = 'ds_locomotive_plan.xlsx'   #'caminho/para/o/arquivo.xlsx'
nome_da_planilha = 'services'  # Nome da planilha que você deseja ler
#coluna_para_convert = 'startDatetime'  # Nome da coluna que você deseja converter em matriz
#coluna_para_convert = 'endDatetime' 
#coluna_para_convert = 'endLocation'
coluna_para_convert = 'id'

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


