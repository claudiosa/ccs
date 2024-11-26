#!/bin/bash

# Defina os diretórios de origem e destino
DIR_A="/home/ccs/Downloads/viagem_2024"
DIR_B="/home/ccs/my_main/TERA/espanha_franca_2024"

# Verifica se os diretórios existem
if [ ! -d "$DIR_A" ]; then
    echo "Diretório A não existe: $DIR_A"
    exit 1
fi

if [ ! -d "$DIR_B" ]; then
    echo "Diretório B não existe: $DIR_B"
    exit 1
fi

# Copiar arquivos do diretório A para B sem duplicações
for file in "$DIR_A"/*; do
    # Verifica se o arquivo já existe no diretório B
    if [ ! -e "$DIR_B/$(basename "$file")" ]; then
        cp "$file" "$DIR_B"
        echo "Copiado: $(basename "$file")"
    else
        echo "Arquivo já existe: $(basename "$file")"
    fi
done

echo "Cópia concluída!"
