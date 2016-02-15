# ┌────────────────────────────────────────────────────────────────────┐
# │ A simple webhook listener                                          │
# │ https://github.com/shofetim/docker-compose-hook                    │
# ├────────────────────────────────────────────────────────────────────┤
# │ Copyright © 2014 Jordan Schatz                                     │
# ├────────────────────────────────────────────────────────────────────┤
# │ Licensed under the MIT License                                     │
# └────────────────────────────────────────────────────────────────────┘

FROM python:alpine

MAINTAINER Jordan Schatz "jordan@noionlabs.com"

# Install docker-compose
RUN pip install --upgrade pip; pip install docker-compose

# Setup SSH
RUN apk add --update openssh \
    && ssh-keygen -f /root/.ssh/id_rsa -n '' \
    && rm -rf /var/cache/apk/*

# Avoid confirmation of SSH hosts
COPY ssh-config /root/.ssh/config

# Add the server to listen for the push notification
WORKDIR /app
COPY hook.py /app/
COPY quotes.txt /app/

EXPOSE 9090

CMD ["python3", "/app/hook.py"]
