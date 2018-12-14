#!/bin/bash

TAMAGOTCHI_DIRECTORY=`dirname $0`
SCRIPT_DIRECTORY="$TAMAGOTCHI_DIRECTORY/scripts"
DATA_DIRECTORY="$TAMAGOTCHI_DIRECTORY/data"

# Récupération des fonctions utiles et communes aux autres scripts
source "$TAMAGOTCHI_DIRECTORY/functions/common.sh"

# Vérrification des arguments du script
for ARGUMENT in $*
do
    # Affichage de l'aide
    if [ "$ARGUMENT" = '--help' ]
    then
        cat "$PWD/templates/help.txt"
        exit
    # Réinitialisation du tamagotchi
    elif [ "$ARGUMENT" = '--reset' ]
    then
        $SCRIPT_DIRECTORY/reset.sh
        exit $?
    # Option ou argument non pris en compte
    else
        echo_error "L'argument $ARGUMENT n'est pas pris en compte."
        exit 42
    fi
done

# Si le tamagotchi n'est pas initialisé
if [ ! -s $DATA_DIRECTORY/name ]
then
    $SCRIPT_DIRECTORY/init.sh
fi

clear

# Affichage du tamagotchi
$SCRIPT_DIRECTORY/display.sh

# Interraction avec le tamagotchi
$SCRIPT_DIRECTORY/interact.sh
