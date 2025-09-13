.PHONY: test run lint install-hooks

test:
	ginkgo -v ./main

run:
	go run ./main

lint:
	golangci-lint run ./main

install-hooks:
	pre-commit install
