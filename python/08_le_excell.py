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

    # Converter apenas as strings para minúsculo
    l_3 = [(item.lower() if isinstance(item, str) else item) for tupla in l for item in tupla]

    # Reagrupar em tuplas de 3 elementos
    l_final = [tuple(l_3[i:i+3]) for i in range(0, len(l_3), 3)]
    # Aplicar a função lower() em toda a lista
    #lista_lower = [tuple(map(str.lower, tupla)) for tupla in l]
    #l_f = [ map(lambda x: x.lower() if isinstance(x, str) else x, l)]    

    return l_final

if __name__ == "__main__":
	# Exemplo de uso
	
    caminho_arquivo = 'ds_27_plans.xlsx'
    nome_da_planilha = 'service_class_equivalences' 
    # Carregar o arquivo Excel

    lista_de_tuplas = ler_planilha(caminho_arquivo , nome_da_planilha)
    print(lista_de_tuplas)
