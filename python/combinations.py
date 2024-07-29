import itertools

# Definição do mapeamento de números
mapping = {
    1: 1, 10: 1, 19: 1, 28: 1, 37: 1,
    2: 2, 11: 2, 20: 2, 29: 2,
    3: 3, 12: 3, 21: 3, 30: 3,
    4: 4, 13: 4, 22: 4, 31: 4,
    5: 5, 14: 5, 23: 5, 32: 5,
    6: 6, 15: 6, 24: 6, 33: 6,
    7: 7, 16: 7, 25: 7, 34: 7,
    8: 8, 17: 8, 26: 8, 35: 8,
    9: 9, 18: 9, 27: 9, 36: 9
}

def map_combination(combination):
    return [mapping[number] for number in combination]

def process_combinations(input_file, output_file):
    # Ler todas as combinações do arquivo
    with open(input_file, 'r') as file:
        combinations = [list(map(int, line.strip().split())) for line in file]

    # Mapear as combinações e reorganizá-las em ordem decrescente
    mapped_combinations = [sorted(map_combination(comb), reverse=True) for comb in combinations]

    # Remover combinações duplicadas
    unique_combinations = list(map(list, set(map(tuple, mapped_combinations))))

    # Escrever as combinações finais no arquivo de saída
    with open(output_file, 'w') as file:
        for comb in unique_combinations:
            file.write(' '.join(map(str, comb)) + '\n')

if __name__ == "__main__":
    input_file = 'combinations.txt'
    output_file = 'final_combinations.txt'
    process_combinations(input_file, output_file)
