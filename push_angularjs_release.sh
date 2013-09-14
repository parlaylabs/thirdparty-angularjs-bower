#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

FILE_LIST=" \
  angular.js \
  angular.min.js \
  angular.min.js.map \
"

ANGULAR_JS_SRC_DIR=$1/build
RELEASE_TAG=$2

pushd $ANGULAR_JS_SRC_DIR
echo now in directory $(pwd)

cp $FILE_LIST $SCRIPT_DIR
cat > bower.json << _EOF
{
  "name": "angular",
  "version": "$RELEASE_TAG",
  "main": "./angular.js",
  "dependencies": {
  }
}
_EOF

#git commit -a
#git tag

