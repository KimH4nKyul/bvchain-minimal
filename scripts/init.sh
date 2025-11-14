#!/usr/bin/env bash

rm -rf $HOME/.bvchain
BVCHAIN_BIN=$(which bvchain)
if [ -z "$BVCHAIN_BIN" ]; then
    GOBIN=$(go env GOPATH)/bin
    BVCHAIN_BIN=$(which $GOBIN/bvchain)
fi

if [ -z "$BVCHAIN_BIN" ]; then
    echo "please verify bvchain is installed"
    exit 1
fi

# configure bvchain
$BVCHAIN_BIN config set client chain-id bvchain-test-1
$BVCHAIN_BIN config set client keyring-backend test
$BVCHAIN_BIN keys add kh
$BVCHAIN_BIN keys add hh
$BVCHAIN_BIN init test --chain-id bvchain-test-1 --default-denom ubvt
# update genesis
$BVCHAIN_BIN genesis add-genesis-account kh 10000000ubvt --keyring-backend test
$BVCHAIN_BIN genesis add-genesis-account hh 1000ubvt --keyring-backend test
# create default validator
$BVCHAIN_BIN genesis gentx kh 1000000ubvt --chain-id bvchain-test-1 --moniker root
$BVCHAIN_BIN genesis collect-gentxs
