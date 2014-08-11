#!/bin/bash
pushd build/

LOOP_INIT=2
if [ $DEPLOY_BRANCH = "gh-pages-preview" ] ; then
  LOOP_INIT=1
fi

for ((i=$LOOP_INIT;i<=2;i++))
do
  LOOP_BRANCH="gh-pages"
  
  if [ $i -eq 1 ] ; then
    LOOP_BRANCH="gh-pages-preview"
  elif [ $i -eq 2 ] ; then
    git submodule add -b "gh-pages-preview" https://github.com/blanketsheep/hachioji.git ./preview
    git submodule update --init
    pushd preview/
    git pull origin "gh-pages-preview"
    popd
  fi
  
  git add -A
  git commit -m Update
  git push --quiet git@github.com:blanketsheep/hachioji.git $LOOP_BRANCH
  
  if [ $i -eq 1 ] ; then
    git checkout "gh-pages"
    git clean -f -d
  fi
  
done

popd