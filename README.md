```
mkdir HAMLET-FGCS2022
cd HAMLET-FGCS2022
sudo docker run --name hamlet-fgcs2022 --volume /var/run/docker.sock:/var/run/docker.sock --volume $(pwd)/results:/home/HAMLET-FGCS2022/results ghcr.io/queueinc/hamlet-fgcs2022:0.1.3

docker build -t hamlet-experiments .
docker run --volume /var/run/docker.sock:/var/run/docker.sock hamlet-experiments
```