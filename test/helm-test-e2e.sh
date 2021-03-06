#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

# Install and initialize helm/tiller
HELM_URL=https://storage.googleapis.com/kubernetes-helm
HELM_TARBALL=helm-v2.4.2-linux-amd64.tar.gz

wget -q ${HELM_URL}/${HELM_TARBALL}
tar xzfv ${HELM_TARBALL}

# Clean up tarball
rm -f ${HELM_TARBALL}

# Housekeeping
linux-amd64/helm init --upgrade

# Run test framework
export GOPATH=/src
cd /src/k8s.io/charts/test/
go get -v ./...
go run ./helm-test/main.go
