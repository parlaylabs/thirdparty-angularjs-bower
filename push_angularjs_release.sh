#!/bin/bash

if [ $# != 1 || $# != 2 ]; then
  echo "Usage: $0 ANGULAR_JS_SRC_DIR [RELEASE_TAG(optional)]"
  echo "  e.g. $0 ~/thirdparty-angularjs v1.2.0-rc.2"
  echo "  e.g. $0 ~/thirdparty-angularjs"
  echo " Remember to build angularjs before running this command."
  exit 1
fi

SCRIPT_DIR=$(cd $(dirname $0); pwd)

FILE_LIST=" \
  angular.js \
  angular.min.js \
  angular.min.js.map \
"

ANGULAR_JS_SRC_DIR=$1/build
RELEASE_TAG=$2

(cd $ANGULAR_JS_SRC_DIR && cp $FILE_LIST $SCRIPT_DIR)
if [ "x$RELEASE_TAG" != "x" ]; then
  cat << ABCF > bower.json 
{
  "name": "angular",
  "version": "${RELEASE_TAG#v}",
  "main": "./angular.js",
  "dependencies": {
  }
}
ABCF
fi

echo Release tag ${RELEASE_TAG}
git commit -a
git diff HEAD^
echo -n "Do you want to tag and push? (y/N)"
read ANSWER
if [ $ANSWER == "y" ]; then
  if [ "x$RELEASE_TAG" != "x" ]; then
    git tag ${RELEASE_TAG}
  fi
  git push origin $RELEASE_TAG
fi

