# Like Docker Compose, except it listens for webhooks

`docker run -v /var/run/docker.sock:/var/run/docker.sock -v ~/Desktop/tmp/docker-compose.yml:/tmp/docker-compose.yml --rm -it -p 9090:9090 docker-compose-hook`
