VERSION:=1
USER:=lstest
IMAGE:=ls-c-azi

.PHONY: build

build: guard-VERSION guard-IMAGE guard-USER
	docker build -t $(USER)/$(IMAGE):$(VERSION) .

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

metadata: guard-VERSION guard-IMAGE guard-USER
	@docker run --rm \
		-t $(USER)/$(IMAGE):$(VERSION) \
		metadata
