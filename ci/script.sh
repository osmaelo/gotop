#!/usr/bin/env bash

go build -o ${NAME}

mkdir -p dist

if [[ ${GOARCH} == "arm64" ]]; then
    FILE=${NAME}_${TRAVIS_BRANCH}_${GOOS}_arm8
else
    FILE=${NAME}_${TRAVIS_BRANCH}_${GOOS}_${GOARCH}${GOARM}
fi

tar -czf dist/${FILE}.tgz ${NAME}

if [[ ${GOOS} == "linux" && ${GOARCH} == "amd64" ]]; then
    go get github.com/goreleaser/nfpm
    export VERSION=$(go run main.go -v)
    nfpm pkg --config ci/nfpm.yml --target dist/${FILE}.deb
    nfpm pkg --config ci/nfpm.yml --target dist/${FILE}.rpm
fi
