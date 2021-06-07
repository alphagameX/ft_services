FROM arthur/base

ENV SERVICE influxdb

RUN apk add influxdb

COPY run.sh tmp/run.sh

COPY live.sh /tmp/live.sh
RUN chmod +x /tmp/live.sh

CMD ["sh", "tmp/run.sh"]