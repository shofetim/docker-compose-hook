# ┌────────────────────────────────────────────────────────────────────┐
# │                                                       │
# │ https://github.com/shofetim/                                   │
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

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python

# Set up the application directory.
VOLUME ["/app"]

CMD ["bash"]
