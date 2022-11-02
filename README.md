# Update The Base Image

~~~ bash
docker pull osrf/ros:humble-desktop-full
~~~

# Rebuild The Image from Dockerfile

~~~ bash
docker-compose build
~~~

# Run The Container

## NVIDIA

~~~ bash
docker-compose run --rm nvidia
~~~

## Others

~~~ bash
docker-compose run --rm dev
~~~
