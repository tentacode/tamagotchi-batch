#!/bin/bash
TAMAGOTCHI_DIRECTORY=`dirname $0`/..
DATA_DIRECTORY="$TAMAGOTCHI_DIRECTORY/data"
TAMAGOTCHI_NAME=`cat $DATA_DIRECTORY/name`

# Permet d'utiliser les fonctions sur l'humeur du tamagotchi
source "$TAMAGOTCHI_DIRECTORY/functions/mood.sh"

get_mood_value
echo $MOOD_VALUE | grep death > /dev/null
if [ $? -eq 0 ]
then
    echo $TAMAGOTCHI_NAME est mort. 😇
    echo 'Vous pouvez recréer un nouveau tamagotchi avec "./tamagotchi.sh --reset"'
    exit
fi

echo "[j] Jouer avec $TAMAGOTCHI_NAME"
echo "[n] Nourrir $TAMAGOTCHI_NAME"
echo "[c] Nettoyer le caca de $TAMAGOTCHI_NAME"
echo "[s] Soigner $TAMAGOTCHI_NAME"
echo "[q] Quitter"

# retour à la ligne
echo

read -p "Que voulez-vous faire ? " INTERACTION

case $INTERACTION in
    [Jj])
        clear
        echo Vous jouez avec $TAMAGOTCHI_NAME. 🦋

        get_current_value sad
        SAD_VALUE=$CURRENT_VALUE
        ((SAD_VALUE--))
        set_new_value sad $SAD_VALUE
        
        echo $TAMAGOTCHI_NAME est content. 😊
        echo
        read -p "Appuyer sur une touche pour continuer..."
        ;;
    [Nn])
        clear
        echo Vous nourrissez $TAMAGOTCHI_NAME. 🌭🍟🍰
        
        get_current_value hunger
        HUNGER_VALUE=$CURRENT_VALUE

        if [ $HUNGER_VALUE -le 0 ]
        then
            get_current_value disease
            DISEASE_VALUE=$CURRENT_VALUE
            ((DISEASE_VALUE++))
            set_new_value disease $DISEASE_VALUE

            echo Vous avez trop gavé $TAMAGOTCHI_NAME ! 🤢
        else
            ((HUNGER_VALUE--))
            set_new_value hunger $HUNGER_VALUE

            echo $TAMAGOTCHI_NAME est rassasié ! 😬
        fi
        
        echo
        read -p "Appuyer sur une touche pour continuer..."
        ;;
    [Cc])
        clear
        echo Vous nettoyez $TAMAGOTCHI_NAME. ✨
        
        get_current_value poop
        POOP_VALUE=$CURRENT_VALUE

        if [ $POOP_VALUE -le 0 ]
        then
            get_current_value sad
            SAD_VALUE=$CURRENT_VALUE
            ((SAD_VALUE++))
            set_new_value sad $SAD_VALUE

            echo "$TAMAGOTCHI_NAME était déjà propre, ça l'ennerve. 😤"
        else
            ((POOP_VALUE--))
            set_new_value poop $POOP_VALUE

            echo $TAMAGOTCHI_NAME se sent plus propre ! 😚
        fi
        
        echo
        read -p "Appuyer sur une touche pour continuer..."
        ;;
    [Ss])
        clear
        echo Vous soignez $TAMAGOTCHI_NAME. 🚑
        
        get_current_value disease
        DISEASE_VALUE=$CURRENT_VALUE

        if [ $DISEASE_VALUE -le 0 ]
        then
            set_new_value disease 4
            set_new_value sad 5

            echo "$TAMAGOTCHI_NAME n'était pas malade, il fait une réaction au médicament ! 😱"
        else
            ((DISEASE_VALUE--))
            set_new_value disease $DISEASE_VALUE

            echo $TAMAGOTCHI_NAME se sent mieux ! 🤕
        fi
        
        echo
        read -p "Appuyer sur une touche pour continuer..."
        ;;
    [Qq])
        echo "$TAMAGOTCHI_NAME est triste de vous voir partir ! 👋"
        exit
        ;;
esac

# On relance le tamagotchi pour actualiser le statut
$TAMAGOTCHI_DIRECTORY/tamagotchi.sh