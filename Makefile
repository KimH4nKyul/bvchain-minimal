COMMIT := $(shell git log -1 --format='%H')
VERSION := 1.0.0

# Update the ldflags with the app, client & server names
ldflags = -X github.com/cosmos/cosmos-sdk/version.Name=bvchain \
	-X github.com/cosmos/cosmos-sdk/version.AppName=bvchaind \
	-X github.com/cosmos/cosmos-sdk/version.Version=$(VERSION) \
	-X github.com/cosmos/cosmos-sdk/version.Commit=$(COMMIT)

BUILD_FLAGS := -ldflags '$(ldflags)'

###########
# Install #
###########

all: install

install:
	@echo "--> ensure dependencies have not been modified"
	@go mod verify
	@echo "--> installing bvchain"
	@go install $(BUILD_FLAGS) -mod=readonly ./cmd/bvchain

init:
	./scripts/init.sh