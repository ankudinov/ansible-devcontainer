CURRENT_DIR := $(shell pwd)

.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: start
start: ## Deploy ceos lab
	sudo containerlab deploy --debug --topo $(CURRENT_DIR)/clab/topology.clab.yml --max-workers 2 --timeout 5m --reconfigure

.PHONY: stop
stop: ## Destroy ceos lab
	sudo containerlab destroy --debug --topo $(CURRENT_DIR)/clab/topology.clab.yml --cleanup

.PHONY: build
build: ## Generate AVD configs
	cd $(CURRENT_DIR)/avd_inventory; ansible-playbook playbooks/avd_build.yml

.PHONY: deploy
deploy: ## Deploy AVD configs using eAPI
	cd $(CURRENT_DIR)/avd_inventory; ansible-playbook playbooks/avd_deploy.yml

.PHONY: diff
diff: ## Show the diff between running config and designed config
	cd $(CURRENT_DIR)/avd_inventory; ansible-playbook --diff --check playbooks/avd_deploy.yml

.PHONY: test
test: ## validate the network state
	cd $(CURRENT_DIR)/avd_inventory; ansible-playbook playbooks/avd_validate.yml
