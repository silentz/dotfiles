FROM alpine:3.17.2

RUN apk update
RUN apk add neovim stow
