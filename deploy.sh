#!/bin/bash

# Crawls through their site, creates/updates JSON store
echo ">>>> Crawling site..."
ruby -e 'require "./compiler/app/crawler"; Crawler.new.call'

# Regenerates the static site
cd viewer
echo ">>>> Switching to development branch..."
git checkout development

echo ">>>> Calling nanoc..."
nanoc

echo ">>>> Adding files with git add..."
git add .

echo ">>>> Commiting..."
git commit -m "Updates static files (automated)."

echo ">>>> Pushing to development branch..."
git push origin development

# Copies the static site files to the correct branch
echo ">>>> Switching to master (github.io) branch..."
git checkout master

echo ">>>> Copying output files from development branch..."
git checkout development output/

echo ">>>> Moving files to root dir..."
mv output/* ./

echo ">>>> Cleaning up output folder..."
git reset HEAD output/ && git clean -df output/

# Pushes the changes to the Github Pages branch
echo ">>>> Adding update site files with git add..."
git add .

echo ">>>> Committing..."
git commit -m "Updates static files (automated)."

echo ">>>> Pushing to master (github.io) branch..."
git push origin master

echo ">>>> Checking out development branch..."
git checkout development

echo ">>>> Done!"
