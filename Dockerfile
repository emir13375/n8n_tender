FROM alpine:3.24 AS tools
RUN apk add --no-cache poppler-utils p7zip

FROM n8nio/n8n:2.34.4

USER root

RUN apk add --no-cache su-exec

RUN mkdir -p /opt/extra-modules && \
    cd /opt/extra-modules && \
    npm init -y && \
    npm install \
      mammoth \
      word-extractor
ENV NODE_PATH=/opt/extra-modules/node_modules

COPY --from=tools /usr/bin/pdftoppm /usr/bin/pdftoppm
COPY --from=tools /usr/bin/7z /usr/bin/7z
COPY --from=tools /usr/lib/ /usr/lib/

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["n8n"]
