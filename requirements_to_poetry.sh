#!/bin/bash
export MSYS_NO_PATHCONV=1
REQUIREMENTS_FILE="requirements.txt"

if [ ! -f "$REQUIREMENTS_FILE" ]; then
  echo "Arquivo $REQUIREMENTS_FILE não encontrado."
  exit 1
fi

while IFS= read -r line || [ -n "$line" ]; do
  if [[ "$line" =~ ^\s*# ]] || [[ -z "$line" ]]; then
    continue
  fi

  echo "Adicionando dependência: $line"
  poetry add "$line"

  if [ $? -ne 0 ]; then
    echo "Erro ao adicionar a dependência: $line"
    exit 1
  fi
done < "$REQUIREMENTS_FILE"

echo "Migração concluída com sucesso!"
