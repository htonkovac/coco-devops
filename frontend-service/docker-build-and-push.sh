#!/bin/bash
scriptdir="$(dirname "$0")"
cd "$scriptdir"
docker build -t 068425271656.dkr.ecr.eu-west-1.amazonaws.com/eks_container_repo/frontend . && \
docker push 068425271656.dkr.ecr.eu-west-1.amazonaws.com/eks_container_repo/frontend