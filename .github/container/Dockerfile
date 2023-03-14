FROM alpine:edge

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update
RUN apk add make python3 py3-pip zip pandoc texlive-full ghostscript
RUN pip3 install Pygments
