
.PHONY: default
default: gobuild dockerbuild

.PHONY: gobuild
gobuild:
	go build . -o autoDns

.PHONY: dockerbuild
dockerbuild:
	docker build -t autoDns:latest .
