#!/bin/bash
TAMAGOTCHI_DIRECTORY=`dirname $0`/..
SCRIPT_DIRECTORY="$TAMAGOTCHI_DIRECTORY/scripts"
DATA_DIRECTORY="$TAMAGOTCHI_DIRECTORY/data"
source "$TAMAGOTCHI_DIRECTORY/functions/common.sh"

echo Réinitialisation du tamagotchi…
rm -Rf $DATA_DIRECTORY
if [ $? -eq 0 ]
then
    echo OK !
else
    echo_error "Le dossier n'a pas été supprimé."
    exit 42
fi