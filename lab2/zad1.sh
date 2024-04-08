#!/bin/bash -eu

FIRST=$(realpath ${1:-testFolder1} 2>/dev/null)
SECOND=$(realpath ${2:-testFolder2} 2>/dev/null)

#uwaga1

if [[ ! -e "${FIRST}" ]]; then
  echo "błędny 1 param"
  exit 1
fi

if [[ ! -e "${SECOND}" ]]; then
  echo "błędny 2 param"
  exit 1
fi


THINGS=$(ls "$FIRST")

for ELEMENT in ${THINGS}
do
  
  TYPE=${ELEMENT#*.}
  FILENAME=${ELEMENT%.*}

  if [[ -d "${FIRST}/${ELEMENT}" ]]
  then
    echo "${ELEMENT} jest katalogiem"
    ln -s "$(realpath ${ELEMENT})" "${SECOND}/${FILENAME^^}_ln.${TYPE}"
  fi
  if [[ -f "${FIRST}/${ELEMENT}" ]]; then
    if [[ -h "${FIRST}/${ELEMENT}" ]]; then
    echo "${ELEMENT} jest dowiązaniem symbolicznym"
    ln -s "$(realpath ${ELEMENT})" "${SECOND}/${FILENAME^^}_ln.${TYPE}"
    else
    echo "${ELEMENT} jest plikiem"
    ln -s "$(realpath ${ELEMENT})" "${SECOND}/${FILENAME^^}_ln.${TYPE}"
    fi
  fi
  
done
