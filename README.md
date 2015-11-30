# blender-render-cluster
A docker based multi machine render setup

## How to build master

Be sure the environment variable within the Dockerfile is set to MASTER

ENV RENDER_MODE MASTER

$ docker build -t blender_master .

## How to build slaves

Edit the environment variable within the Dockerfile to SLAVE

ENV RENDER_MODE SLAVE

$ docker build -t blender_slave .

## How to connect slaves to master

$ docker link blender_master:master blender_slave
