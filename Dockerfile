# Image: python:slim-bullseye
# https://hub.docker.com/layers/library/python/slim-bullseye/images/sha256-e237eda636e9af691f797afc6c3174edddfeb5449103841910755d394ada35e0?context=explore
FROM python@sha256:e237eda636e9af691f797afc6c3174edddfeb5449103841910755d394ada35e0
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install gcc mono-mcs g++ && \
    rm -rf /var/lib/apt/lists/*
ENV SERVERDIR=/server
WORKDIR ${SERVERDIR}
RUN pip install python-mimeparse==1.6.0 &&\
    pip install bottle==0.12.25 && \
    pip install paste==3.5.0
COPY . ${SERVERDIR}

RUN cd pysubnettree && python setup.py install && cd ..

# Install SubnetTree
ENV PATH_TO_ALTO_SERVER=${SERVERDIR}/palto/
ENV PATH_TO_BACKENDS=${SERVERDIR}/backends/paltosf
ENV PATH=$PATH_TO_ALTO_SERVER:$PATH_TO_BACKENDS:$PATH_TO_PLUGINS:$PATH

ENTRYPOINT ["python", "-m", "palto.server", "-c", "examples/palto.conf"]
# python -m palto.server -c examples/palto.conf