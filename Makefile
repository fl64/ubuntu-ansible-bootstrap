lint: lint-ansible

lint-yaml:
	@docker run --rm $$(tty -s && echo "-it" || echo) -v $(PWD):/data cytopia/yamllint:latest .

lint-ansible:
	@docker run --rm -v $(PWD):/code pipelinecomponents/ansible-lint ansible-lint --force-color -c .ansible-lint.yaml playbook.yaml

deploy:
	./deploy.sh

up:
	vagrant up

down:
	vagrant down
