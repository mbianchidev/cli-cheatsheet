# Official documentation here: https://docs.docker.com/engine/reference/commandline/cli/

### DockerFile content ###

FROM node:6.9.2     # node version
EXPOSE 8080         # exposes port 8080
COPY server.js .    # copies server.js (node server) from path .
CMD node server.js  # serves node srv

### BUILD ###
docker build -t gcr.io/<PROJECT_ID>/<name>:v<version number> .             => builda l'app <name> nella folder attuale


### RUN ###
docker run -d -p 8080:8080 gcr.io/<PROJECT_ID>/<name>:v1        => lancia l'app containerizzata
docker ps                                                       => ps come linux, hai il container id
docker stop <container-id>                                      => stoppa il container
docker logs (-f) <container-id>                                 => container ID
docker exec -it [container_id] bash                             => apre la bash del container
docker inspect [container_id]                                   => mostra i metadata del container

docker stop $(docker ps -q)                                     => stoppa tutti i container
docker rm $(docker ps -aq)                                      => rimuove tutti i container

docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}'	=> visualizza tutte le immagini presenti intabellate
docker images | grep -c none => conta le immagini non taggate
docker rmi $(docker images -f "dangling=true" -q)												=> rimuove le immagini non taggate