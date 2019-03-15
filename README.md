# A Cloud9 docker image based on Debian 8 (Jessie)

## Base Docker Image
[Debian](https://hub.docker.com/_/debian) 8 (x64)

## Get the image from Docker Hub
```
docker pull fullaxx/cloud9-jessie
```
## Run the image on port 80
```
docker run -d -p 80:80 fullaxx/cloud9-jessie
```
## Save your Cloud9 workspace on the host
```
docker run -d -p 80:80 -v /your/path/c9ws/:/c9ws/ fullaxx/cloud9-jessie
```
## Build it locally using the github repository
```
docker build -t="fullaxx/cloud9-jessie" github.com/Fullaxx/cloud9-jessie
```
