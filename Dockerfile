FROM golang:alpine
RUN mkdir -p /app/workspace
ADD autodns /app/
ADD *.tf /app/workspace/
RUN mkdir /opt/autodnsState
ENV tfDir /app/workspace
CMD ["/app/autodns"]
