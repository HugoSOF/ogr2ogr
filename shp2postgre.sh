#!/bin/bash

# Rendre exécutable le fichier : chmod +x import_data.sh
# Lancer le fichier en manuel : ./shp2postgre.sh > /home/support/shp2postgre.log 2>&1

clear
echo "on"

# Met à jour les variables d'environnements 

source "./setenv.sh"

# Vérification basique de la présence d'au moins du premier shapefile : 
if [ ! -e "$DATA_DIRECTORY/SHAPE1.shp" ]; then
    echo "ERROR : Vous rencontrez cette erreur car des fichiers shapefile ne sont pas présent"
else
# shp2postgre.sh 
$OGR2OGR --version
echo "INFO : Script : shp2postgre en cours de traitement ... "

 $OGRINFO PG:"$PG_SRC" -sql "delete from \"TABLE1\""
 $OGR2OGR -nlt PROMOTE_TO_MULTI -nln "TABLE1" -lco FID=geo_fid -lco GEOMETRY_NAME=geom -lco LAUNDER=NO -progress -lco SCHEMA=$PGSCHEMA -f "PostgreSQL" PG:"$PG_SRC" "$DATA_DIRECTORY/SHAPE1.shp"
 $OGRINFO PG:"$PG_SRC" -sql "select count(*) from \"TABLE1\""
 
 $OGRINFO PG:"$PG_SRC" -sql "delete from \"TABLE2\""
 $OGR2OGR -nlt PROMOTE_TO_MULTI -nln "TABLE1" -lco FID=geo_fid -lco GEOMETRY_NAME=geom -lco LAUNDER=NO -progress -lco SCHEMA=$PGSCHEMA -f "PostgreSQL" PG:"$PG_SRC" "$DATA_DIRECTORY/SHAPE2.shp"
 $OGRINFO PG:"$PG_SRC" -sql "select count(*) from \"TABLE2\""
 

# shp2postgre2.sh 

$OGR2OGR --version
echo "INFO : Script : shp2postgre2 en cours de traitement ... "

$OGRINFO PG:"$PG_SRC" -sql "delete from \"TABLE3\""
$OGR2OGR -nlt PROMOTE_TO_MULTI -nln "TABLE3" -lco FID=geo_fid -lco GEOMETRY_NAME=geom -lco LAUNDER=NO -progress -lco SCHEMA=$PGSCHEMA -f "PostgreSQL" PG:"$PG_SRC" "$DATA_DIRECTORY/SHAPE3.shp"
$OGRINFO PG:"$PG_SRC" -sql "select count(*) from \"TABLE3\""

# shp2postgre4(cable_bt).sh

$OGR2OGR --version
echo "INFO : Script : shp2postgre3 en cours de traitement ... "

#$OGRINFO PG:"$PG_SRC" -sql "delete from \"TABLEN\""
#$OGR2OGR -nlt PROMOTE_TO_MULTI -nln "TABLEN" -lco FID=geo_fid -lco GEOMETRY_NAME=geom -lco LAUNDER=NO -progress -lco SCHEMA=$PGSCHEMA -f "PostgreSQL" PG:"$PG_SRC" "$DATA_DIRECTORY/SHAPEN.shp"
#$OGRINFO PG:"$PG_SRC" -sql "select count(*) from \"TABLEN\""

echo "INFO : Script devenu obsolète, le traitement continue"
fi
echo "INFO : Traitement terminé"