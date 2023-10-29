SHELL := /bin/bash

BUILD_DATE := $(shell date -u '+%Y-%m-%d %I:%M:%S UTC' 2> /dev/null)
GIT_HASH := $(shell git rev-parse HEAD 2> /dev/null)

GOPATH ?= $(shell go env GOPATH)
PATH := $(GOPATH)/bin:$(PATH)
GO_BUILD_ENV_VARS = $(if $(GO_ENV_VARS),$(GO_ENV_VARS),CGO_ENABLED=0)
GO_BUILD_ARGS = -buildvcs=false -ldflags "-X main.GitCommit=${GIT_HASH}"

.PHONY: verify \
	tidy \
	fmt \
	vet \
	check \
	test-unit \
	test-coverage \
	test-all

verify: ## Verify the plugin
	@echo
	@echo "Verifying plugin..."
	@go mod verify

tidy: ## Tidy the plugin
	@echo
	@echo "Tidying plugin..."
	@go mod tidy

fmt: ## Format the plugin
	@echo
	@echo "Formatting plugin..."
	@go fmt ./...

vet: ## Vet the plugin
	@echo
	@echo "Vetting plugin..."
	@go vet ./...

check: verify tidy fmt vet ## Verify, tidy, fmt and vet the plugin

test-unit: ## Run unit tests
	@echo
	@echo "Running unit tests..."
	@go test -short ./...

test-coverage: ## Run tests with coverage
	@echo
	@echo "Running tests with coverage..."
	@go test -v -race -covermode=atomic -coverprofile=cover.out ./...

test-all: test-unit test-coverage ## Includes test-unit and test-coverage
