FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    jq \
    curl \
    python3 \
    python3-pip \
    git

RUN pip3 install colorama
RUN pip3 install treehue

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
