#!/bin/bash

# Crawls through their site, creates/updates JSON store
ruby -e 'require "./compiler/app/crawler"; Crawler.new.call'

# Regenerates the static site
cd viewer
git checkout development
nanoc
git add .
git commit -m "Updates static files (automated)."
git push

# Copies the static site files to the correct branch
git checkout master
git checkout development output/
mv output/* ./
git reset HEAD output/ && git clean -df output/

# Pushes the changes to the Github Pages branch
git add .
git commit -m "Updates static files (automated)."
git push origin master

git checkout development
