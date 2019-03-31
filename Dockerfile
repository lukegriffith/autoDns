from golang:alpine

RUN mkdir -p /app/workspace
ADD autodns /app/
ADD *.tf /app/workspace/

RUN mkdir /opt/autodnsState

ENV tfDir /app/workspace

ENV zone_name lukegriffith.co.uk

ENV a_record home

CMD ["/app/autodns"]
