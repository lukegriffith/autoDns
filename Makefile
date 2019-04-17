
.PHONY: default
default: build container

.PHONY: gobuild
gobuild:
	go get github.com/lukemgriffith/autodns
	env CGO_ENABLED=0 go build -o autodns . 

.PHONY: container
container:
	chmod a+x terraform
	docker build -t lukegriffith/autodns:latest .
	docker push lukegriffith/autodns:latest

.PHONY: deploy
deploy:
	#kubectl apply -f manifest.json
	docker run -e 'AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID)' \
		-e 'AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY)' \
		-e 'zone_name=griffith.cloud' \
		-e 'a_record=home' \
		-e 'tfDir=/app/workspace' -d \
		lukegriffith/autodns:latest

.PHONY: clean
clean:

.PHONY: deps
deps:
	if [ ! -f ./terraform ]
	then
		curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip 
		unzip /tmp/terraform.zip
	fi

