FROM python:3.7

LABEL repository="https://github.com/UnicornGlobal/trufflehog-actions-scan"
LABEL homepage="https://github.com/actions"

RUN pip install gitdb2==3.0.0 truffleHog==2.1.11
RUN apk --update add git less openssh && \
  rm -rf /var/lib/apt/lists/* && \
  rm /var/cache/apk/*

ADD entrypoint.sh  /entrypoint.sh
ADD regexes.json /regexes.json

ENTRYPOINT ["/entrypoint.sh"]
