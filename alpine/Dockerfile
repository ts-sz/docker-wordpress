ARG  CODE_VERSION=latest
FROM alpine:${CODE_VERSION}
LABEL maintainer="ts@strategic.zone"
LABEL version="0.0.1-beta"
LABEL vendor="Strategic Zone"
LABEL release-date="2018-05-31"

RUN apk add --no-cache zsh mysql-client git
RUN sh -c "$(curl --silent https://gitlab.com/strategic.zone/install_ohmyzsh/raw/master/install_ohmyzsh.sh)"
RUN echo "export PROMPT=Docker$PROMPT" >> ~/.zshrc
ENTRYPOINT /bin/zsh
