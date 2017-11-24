#!/bin/sh
VERSION=0.0.1
docker build -t arturoaparicio/bullfrog-test --build-arg BULLFROG_VERSION=$VERSION .
