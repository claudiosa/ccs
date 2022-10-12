#!/bin/bash
#youtube-dl -j --flat-playlist "https://www.youtube.com/channel/UC05MaWI518Cm98A86-hcOEQ/" | jq -r '.id' | sed 's_^_https://youtu.be/_' > urls_site_youtube.txt
youtube-dl -i -v --flat-playlist --skip-download https://www.youtube.com/channel/UC05MaWI518Cm98A86-hcOEQ/videos & list=saida.txt
echo "DONE"
###--get-filename