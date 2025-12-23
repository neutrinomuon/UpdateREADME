FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y \
        jq \
        curl \
        git \
        python3 \
        python3-pip \
        ca-certificates

RUN python3 -m pip install --upgrade pip
RUN pip3 install --no-cache-dir colorama treehue
RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
