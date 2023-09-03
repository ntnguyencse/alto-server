# Image: python:slim-bullseye
# https://hub.docker.com/layers/library/python/slim-bullseye/images/sha256-e237eda636e9af691f797afc6c3174edddfeb5449103841910755d394ada35e0?context=explore
FROM python@sha256:e237eda636e9af691f797afc6c3174edddfeb5449103841910755d394ada35e0
ENV SERVERDIR=/server
WORKDIR ${SERVERDIR}
ADD https://raw.githubusercontent.com/bro/pysubnettree/d48a2c5fa92554c52abab6b86030724e52e495ae/setup.py setupPysubnetTree.py
RUN pip install python-mimeparse==1.6.0 &&\
    pip install bottle==0.12.25 &&\
    python setupPysubnetTree.py install
COPY . ${SERVERDIR}
ENV PATH_TO_ALTO_SERVER=${SERVERDIR}/palto/
ENV PATH_TO_BACKENDS=${SERVERDIR}/backends/paltosf
ENV PATH=$PATH_TO_ALTO_SERVER:$PATH_TO_BACKENDS:$PATH_TO_PLUGINS:$PATH

ENTRYPOINT ["python", "-m", "palto.server", "-c", "examples/palto.conf"]
# python -m palto.server -c examples/palto.conf