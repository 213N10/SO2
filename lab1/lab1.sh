#!/bin/bash

#set -x

SOURCE_DIR=${1:-lab_uno}
RM_LIST=${2:-2remove}
TARGET_DIR=${3:-bakap}

rm -rf ${TARGET_DIR}
mkdir ${TARGET_DIR}
#chmod 777 ${TARGET_DIR}


TRASH=$(cat "${SOURCE_DIR}/${RM_LIST}")
#echo $TRASH

# deleting files
for ELEMENT in ${TRASH}
do
	# echo "${SOURCE_DIR}/${ELEMENT}"
  #to delete ONLY files its necessery to change flag to: '-f'
  #as of right now it deletes folders/directories
  if [[ -e "${SOURCE_DIR}/${ELEMENT}" ]]  
  then
    rm -rf "${SOURCE_DIR}/${ELEMENT}"
  fi
done
# archiving 

ARCHIVE=$(ls ${SOURCE_DIR})
#echo $ARCHIVE

for VAR in ${ARCHIVE}
do
	# echo "${SOURCE_DIR}/${ELEMENT}"
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
# checking nonarchiveable leftovers 
LEFTOVERS=$(ls -l ${SOURCE_DIR} | wc -l)
LEFTOVERS=$((LEFTOVERS-1))
echo $LEFTOVERS

if [[ $LEFTOVERS -gt 0 ]]; then
  echo "jeszcze coś zostało"
  #conajmniej 2 pliki
  if [[ $LEFTOVERS -ge 2 ]]; then 
    echo "zostały conajmniej 2 pliki"
    if [[ $LEFTOVERS -gt 4 ]]; then
      echo "zostało więcej niż 4 pliki"
    fi
  fi
else 
  echo "tu był kononowicz"
fi

DATE=$(date +%Y-%m-%d)
zip -r "${TARGET_DIR}_${DATE}.zip" "${TARGET_DIR}"
echo "zarchiwizowano"
