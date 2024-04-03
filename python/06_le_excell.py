import pandas as pd
from datetime import datetime

def combinar_listas(*l):
    pass  # Pass é uma instrução que não faz nada, usada temporariamente


def le_planilha():
    
    #nome_da_planilha = 'services'  # Nome da planilha que você deseja ler
    #nome_da_planilha = 'locomotives' # nomes 
    caminho_do_arquivo_excel = 'ds_27_plans.xlsx'  
    nome_da_planilha = 'locomotive_classes' # nomes 
    #coluna_para_convert = 'startDatetime'  # Nome da coluna que você deseja converter em matriz
    #coluna_para_convert = 'endDatetime' 
    #coluna_para_convert = 'startLocation'
    col_1_convert = 'locomotiveClass'
    col_2_convert = 'serviceClass'
    col_3_convert = 'doubleHeadingClass'
    col_4_convert = 'doubleHeadingServiceClass'
    #coluna_para_convert = 'id' 
    # Carregar o arquivo Excel em um DataFrame do pandas
    dados_excel = pd.read_excel(caminho_do_arquivo_excel, sheet_name=nome_da_planilha)

    # Extrair os dados da coluna desejada e convertê-los em uma matriz
    aux_1 = dados_excel[col_1_convert].values
    aux_2 = dados_excel[col_2_convert].values
    aux_3 = dados_excel[col_3_convert].values
    aux_4 = dados_excel[col_4_convert].values
  
    #converte para string
    l1 = list(map(str, aux_1))
    l2 = list(map(str, aux_2))
    l3 = list(map(str, aux_3))
    l4 = list(map(str, aux_4))
    # Usando map() com str.lower para converter todas as strings para minúsculas
    #lista_minuscula = list(map(str.lower, lista))
    #print(list(map(str.lower,l1)))
    l1_m = list(map(str.lower, l1))
    l2_m = list(map(str.lower, l2))
    l3_m = list(map(str.lower, l3))
    l4_m = list(map(str.lower, l4))
    
    matriz = combinar_listas(l1_m,l2_m,l3_m,l4_m)

 
    # Imprimir a matriz resultante
    #print("Tamanho da Matriz:", len(matriz))
    print(col_1_convert, col_2_convert, col_3_convert, col_4_convert)
    print(matriz)


def combinar_listas(*listas):
    # Verifica se todas as listas têm o mesmo tamanho
    tamanho = len(listas[0])
    if not all(len(lista) == tamanho for lista in listas):
        return "Todas as listas devem ter o mesmo tamanho."
    # Combina as listas em uma lista de tuplas usando a função zip()
    lista_combinada = list(zip(*listas))
    
    return lista_combinada

if __name__ == "__main__":
    le_planilha()
