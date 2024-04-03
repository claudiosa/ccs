import pandas as pd
from datetime import datetime
from openpyxl import load_workbook
# li a planilha Locomotives

def converter_para_valor_absoluto(data_horario_str):
    # Converter a string para um objeto datetime
    #2022-12-31T10:00:00Z
    data_horario = datetime.strptime(data_horario_str, '%Y-%m-%dT%H:%M:%SZ')
    #print(data_horario)
     # Converter o objeto datetime para um valor absoluto do tipo inteiro
    valor_absoluto = int(data_horario.timestamp())
        
    return valor_absoluto

def ler_planilha(caminho_do_arquivo, nome_da_planilha):
    # Carregar a planilha Excel em um DataFrame do pandas
    
    df = pd.read_excel(caminho_do_arquivo, sheet_name=nome_da_planilha)
    #### nao le a primeira linha que não interessa
    # Aplicar a função converter_para_valor_absoluto à última coluna
    #df[3] = df[3].apply(converter_para_valor_absoluto)
    #print(df[0],df[3])
    #df.iloc[:, 3] = df.iloc[:, 3].apply(converter_para_valor_absoluto)
    #df[3] = df[3].apply(converter_para_valor_absoluto)
    # Gerar uma lista de tuplas a partir do DataFrame
    
    l = [tuple(row) for row in df.values]
    #print(l)
    # Aplicar a função converter_para_valor_absoluto ao último elemento de cada tupla

    l_convertido = []
    for tupla in l:
        print(tupla[-1])
        #l_f = tuple(map(lambda x: x.lower() if isinstance(x, str) else x, tupla))    
        y = converter_para_valor_absoluto(tupla[-1])
        l_convertido.append(y)
        
        #l_convertido[:-1] 
        #print( converter_para_valor_absoluto(tupla[-1]))
        #print( type(tupla[-1]))
        #
        #print(x)
    print(l_convertido)
    
    #for i in range(0,len(l)):
    #for tupla in l: 
 
# Substituir o último elemento em cada tupla pela correspondente nova lista de valores
    l_2 = [ tupla[:-1] + (novo_valor,) for tupla, novo_valor in zip(l, l_convertido )]

    # Converter apenas as strings para minúsculo
    l_3 = [(item.lower() if isinstance(item, str) else item) for tupla in l_2 for item in tupla]

    # Reagrupar em tuplas de 4 elementos
    l_final = [tuple(l_3[i:i+4]) for i in range(0, len(l_3), 4)]


    # Aplicar a função lower() em toda a lista
    #lista_lower = [tuple(map(str.lower, tupla)) for tupla in l]
    #l_f = [ map(lambda x: x.lower() if isinstance(x, str) else x, l)]    
    print(l_final)
    return l_final

if __name__ == "__main__":
	# Exemplo de uso
	
    caminho_arquivo = 'ds_27_plans.xlsx'
    nome_da_planilha = 'locomotives' 
    # Carregar o arquivo Excel
    wb = load_workbook(caminho_arquivo)  
    # Substitua 'arquivo.xlsx' pelo nome do seu arquivo Excel
    ws = wb.active
    # Obter o formato de dados da coluna
    coluna = 'locationDatetime'  # Substitua 'A' pelo número ou letra da coluna que você deseja verificar
    formato = ws.column_dimensions[coluna].number_format

    # Imprimir o formato de dados
    print("O formato de dados da coluna {} é: {}".format(coluna, formato))
    lista_de_tuplas = ler_planilha(caminho_arquivo , nome_da_planilha)
    print(lista_de_tuplas)
