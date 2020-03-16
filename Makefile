.PHONY: start stop ps clean build-all build build-services build-applications build-openvino
.DEFAULT_GOAL := help

build-all: build build-services build-applications build-openvino

build:
	docker-compose build

.ONESHELL:
build-services:
	cd services/
	docker-compose build

.ONESHELL:
build-applications:
	cd iikim/
	docker-compose build

.ONESHELL:
build-openvino:
	cd iikim/openvino/
	docker-compose build

logs:
	docker-compose logs

start:
	docker-compose up -d

restart:
	docker-compose restart

stop:
	docker-compose down

ps:
	docker-compose ps

help:
	@echo 'Use build-<smth> or start/stop'
