FROM python:3.9-bullseye
RUN apt update
RUN apt install docker.io default-jre git -y
RUN cd home && git clone https://github.com/QueueInc/HAMLET-FGCS2022.git
WORKDIR /home/HAMLET-FGCS2022
RUN chmod 777 scripts/*
CMD ["./scripts/run_experiments.sh"]
