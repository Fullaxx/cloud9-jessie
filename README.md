# A Cloud9 docker image based on Debian 8 (Jessie)

## Base Docker Image
Debian 8

## Get the image

Download an automated build from the public Docker Hub Registry:

    docker pull fullaxx/cloud9-jessie

## Usage

    docker run -d -p 80:80 fullaxx/cloud9-jessie

You can add a workspace as a volume directory with the argument *-v /your-path/c9ws/:/c9ws/* like this :

    docker run -d -p 80:80 -v /your-path/c9ws/:/c9ws/ fullaxx/cloud9-jessie
