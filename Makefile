
## Remove all container and vlunmn data
clean:
	docker compose down -v
	rm -rf ./volumes/db/data/

## Start up all container with daemon mode
up:
	docker compose up -d

down:
	docker compose stop
