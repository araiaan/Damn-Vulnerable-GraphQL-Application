FROM python:3.7-alpine

LABEL description="Damn Vulnerable GraphQL Application"
LABEL github="https://github.com/dolevf/Damn-Vulnerable-GraphQL-Application"
LABEL maintainer="dolev@lethalbit.com"

ARG TARGET_FOLDER=/opt/dvga

RUN apk add --update curl

ADD core /opt/dvga/core
ADD db /opt/dvga/db
ADD static /opt/dvga/static
ADD templates /opt/dvga/templates

COPY app.py /opt/dvga
COPY config.py /opt/dvga
COPY requirements.txt /opt/dvga/
COPY setup.py /opt/dvga/
COPY version.py /opt/dvga/

WORKDIR $TARGET_FOLDER/

RUN pip install -r requirements.txt
RUN python setup.py

EXPOSE 5000/tcp
CMD ["python3", "app.py"]