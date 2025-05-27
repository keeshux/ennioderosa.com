#!/bin/bash
set -e
rm -f .jekyll-metadata
JEKYLL_ENV=production bundle exec jekyll build
cd ../ennioderosa.com
git add . -A
git commit -m .
git push github master
