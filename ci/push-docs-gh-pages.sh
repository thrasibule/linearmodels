#!/usr/bin/env bash

echo "Set git email and name"
git config user.email "kevin.k.sheppard@gmail.com"
git config user.name "Kevin Sheppard"
echo "Checkout pages"
git checkout gh-pages
echo "Remove devel"
rm -rf devel
echo "Make a new devel"
mkdir devel
echo "Checking for tag"
if [[ -n "${GIT_TAG}" ]]; then
  echo "Tag ${GIT_TAG} is defined"
  echo "Copy docs to root"
  echo cp -r ${PWD}/doc/build/html/* ${PWD}/
  cp -r ${PWD}/doc/build/html/* ${PWD}
else
  echo "Tag is ${GIT_TAG}. Not updating main documents"
fi
echo "Copy docs to devel"
echo cp -r ${PWD}/doc/build/html/* ${PWD}/devel/
cp -r ${PWD}/doc/build/html/* ${PWD}/devel/
echo "Add devel"
git add devel/.
echo "Change remote"
git remote set-url origin https://bashtage:"${GH_PAGES_TOKEN}"@github.com/bashtage/linearmodels.git
echo "Github Actions doc build after commit ${GITHUB_SHA::8}"
git commit -a -m "Github Actions doc build after commit ${GITHUB_SHA::8}"
echo "Push"
git push -f
