#!/bin/bash

/app/wakahs

git config --global user.name "wakahs-bot"
git config --global user.email "wakahs-bot@noreply.github.com"

# Configure Git to use the GitHub token for authentication
git config --global credential.helper '!f() { echo "password=${INPUT_GH_TOKEN}"; }; f'

git --git-dir=/github/workspace/.git --work-tree=/github/workspace add README.md
git --git-dir=/github/workspace/.git --work-tree=/github/workspace commit -m "update(README.md): wakahs-bot update"
git --git-dir=/github/workspace/.git --work-tree=/github/workspace push
