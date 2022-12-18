```
mkdir HAMLET-FGCS2022
cd HAMLET-FGCS2022
docker build -t hamlet-experiments .
docker run -it --volume /var/run/docker.sock:/var/run/docker.sock --volume $(pwd):$(pwd) ghcr.io/queueinc/hamlet-fgcs2022:0.2.0 $(pwd)
```