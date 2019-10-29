# OpenOffice4
OpenOffice 3 server mode

## Run the container
> docker run -d --name=openoffice -p 8100:8100 bdhhbdhh/openoffice3

## More fonts
> docker run -d --name=openoffice -p 8100:8100 -v /myfonts:/usr/share/fonts/myfonts:ro bdhhbdhh/openoffice3
