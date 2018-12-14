#!/bin/bash
TAMAGOTCHI_DIRECTORY=`dirname $0`/..
DATA_DIRECTORY="$TAMAGOTCHI_DIRECTORY/data"

# Création du dossier data
mkdir $DATA_DIRECTORY

# On efface l'écran
clear

# Nom du tamagotchi
while [ -z $TAMAGOTCHI_NAME ] # tant que la chaine $TAMAGOTCHI_NAME est vide
do
    read -p "Quel est le nom de votre tamagotchi ? " TAMAGOTCHI_NAME
done

# Sauvegarde du nom dans un fichier ./data/name
echo -n $TAMAGOTCHI_NAME > $DATA_DIRECTORY/name

# Statistiques de départ
echo -n '0' > $DATA_DIRECTORY/current_age
echo -n '0' > $DATA_DIRECTORY/current_disease
echo -n '0' > $DATA_DIRECTORY/current_poop
echo -n $(($RANDOM % 4)) > $DATA_DIRECTORY/current_hunger # entre 0 et 3 sur 5
echo -n $((1 + $RANDOM % 3)) > $DATA_DIRECTORY/current_sad # entre 1 et 3 sur 5

# Statistiques max
echo -n $((10 + $RANDOM % 11)) > $DATA_DIRECTORY/max_age # entre 10 et 20
echo -n '5' > $DATA_DIRECTORY/max_disease
echo -n '5' > $DATA_DIRECTORY/max_poop
echo -n '5' > $DATA_DIRECTORY/max_hunger
echo -n '5' > $DATA_DIRECTORY/max_sad