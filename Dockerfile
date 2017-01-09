FROM alpine:3.5
RUN wget -O- "http://s3.amazonaws.com/babl/babl-server_linux_amd64.gz" | gunzip > /bin/babl-server && chmod +x /bin/babl-server
RUN wget -O- "http://s3.amazonaws.com/babl/babl_linux_amd64.gz" | gunzip > /bin/babl && chmod +x /bin/babl
ADD app /bin/app
CMD ["babl-server"]
