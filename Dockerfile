FROM python:3.9-bullseye
RUN apt update
RUN apt install docker.io default-jre git -y
RUN pip install --upgrade pip && pip install openml tqdm pandas matplotlib auto-sklearn paretoset
RUN cd home && mkdir HAMLET-FGCS2022
WORKDIR /home/HAMLET-FGCS2022
RUN mkdir results
COPY resources resources
COPY automl automl
COPY scripts scripts
RUN chmod 777 scripts/*
ENTRYPOINT ["./scripts/run_experiments.sh"]
