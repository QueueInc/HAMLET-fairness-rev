FROM python:3.9-bullseye
RUN apt update
RUN apt install docker.io default-jre git -y
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip && \
    pip install black && \
    pip install --no-cache-dir --upgrade -r /requirements.txt && \
    pip install requests && \
    pip install tabulate && \
    pip install future && \
    pip uninstall h2o && \
    pip install -f http://h2o-release.s3.amazonaws.com/h2o/latest_stable_Py.html h2o && \
    rm requirements.txt
RUN cd home && mkdir HAMLET-fairness
WORKDIR /home/HAMLET-fairness
RUN mkdir results
COPY resources resources
COPY automl automl
COPY scripts scripts
RUN chmod 777 scripts/*
ENTRYPOINT ["./scripts/run_experiments.sh"]
