docker stop hamlet-fgcs2022
docker rm hamlet-fgcs2022
docker build -t hamlet-fgcs2022 .
docker run --name hamlet_fgcs2022 --volume /var/run/docker.sock:/var/run/docker.sock --volume $(pwd):/home/HAMLET-FGCS2022 hamlet-fgcs2022