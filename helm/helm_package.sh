#!/bin/bash

helm package helm -d /releases
helm repo index --url https://tiledesk.github.io/tiledesk-deployment/helm/releases --merge index.yaml ./releases/
git push