FROM ubuntu:18.04
### By default the Dockerfile runs in root mode inside the container to initialize your environment
### Instead, create a user and grant that user elevated privileges as needed via sudo

## Create an account inside your container with your username
RUN groupadd -r cdeleon --gid=18120 && \
    useradd -r -g cdeleon --uid=18120 --create-home --shell /bin/bash cdeleon

## If needed, install sudo and give that account sudo access
# install sudo
RUN apt-get update && apt-get -y install sudo
# Give yourself sudo privilege inside the container
RUN echo "cdeleon   ALL = NOPASSWD: ALL" >> /etc/sudoers
RUN adduser cdeleon sudo

# From this point on, the rest of the Dockerfile executes under your name. Use sudo where necessary.
USER cdeleon

# Make sure the commands you run below this point run from your homedir, and not from /root
WORKDIR /home/cdeleon

# Use postgres 10.14
FROM postgres:10.14

# Creates database with name "dataspread_db" and superuser with username "admin" and password "password"
ENV POSTGRES_DB dataspread_db
ENV POSTGRES_USER admin  
ENV POSTGRES_PASSWORD password