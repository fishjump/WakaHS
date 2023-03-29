#!/bin/bash

/app/wakahs

git config --global user.name "wakahs-bot"
git config --global user.email "wakahs-bot@noreply.github.com"

git --git-dir=/github/workspace/.git --work-tree=/github/workspace add README.md
git --git-dir=/github/workspace/.git --work-tree=/github/workspace commit -m "update(README.md): wakahs-bot update"
git --git-dir=/github/workspace/.git --work-tree=/github/workspace push
