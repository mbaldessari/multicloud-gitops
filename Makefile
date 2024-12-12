.PHONY: default
default: help

.PHONY: help
##@ Pattern tasks

# No need to add a comment here as help is described in common/
help:
	@make -f common/Makefile MAKEFILE_LIST="Makefile common/Makefile" help

%:
	make -f common/Makefile $*

.PHONY: cert-test
cert-test: ## silly test to reuse the existing API CA in cert-manager
	oc new-project cert-manager
	oc get -n openshift-kube-apiserver-operator secrets/localhost-serving-signer --namespace=openshift-kube-apiserver-operator  -o yaml |  grep -v '^\s*namespace:\s'  | oc apply --namespace=cert-manager -f -


.PHONY: install
install: cert-test operator-deploy post-install ## installs the pattern and loads the secrets
	@echo "Installed"

.PHONY: post-install
post-install: ## Post-install tasks
	make load-secrets
	@echo "Done"

.PHONY: test
test:
	@make -f common/Makefile PATTERN_OPTS="-f values-global.yaml -f values-hub.yaml" test
