# Official documentation here: https://docs.docker.com/engine/reference/commandline/cli/

### DockerFile content ###

ARG VERSION=6.9.2                 # sets variable VERSION to 6.9.2
RUN echo $VERSION > image_version # writes VERSION to file image_version
FROM node:$VERSION                # from image with node version
ENV FOO="whatevs"                 # sets environment variable FOO to "whatevs"
LABEL app_version="1.0"           # sets label app_version to 1.0
WORKDIR /app                      # sets working directory to /app
ADD test.txt relativeDir/         # adds test.txt from relativeDir to /app
RUN --mount type=bind,source=.,target=/app echo "hello" # runs echo "hello" in /app
COPY server.js .                  # copies server.js (node server) from path .
VOLUME /data                      # creates volume /data
RUN <<EOT
  mkdir -p data/logs
EOT # runs multiline command
STOPSIGNAL SIGKILL                # sets stop signal to SIGKILL
SHELL ["/bin/bash", "-c"]         # sets shell to /bin/bash -c (default)
EXPOSE 80 443                     # exposes ports
ENTRYPOINT ["node", "server.js"]  # sets entrypoint to node server.js
CMD node server.js                # serves node srv


### BUILD ###
docker build -t <registry>/<PROJECT_ID>/<name>:v<version number> . # builds image from DockerFile


### RUN ###

docker run -d -p 8080:8080 <registry>/<PROJECT_ID>/<name>:v1  # launches container
docker ps                                                     # shows running containers
docker stop <container-id>                                    # stops specific container
docker logs (-f) <container-id>                               # shows logs of specific container
docker exec -it [container_id] bash                           # opens bash in container
docker inspect [container_id]                                 # shows container info

docker stop $(docker ps -q)                                   # stops all running containers
docker rm $(docker ps -aq)                                    # removes all containers

docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}' # shows images in table format
docker images | grep -c none # counts untagged images
docker rmi $(docker images -f "dangling=true" -q)	# remove untagged images