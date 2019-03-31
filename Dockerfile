from golang:alpine

RUN mkdir -p /app/workspace
ADD autoDns /app/
ADD *.tf /app/workspace/

RUN mkdir /opt/autoDnsState

ENV tfDir /app/workspace

ENV zone_name lukegriffith.co.uk

ENV a_record home

CMD ["/app/autoDns"]
