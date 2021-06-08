FROM arthur/base

ENV SERVICE influxdb

RUN apk add influxdb

COPY files/run.sh tmp/run.sh

COPY probe/live.sh /tmp/live.sh
RUN chmod +x /tmp/live.sh

COPY probe/ready.sh /tmp/ready.sh
RUN chmod +x /tmp/ready.sh

CMD ["sh", "tmp/run.sh"]