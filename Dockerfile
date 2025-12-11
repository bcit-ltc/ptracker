FROM node:latest

RUN useradd -m -d /app ptracker
COPY --chown=ptracker . /app

WORKDIR /app
USER ptracker

RUN npm install
RUN npm i nodemon

EXPOSE 3000
CMD ["/bin/bash", "start.sh"]

## Release
FROM nginxinc/nginx-unprivileged:alpine3.22-perl

LABEL maintainer=courseproduction@bcit.ca
LABEL org.opencontainers.image.source="https://github.com/bcit-ltc/ptracker"
LABEL org.opencontainers.image.description="Information about how to use [Qcon](https://qcon.ltc.bcit.ca)."

# COPY --from=build /public /usr/share/nginx/html/
COPY conf.d/default.conf /etc/nginx/conf.d/default.conf
