SHELL=/bin/bash -euo pipefail

#Installs Poetry, a Python library manager.
install-python:
	poetry install

#Installs npm, a JavaScript Package Manager, in root dir and /sandbox/.
install-node:
	npm install
	cd sandbox && npm install

#Configures Git Hooks, which are scipts that run given a specified event.
.git/hooks/pre-commit:
	cp scripts/pre-commit .git/hooks/pre-commit

#Condensed Target to run all targets above.
install: install-node install-python .git/hooks/pre-commit

#Run the npm linting script (specified in package.json). Used to check the syntax and formatting of files.
lint:
	npm run lint
	find . -name '*.py' -not -path '**/.venv/*' | xargs poetry run flake8

#Create /build/ sub-directory and builds the project into it.
publish: clean
	mkdir -p build
	npm run publish 2> /dev/null

#Files to loop over in release
_dist_include="pytest.ini poetry.lock poetry.toml pyproject.toml Makefile build/. tests"

#Create /dist/ sub-directory and copy files into directory
release: clean publish build-proxy
	mkdir -p dist
	for f in $(_dist_include); do cp -r $$f dist; done
	cp ecs-proxies-deploy.yml dist/ecs-deploy-sandbox.yml
	cp ecs-proxies-deploy.yml dist/ecs-deploy-internal-qa-sandbox.yml
	cp ecs-proxies-deploy.yml dist/ecs-deploy-internal-dev-sandbox.yml

#Runs end-to-end smoke tests post-deployment to verify the environment is working
smoketest:
	poetry run pytest -v --junitxml=smoketest-report.xml -s -m smoketest
