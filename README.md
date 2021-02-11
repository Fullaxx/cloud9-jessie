# A Cloud9 docker image based on Debian 8 (Jessie)

## Base Docker Image
[Debian](https://hub.docker.com/_/debian) 8 (x64)

## Get the image from Docker Hub or build it locally
```
docker pull fullaxx/cloud9-jessie
docker build -t="fullaxx/cloud9-jessie" github.com/Fullaxx/cloud9-jessie
```

## Run the image on port 80
```
docker run -d -p 80:80 fullaxx/cloud9-jessie
```

## Save your Cloud9 workspace on the host
```
docker run -d -p 80:80 -v /srv/docker/c9ws/:/c9ws/ fullaxx/cloud9-jessie
```

## Use Basic Auth when connecting
```
docker run -d -p 80:80 \
-e C9USER=user -e C9PASS=pass \
-v /srv/docker/c9ws/:/c9ws/ \
fullaxx/cloud9-jessie
```
