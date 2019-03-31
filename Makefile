
.PHONY: default
default: build container

.PHONY: gobuild
build:
	go get github.com/lukemgriffith/autodns
	env CGO_ENABLED=0 go build -o autodns . 

.PHONY: container
container:
	docker build -t lukegriffith/autodns:latest .
	docker push lukegriffith/autodns:latest

.PHONY: deploy
deploy:
	kubectl apply -f manifest.json

.PHONY: clean
clean:
	for pod in `kubectl get pods | grep autodns | awk '{print $$1}'`; do kubectl delete pods $$pod; done;
