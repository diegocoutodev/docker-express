FROM node:alpine

LABEL MAINTAINER="Diego do Couto <eng.coutodiego@gmail.com>"

ENV EXPRESS_UID=10001\
    EXPRESS_GID=10001

ENV EXPRESS_SERVER "bin/www"

ADD docker-entrypoint.sh /usr/bin

### Add user and group
RUN addgroup -S -g ${EXPRESS_GID} express && adduser -S -G express -u ${EXPRESS_UID} express

RUN npm install express-generator -g \
    && npm install express -g  \
    && npm install nodemon -g \
    && npm install -g sequelize-cli && \
    mkdir -p /cache && chown -Rf ${EXPRESS_UID}:${EXPRESS_GID} /cache && \
    npm config set cache /cache --global

WORKDIR /app

VOLUME [ "/app", "/cache" ]

RUN chown -Rf ${EXPRESS_UID}:${EXPRESS_GID} . && \
    chmod a+x /usr/bin/docker-entrypoint.sh

EXPOSE 3000

### Containers should not run as root as a good practice
USER ${EXPRESS_UID}

ENTRYPOINT [ "/usr/bin/docker-entrypoint.sh" ]