#!/bin/bash

jekyll
git checkout master
git fetch origin master
git merge --ff-only origin/master
cp -R public/* .
git add .
git commit
git push origin master
git checkout source
