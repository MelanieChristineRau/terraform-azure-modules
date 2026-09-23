# Shortcuts so you do not have to remember every Terraform flag.
# fmt / validate / lint / docs never change Azure.
# plan writes a file. apply uses that file.

.PHONY: fmt validate lint docs catalogue check plan apply

PATTERN ?= patterns/ai-hackathon
BACKEND ?= backends/sbx.hcl
PLANFILE ?= tfplan

IMPLEMENTED := shared/naming shared/tags building-blocks/foundation/resource-group patterns/ai-hackathon
MODULE_DIRS := $(shell find shared building-blocks patterns -type f -name '*.tf' -exec dirname {} \; | sort -u)

fmt:
	terraform fmt -recursive

validate:
	@for d in $(IMPLEMENTED); do \
	  echo "==> $$d"; \
	  terraform -chdir=$$d init -backend=false -input=false >/dev/null; \
	  terraform -chdir=$$d validate; \
	done

lint:
	@command -v tflint >/dev/null || { echo "tflint is not installed"; exit 1; }
	tflint --init
	@for d in $(IMPLEMENTED); do \
	  echo "==> tflint $$d"; \
	  tflint --chdir=$$d --config $$PWD/.tflint.hcl; \
	done

docs:
	@command -v terraform-docs >/dev/null || { echo "terraform-docs is not installed"; exit 1; }
	@for d in $(IMPLEMENTED); do \
	  echo "==> docs $$d"; \
	  terraform-docs markdown table --output-file README.md --output-mode inject $$d; \
	done
	python3 scripts/generate_catalogue.py

catalogue:
	python3 scripts/generate_catalogue.py

check: fmt validate lint docs
	@git diff --exit-code -- README.md shared building-blocks patterns || \
	  (echo "Docs or formatting are stale. Run make docs && make fmt and commit."; exit 1)

plan:
	terraform -chdir=$(PATTERN) init -input=false -backend-config=../../$(BACKEND)
	terraform -chdir=$(PATTERN) plan -out=$(PLANFILE)

apply:
	@test -f $(PATTERN)/$(PLANFILE) || (echo "No $(PATTERN)/$(PLANFILE). Run make plan first."; exit 1)
	terraform -chdir=$(PATTERN) apply $(PLANFILE)
