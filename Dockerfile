# Dockerfile
#
# docker build -t marks-thing .

FROM postgres:9.5-alpine

MAINTAINER NHS Digital Delivery Centre, CIS Team. Email: HSCIC.DL-CIS@nhs.net

# Install python 3 basics
RUN apk update && \
    apk add ca-certificates && \
    apk add python3 && \
    apk add python3-dev build-base libffi-dev openssl-dev --update-cache && \
    python3 -m ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -rf /usr/lib/python*/ensurepip && \
    rm -rf /root/.cache && \
    rm -rf /var/cache/apk/*

# Create unprivileged user
RUN adduser -S service

COPY requirements.txt /tmp/requirements.txt

RUN pip3 install -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

ENV PYLINT_VERSION=1.6.4

RUN pip3 install pylint==$PYLINT_VERSION && \
    pip3 install coverage && \
    pip3 install tornado && \
    pip3 install mock && \
    pip3 install python-jose && \
    pip3 install cryptography && \
    pip3 install ldap3 && \
    pip3 install requests && \
    pip3 install jwcrypto  && \
    pip3 install redis && \
    pip3 install pyhcl && \
    pip3 install docker && \
    pip3 install sqlalchemy && \
    pip3 install tqdm && \
    apk update && \
    apk add py-lxml && \
    pip3 install lxml

# Copy in service files
RUN mkdir -p /usr/src/open-ods-api-service/import_tool
COPY import.py /usr/src/open-ods-api-service/import.py
USER service
CMD ["python3", "-u", "/usr/src/open-ods-api-service/import.py"]
