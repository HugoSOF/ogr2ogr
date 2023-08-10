#!/bin/bash
#Installer Crontab pour planifier votre conversion SHP :
apt-get install cron
# Editer votre CronTab avec l'user sensé lancer les scripts : 
crontab -e
# Ajouter la ligne suivante pour qu'à 18h30 chaque soir le script se lance automatiquement : 
30 18 * * 1-5 /CHEMIN/VERS/VOTRE/SCRIPT/shp2postgre.sh > /CHEMIN/VERS/VOTRE/LOG/shp2postgre.log 2>&1
# A noter : le 2>&1 permet de lister l'ensemble des informations dans vos logs. 
# Le script se lancera tout les jours, c'est pourquoi la condition : 
#   if [ ! -e "$DATA_DIRECTORY/SHAPE1.shp" ]; then
#   echo "ERROR : Vous rencontrez cette erreur car des fichiers shapefile ne sont pas présent"
# Le script vérifie en amont la présence du premier shape pour éviter la surcharge. 