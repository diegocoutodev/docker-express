#!/bin/sh

APP_DIR="/app"

cd $APP_DIR;

# There is a package, then install dependencies
if [ -f "package.json" ]; then
  npm install;

  if [ -f "${EXPRESS_SERVER}" ]; then
    nodemon ${EXPRESS_SERVER};
  fi

fi

cd - > /dev/null;