#!/bin/bash

# Crawls through their site, creates/updates JSON store
echo $(date)
echo ">>>> Crawling site..."
ruby -e 'require "./compiler/app/crawler"; Crawler.new.call'

# Regenerates the static site
cd viewer
echo ">>>> Switching to development branch..."
git checkout development

echo ">>>> Calling nanoc..."
bundle install
bundle exec nanoc

cd -

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
git checkout development viewer/output/

echo ">>>> Moving files to root dir..."
mv viewer/output/* ./

echo ">>>> Cleaning up output folder..."
git reset HEAD viewer/output/
git clean -df viewer/output/

# Pushes the changes to the Github Pages branch
echo ">>>> Adding update site files with git add..."
git add .

echo ">>>> Committing..."
git commit -m "Updates static files (automated)."

echo ">>>> Pushing to master (github.io) branch..."
git push origin master
git clean -df
git checkout .

echo ">>>> Checking out development branch..."
git checkout development

echo ">>>> Done!"
