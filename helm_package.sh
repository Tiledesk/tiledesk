#!/bin/bash
helm lint ./helm
git pull
helm package helm -d helm/releases
helm repo index --url https://tiledesk.github.io/tiledesk/helm/releases --merge index.yaml ./helm/releases/
git add .
VERSION=$(grep '^version:' helm/Chart.yaml | awk '{print $2}')
git commit -m "helm package Chart: $VERSION"
git push
helm repo update