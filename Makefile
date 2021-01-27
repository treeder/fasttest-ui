run:
	flutter run -d web-server --web-hostname 0.0.0.0 --web-port 5000

build:
	flutter build web

deploy: build
	firebase deploy --only hosting:turbonew

.PHONY: dep build docker release install test backup deploy
