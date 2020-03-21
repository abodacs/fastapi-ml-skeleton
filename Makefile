up:
	docker-compose -f docker-compose-dev.yml up -d $(filter-out $@,$(MAKECMDGOALS))

build:
	docker-compose -f docker-compose-dev.yml build $(filter-out $@,$(MAKECMDGOALS))

stop:
	docker-compose -f docker-compose-dev.yml stop $(filter-out $@,$(MAKECMDGOALS))

run:
	docker-compose -f docker-compose-dev.yml run --rm  $(filter-out $@,$(MAKECMDGOALS))

tox:
	docker-compose -f docker-compose-dev.yml run --rm api tox

bash:
	 docker exec -it fastapi-ml-skeleton_api_1 /bin/bash

format:
	 docker exec -it fastapi-ml-skeleton_api_1 /bin/bash /usr/local/bin/scripts/format

logs:
	COMPOSE_HTTP_TIMEOUT=200 docker-compose -f docker-compose-dev.yml logs -f --tail=70 $(filter-out $@,$(MAKECMDGOALS))

down:
	COMPOSE_HTTP_TIMEOUT=200 docker-compose -f docker-compose-dev.yml down


install-pre-commit: install-test-requirements
	pre-commit install --install-hooks

uninstall-pre-commit:
	pre-commit uninstall
	pre-commit uninstall --hook-type pre-push
