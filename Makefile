
.PHONY: default
default: gobuild dockerbuild

.PHONY: gobuild
gobuild:
	go get github.com/lukemgriffith/autodns
	go build -o autodns . 

.PHONY: dockerbuild
dockerbuild:
	docker build -t autodns:latest .
