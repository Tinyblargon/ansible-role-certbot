
.PHONY: all
all:

.PHONY: info
info: ansible_info ansible_lint_info

.PHONY: lint
lint:
	@ansible-lint

.PHONY: unit_test
unit_test:
	@export ANSIBLE_ROLES_PATH="$$(dirname "$$(pwd)")" ;\
		export ANSIBLE_FORCE_COLOR=True ;\
		ansible-playbook unit-tests.playbook.yml

.PHONY: ansible_info
ansible_info:
	@ansible --version

.PHONY: ansible_lint_info
ansible_lint_info:
	@ansible-lint --version
