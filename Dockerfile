FROM alpine:3.17.2

RUN apk update
RUN apk add neovim stow
RUN apk add nodejs npm
RUN apk add python3

# RUN npm install pyright
# RUN go install golang.org/x/tools/gopls@latest

WORKDIR /root
ENV PATH=/root/go/bin:/root/.config/nvim/bin:/bin:/usr/bin:/usr/local/bin
