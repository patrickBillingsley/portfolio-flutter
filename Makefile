# Makefile for deploying Flutter web projects to Github.

BASE_HREF = /$(OUTPUT)/
GITHUB_USER = patrickBillingsley
GITHUB_REPO = git@github.com-personal:$(GITHUB_USER)/$(OUTPUT)
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '${print $$2}')

deploy:
ifndef OUTPUT
	$(error OUTPUT is not set. Usage: make deploy OUTPUT=<output_repo_name>)
endif

	@echo "Cleaning existing repository..."
	flutter clean

	@echo "Getting packages..."
	flutter pub get

	@echo "Generating web folder..."
	flutter create . --platform web

	@echo "Building for web..."
	flutter build web --base-href $(BASE_HREF) --release

	@echo "Deploying to git repository..."
	cd build/web && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin main

	@echo "Finished deploy: $(GITHUB_REPO)"

.PHONY: deploy