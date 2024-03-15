#!/bin/bash

set +x

SOURCE_DIR=${1:-lab_uno}
RM_LIST=${2:-2remove}
TARGET_DIR=${3:-bakap}

rm -rf ${TARGET_DIR}
mkdir ${TARGET_DIR}
#chmod 777 ${TARGET_DIR}


TRASH=$(cat "${SOURCE_DIR}/${RM_LIST}")
#echo $TRASH

# usuwanie plikow
for element in ${TRASH}
do
	# echo "${SOURCE_DIR}/${element}"
  if [[ -e "${SOURCE_DIR}/${element}" ]] #na razie usuwa wszystko -> pliki foldery, jeśli tylko pliki to -f 
  then
    rm -rf "${SOURCE_DIR}/${element}"
  fi
done
# archiwzacja 

ARCHIVE=$(ls ${SOURCE_DIR})
echo $ARCHIVE

for VAR in ${ARCHIVE}
do
	# echo "${SOURCE_DIR}/${element}"
  if [[ -d "${SOURCE_DIR}/${VAR}" ]] 
  then
    cp -r "${SOURCE_DIR}/${VAR}" "${TARGET_DIR}/${VAR}"
  else
    if [[ -f "${SOURCE_DIR}/${VAR}" ]]
    then 
      mv "${SOURCE_DIR}/${VAR}" "${TARGET_DIR}/${VAR}"
    fi
  fi
done
