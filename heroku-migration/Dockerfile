FROM node:alpine

ENV WORKDIR /usr/src/app
WORKDIR $WORKDIR

COPY scripts scripts/

RUN apk add --no-cache bash curl postgresql-client
RUN curl https://cli-assets.heroku.com/install.sh | sh

# uid=1000(node) gid=1000(node) groups=1000(node),1000(node)
ENV USERID 1000

RUN chown -R $USERID:$USERID $WORKDIR

USER $USERID

WORKDIR $WORKDIR/scripts
ENTRYPOINT ["./run.sh"]
