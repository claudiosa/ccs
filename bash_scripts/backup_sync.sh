#!/bin/bash
rsync   -avzrul   --delete Dropbox/ /media/ccs/hd_externo/Dropbox/
rsync   -avzrul   --delete principal/ /media/ccs/hd_externo/principal/
# ANOTHER EXAMPLE
# rsync -avru --ignore-existing /media/ccs/FAT32/todas_fotos/* /media/ccs/19B6-A4561/todas_fotos/
# add --progress
echo "Tudo sincronizado !!!"
