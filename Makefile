include .envrc

## help: print this help message
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

## run/api: run the cmd/api application
run:
	go run ./cmd/api

## db/psql: connect to the database using psql
psql:
	psql ${GREENLIGHT_DB_DSN}

confirm:
	@echo -n 'Are you sure? [y/N]' && read ans && [ $${ans:-N} = y ]

## db/migrations/up: apply all up database migrations
up: confirm
	@echo 'Running up migration...'
	migrate -path ./migrations -database=${GREENLIGHT_DB_DSN}
	