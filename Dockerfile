# ┌────────────────────────────────────────────────────────────────────┐
# │ A quick deploy hook listener (like for Github webhooks)            │
# │ https://github.com/shofetim/deploy-hook                            │
# ├────────────────────────────────────────────────────────────────────┤
# │ Copyright © 2014 Jordan Schatz                                     │
# │ Copyright © 2014 Noionλabs (http://noionlabs.com)                  │
# ├────────────────────────────────────────────────────────────────────┤
# │ Licensed under the MIT License                                     │
# └────────────────────────────────────────────────────────────────────┘

# Start from docker's debian:wheezy which is currently the most
# minimal and trust worthy
# https://registry.hub.docker.com/_/debian/
FROM debian:wheezy

MAINTAINER Jordan Schatz "jordan@noionlabs.com"

# Let apt know that we will be running non-interactively.
ENV DEBIAN_FRONTEND noninteractive

# Update and add python
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python git

COPY private-key /root/.ssh/id_rsa
COPY ssh-config /root/.ssh/config

# Add the server to listen for the push notification
RUN mkdir -p /srv/deploy-hook/
WORKDIR /srv/deploy-hook/
COPY listen.py /srv/deploy-hook/listen.py
COPY quotes.txt /srv/deploy-hook/quotes.txt
# What you want to run when a push happens
COPY deploy.sh /srv/deploy-hook/deploy.sh

# Set up the application directory.
VOLUME ["/app"]

EXPOSE 9090

ENTRYPOINT ["/usr/bin/python", "/srv/deploy-hook/listen.py"]
