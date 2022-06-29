#!/bin/bash

helm package helm -d helm/releases
helm repo index --url https://tiledesk.github.io/tiledesk-deployment/helm/releases --merge index.yaml ./helm/releases/
git push