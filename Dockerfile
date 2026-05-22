FROM ghcr.io/msd-live/jupyter/python-notebook:latest as builder

# install notebook dependencies
COPY notebooks/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# copy notebooks and bundled inputs
COPY notebooks /home/jovyan/notebooks
COPY inputs /home/jovyan/inputs
COPY outputs /home/jovyan/outputs