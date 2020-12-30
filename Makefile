.PHONY: help build start stop restart up down ps log runner setup

.DEFAULT_GOAL := help

help:	## ヘルプを表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:	## アプリイメージをビルドします
	@docker buildx bake -f docker-compose.yml --set base.output=type=docker --set db.output=type=docker

prune:	## ビルドキャッシュを削除します
	@docker builder prune

restart:	## 起動中のコンテナを再起動します
	@docker-compose restart server db

up:	## コンテナを起動します
	@docker-compose up -d server db

down:	## コンテナを終了します
	@docker-compose down

downv:	## コンテナを終了してボリュームも削除します
	@docker-compose down -v

bundle-install:	## bundle installを実行します
	@docker-compose run --rm runner bundle install

console:	## Rails Consoleを起動します
	@docker-compose run --rm runner rails c

migrate:	## マイグレーションを実行します
	@docker-compose run --rm runner rails db:migrate

runner:	## シェルを起動します
	@docker-compose run --rm runner

ps:	## 起動中のコンテナを表示します
	@docker-compose ps

log:	## 全てのログを表示します
	@docker-compose logs -f

log-server:	## アプリのログを表示します
	@docker-compose logs -f server

log-db:	## PostgreSQLのログを表示します
	@docker-compose logs -f db

wait:	## PostgreSQLの起動を待ちます
	@docker-compose run --rm wait

setup: build	bundle-install	down## 初回セットアップを実行します
