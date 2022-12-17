FROM python:3.9-bullseye
RUN apt update
RUN apt install docker.io default-jre git -y
RUN cd home && git clone https://github.com/QueueInc/HAMLET-FGCS2022.git
RUN cd /home/HAMLET && \
    git checkout develop/comparison && \
    tr -d 'r' < ./scripts/run_hamlet.sh > ./scripts/run_hamlet.sh && \
    tr -d 'r' < ./scripts/run_comparison.sh > ./scripts/run_comparison.sh && \
    chmod 777 scripts/*
WORKDIR /home/HAMLET
RUN chmod 777 scripts/*
CMD ["./scripts/run_experiments.sh"]
