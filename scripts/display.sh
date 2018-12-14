#!/bin/bash
TAMAGOTCHI_DIRECTORY=`dirname $0`/..
DATA_DIRECTORY="$TAMAGOTCHI_DIRECTORY/data"
TEMPLATE_DIRECTORY="$TAMAGOTCHI_DIRECTORY/templates"

# Permet d'utiliser les fonctions sur l'humeur du tamagotchi
source "$TAMAGOTCHI_DIRECTORY/functions/mood.sh"

function display_stat()
{
    local STAT_NAME=$1
    local STAT_EMOJI=$2

    # remplit la variable CURRENT_VALUE
    get_current_value $STAT_NAME

    echo -n "$STAT_EMOJI "

    # la stat est à 0
    if [ $CURRENT_VALUE -eq 0 ]
    then
        echo  -n ☑️
    fi

    # sinon, on affiche une bulle pour chaque point de la stat
    local INDEX=$CURRENT_VALUE
    while [ $INDEX -gt 0 ]
    do
        echo -n ●
        ((INDEX--))
    done

    # retour à la ligne
    echo
}

# Affichage de l'humeur du tamagotchi
TAMAGOTCHI_NAME=`cat $DATA_DIRECTORY/name`

get_mood_value
get_mood_text $MOOD_VALUE

cat $TEMPLATE_DIRECTORY/mood_$MOOD_VALUE.txt
echo $TAMAGOTCHI_NAME $MOOD_TEXT

# Affichage des statistiques
display_stat sad 😭
display_stat hunger 🍔
display_stat poop 💩
display_stat disease 🤒

# retour à la ligne
echo