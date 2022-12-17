FROM python:3.9-bullseye
RUN apt update
RUN apt install docker.io default-jre git -y
RUN cd home && git clone https://github.com/QueueInc/HAMLET-FGCS2022.git
RUN cd /home/HAMLET && \
    chmod 777 scripts/*
WORKDIR /home/HAMLET
RUN chmod 777 scripts/*
CMD ["./scripts/run_experiments.sh"]
