#!/usr/bin/bash

# Crawls through their site, creates/updates JSON store
TIMESTAMP=$(date +"[%Y-%m-%d %H:%M:%S]")
echo $(date +"[%Y-%m-%d %H:%M:%S]")
# echo $(cat $HOME/.ssh_sock)
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
echo $SSH_AUTH_SOCK

echo ">>>> Crawling site..."
cd /home/leo/work/enpassant
cd compiler
bundle install
cd -
ruby -e 'require "./compiler/app/crawler"; Crawler.new.call'

# Regenerates the static site
cd viewer
echo ">>>> Switching to development branch..."
git checkout development

echo ">>>> Calling nanoc..."
bundle install

echo "---
id: $(date +'%Y')
---" > "content/year/$(date +'%Y').html"

nanoc

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

echo ">>>> Cleaning assets..."
rm -rf ./assets

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

TIMESTAMP=$(date +"[%Y-%m-%d %H:%M:%S]")
echo $(date +"[%Y-%m-%d %H:%M:%S]")
echo ">>>> Done!"
