FROM ubuntu:16.04

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
ENV APP_PATH /venv
WORKDIR $APP_PATH

# Update ubuntu
RUN apt-get update

# Install nginx
RUN apt-get install -y nginx

# Install mysql server
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
    && echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
    && apt-get install -y mysql-server

ADD start.sh /venv

WORKDIR /venv

RUN chmod a+x /venv/*

ENTRYPOINT ["/venv/start.sh"]

EXPOSE 80