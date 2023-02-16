#!/bin/bash

# Define your GitHub username
GITHUB_USERNAME="your-github-username"

# Define your GitLab personal access token (create one in GitLab's settings)
GITLAB_TOKEN="your-gitlab-personal-access-token"

# Define your GitLab username
GITLAB_USERNAME="your-gitlab-username"

# Get a list of your GitHub repositories
REPOS=$(curl -s -H "Authorization: token YOUR_GITHUB_TOKEN" "https://api.github.com/users/$GITHUB_USERNAME/repos" | grep -oP '(?<="name":")[^"]*')

# Loop through each repository and clone it from GitHub to your local machine
for REPO in $REPOS; do
  git clone "git@github.com:$GITHUB_USERNAME/$REPO.git"
done

# Loop through each repository and add a GitLab remote
for REPO in $REPOS; do
  cd $REPO
  git remote add gitlab "https://$GITLAB_USERNAME:$GITLAB_TOKEN@gitlab.com/$GITLAB_USERNAME/$REPO.git"
  cd ..
done

# Loop through each repository and push to GitLab
for REPO in $REPOS; do
  cd $REPO
  git push -u gitlab master
  cd ..
done
