#!/bin/bash
helm lint ./helm
git pull
helm package helm -d helm/releases
helm repo index --url https://tiledesk.github.io/tiledesk/helm/releases --merge index.yaml ./helm/releases/
git add .
git commit -m "helm package Chart:$1" 
git push
helm repo update