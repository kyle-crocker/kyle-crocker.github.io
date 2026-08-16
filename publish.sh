#!/usr/bin/env bash
#
# Publish the Crocker Lab website.
#   1) Build the production site from this preview (uses the https baseURL in config)
#   2) Deploy the built HTML -> `master` branch (the branch GitHub Pages serves)
#   3) Update the `source` branch so the repo's editable source matches what's live
#
# Auth: uses your `gh` HTTPS credentials (run `gh auth status` to check).
# Run:  bash ~/Documents/Research/website_preview_crockerlab/publish.sh
#
set -euo pipefail

PREVIEW="$HOME/Documents/Research/website_preview_crockerlab"
REPO="https://github.com/kyle-crocker/kyle-crocker.github.io.git"
NAME="Kyle Crocker"
EMAIL="kylecrocker64@gmail.com"

cd "$PREVIEW"

echo "==> 1/3  Building production site..."
rm -rf public
hugo --destination public
if grep -q 'localhost:8000' public/index.html; then
  echo "!! ERROR: build contains localhost URLs — aborting before deploy." >&2
  exit 1
fi
echo "    built $(find public -name '*.html' | wc -l | tr -d ' ') HTML pages."

echo "==> 2/3  Deploying built site to master (GitHub Pages)..."
cd "$PREVIEW/public"
touch .nojekyll                 # serve Hugo output verbatim (no Jekyll)
rm -rf .git
git init -q
git checkout -q -b master
git add -A
git -c user.name="$NAME" -c user.email="$EMAIL" \
    commit -qm "Build website: Crocker Lab refresh"
git remote add origin "$REPO"
git push -f origin master
echo "    live site pushed to master."

echo "==> 3/3  Updating source branch..."
TMPSRC="$(mktemp -d)/site_source"
mkdir -p "$TMPSRC"
# copy the editable source, excluding build output, screenshots, logs, and all .git dirs
rsync -a \
  --exclude='.git/' \
  --exclude='public/' \
  --exclude='public_preview/' \
  --exclude='resources/' \
  --exclude='.hugo_build.lock' \
  --exclude='.DS_Store' \
  --exclude='*.log' \
  --exclude='preview_*.png' \
  "$PREVIEW/" "$TMPSRC/"
cd "$TMPSRC"
git init -q
git checkout -q -b source
git add -A
git -c user.name="$NAME" -c user.email="$EMAIL" \
    commit -qm "Website source: Crocker Lab refresh"
git remote add origin "$REPO"
git push -f origin source
echo "    source branch updated."

echo
echo "DONE. GitHub Pages will rebuild in ~1 minute:"
echo "  https://kyle-crocker.github.io/"
