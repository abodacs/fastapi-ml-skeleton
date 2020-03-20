up:
	docker-compose -f docker-compose.dev.yml up -d $(filter-out $@,$(MAKECMDGOALS))

build:
	docker-compose -f docker-compose-dev.yml build $(filter-out $@,$(MAKECMDGOALS))

stop:
	docker-compose -f docker-compose-dev.yml stop $(filter-out $@,$(MAKECMDGOALS))

run:
	docker-compose -f docker-compose-dev.yml run --rm  $(filter-out $@,$(MAKECMDGOALS))

bash:
	docker-compose -f docker-compose-dev.yml run --rm api bash

logs:
	COMPOSE_HTTP_TIMEOUT=200 docker-compose -f docker-compose-dev.yml logs -f --tail=70 $(filter-out $@,$(MAKECMDGOALS))

down:
	COMPOSE_HTTP_TIMEOUT=200 docker-compose -f docker-compose-dev.yml down