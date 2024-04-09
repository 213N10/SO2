#!/bin/bash -eu
#touch file1.bak file2.bak file3.bak f4.txt f5.txt f6.txt 
#mkdir f1.bak f2.bak f3.bak f4.tmp f5.tmp f6.tmp 


FIRST=$(realpath ${1:-test2} 2>/dev/null)

if [[ ! -e "${FIRST}" ]]; then
  echo "błędny 1 param"
  exit 1
fi

INSIDES=$(ls ${FIRST})
#set -x

for ELEMENT in ${INSIDES}; do

  TYPE=${ELEMENT#*.}
  FILENAME=${ELEMENT%.*}

  if [[ -d "${FIRST}/${ELEMENT}" ]]; then
    if [[ ${TYPE} == "bak" ]]; then
      chmod 001 "${FIRST}/${ELEMENT}"
    fi

    if [[ -z ${TYPE} ]]; then
      continue  # Ignorujemy pliki bez rozszerzenia
    fi

    if [[ ${TYPE} == "tmp" ]]; then
      chmod 711 "${FIRST}/${ELEMENT}"
    fi
  fi
  if [[ -f ${FIRST}/${ELEMENT} ]]; then
    if [[ ${TYPE} == "bak" ]]; then
      chmod uo-w "${FIRST}/${ELEMENT}"
    fi

    if [[ -z ${TYPE} ]]; then
      continue  # Ignorujemy pliki bez rozszerzenia
    fi

    if [[ ${TYPE} == "txt" ]]; then
      chmod 531 "${FIRST}/${ELEMENT}"
    fi

    if [[ ${TYPE} == "exe" ]]; then
      chmod a+x "${FIRST}/${ELEMENT}"
      chmod u+s "${FIRST}/${ELEMENT}"
    fi
  fi

done