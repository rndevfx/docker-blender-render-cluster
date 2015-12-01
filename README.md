# blender-render-cluster
A docker based multi machine render setup

## Build basic blender image
$ docker build -t blender .

## How to start as master
$ docker run -e "RENDER_MODE=MASTER" -p 8000:8000 -d blender

## How to start and run as slave

RENDER_MODE will be set to SLAVE by default. You only have to connect/link to the master container.

$ docker run --link blender_master:master -d blender
