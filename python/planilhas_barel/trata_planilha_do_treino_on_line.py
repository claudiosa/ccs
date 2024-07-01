import pandas as pd

# Função para ler e limpar a planilha
def ler_e_limpar_planilha(arquivo_ods):
    # Ler a planilha .ods
    planilha = pd.read_excel(arquivo_ods, engine='odf', header=None)
    
    # Remover linhas em branco (considerando qualquer coluna)
    planilha_limpa = planilha.dropna(how='all')

    return planilha_limpa

# Função para filtrar tempos superiores a 55 segundos
def filtrar_tempos_superiores_a_55_segundos(planilha_limpa):
    # Converter a coluna 0 (assumindo que é a primeira coluna) para string
    planilha_limpa[0] = planilha_limpa[0].astype(str)
    
    # Filtrar linhas com tempos superiores a "00:00:55"
    planilha_filtrada = planilha_limpa[planilha_limpa[0] > "00:00:55"]

    return planilha_filtrada

# Função para remover o campo de horas e manter apenas MM:SS
def remover_campo_de_horas(planilha_filtrada):
    def formatar_tempo(tempo):
        # Assumir que o tempo está no formato HH:MM:SS e retornar MM:SS
        partes = tempo.split(':')
        return f"{partes[0]}:{partes[1]}"
    
    # Criar uma cópia da planilha filtrada para evitar SettingWithCopyWarning
    planilha_copia = planilha_filtrada.copy()
    
    # Aplicar a função na cópia
    planilha_copia[0] = planilha_copia[0].apply(formatar_tempo)
    
    return planilha_copia

# Caminho para o arquivo .ods
arquivo_ods = 'sua_planilha.ods'

# Ler e limpar a planilha
planilha_limpa = ler_e_limpar_planilha(arquivo_ods)

# Filtrar a planilha com tempos superiores a 55 segundos
planilha_filtrada = filtrar_tempos_superiores_a_55_segundos(planilha_limpa)

# Remover o campo de horas
planilha_formatada = remover_campo_de_horas(planilha_filtrada)

# Transpor a planilha formatada
planilha_transposta = planilha_formatada.transpose()

# Exibir a planilha transposta
print(planilha_transposta)

# Salvar a planilha transposta em um novo arquivo .xlsx
planilha_transposta.to_excel('planilha_transposta.xlsx', index=False, header=False)
