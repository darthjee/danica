PROJECT?=danica

dev:
	docker-compose run $(PROJECT) /bin/bash

ci:
	docker-compose run $(PROJECT)_circleci /bin/bash
