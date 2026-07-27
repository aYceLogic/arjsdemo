#!/usr/bin/env sh
set -e
TAG="${1:-latest}"
IMAGE="aycelogic/arjs:${TAG}"
echo "Building ${IMAGE}"
docker build -t "${IMAGE}" .

echo "Built ${IMAGE}"
echo "To push run: docker login && docker push ${IMAGE}"
