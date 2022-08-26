BIN_DIR := "./bin"

base_dir :=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
pwd = $(shell pwd)
local_name = rdev
tag ?= dev
Rpassword = password

C_BLUE := "\\033[94m"
C_NONE := "\\033[0m"
C_CYAN := "\\033[36m"

.PHONY: default
default:
	@echo ""
	@echo "Please choose one of:"
	@echo ""
	@echo "$(C_CYAN)  ####### Project Management #######$(C_NONE)"
	@echo ""
	@echo "$(C_BLUE)    make install$(C_NONE)"
	@echo "      downloads all relevant VEuPathDB R repositories"
	@echo ""
	@echo "$(C_BLUE)    make update$(C_NONE)"
	@echo "      executes git pull on all projects"
	@echo ""
	@echo "$(C_CYAN)  ####### Build #######$(C_NONE)"
	@echo ""
	@echo "$(C_BLUE)    make build$(C_NONE)"
	@echo "      builds the top level container for development"
	@echo ""
	@echo "$(C_CYAN)  ####### Run #######$(C_NONE)"
	@echo ""
	@echo "$(C_BLUE)    make start$(C_NONE)"
	@echo "      starts the common environment"
	@echo ""
	@echo "$(C_BLUE)    make start-rstudio$(C_NONE)"
	@echo "      starts rstudio in the common environment"
	@echo ""
	@echo "$(C_BLUE)    make stop$(C_NONE)"
	@echo "      stops container"
	@echo ""


.PHONY: install
install:
	@$(BIN_DIR)/lib.sh "checkoutAll"


.PHONY: update
update:
	@$(BIN_DIR)/lib.sh "updateAll"


.PHONY: build
build:
	@echo Building $(local_name):$(tag)
	@docker build -t $(local_name):$(tag) .


.PHONY: start-shell
start-shell:
	@docker run -p 8081:8888 --rm -v $(pwd):/home/dev -it $(local_name):$(tag) $(run_cmd)

.PHONY: stop
stop:
	@docker stop $(local_name):$(tag)

# TO DO create make start-rstudio
# Is rstudio really necessary? idk if any of us use it currently...