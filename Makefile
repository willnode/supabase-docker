
## Remove all container and vlunmn data
clean:
	docker compose down -v
	rm -rf ./volumes/db/data/

## Start up all container with daemon mode
up:
	docker compose up -d

down:
	docker compose stop

## Development
up_dev:
	docker compose -f docker-compose.yml -f ./dev/docker-compose.dev.yml up -d

down_dev:
	docker compose -f docker-compose.yml -f ./dev/docker-compose.dev.yml down -v