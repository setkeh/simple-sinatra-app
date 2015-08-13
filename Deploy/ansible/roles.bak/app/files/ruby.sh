#!/bin/bash

##########
# Config #
##########



##########
# Script #
##########

function r {
  if [ $1 == bi ]
  then
    bundle_install

  elif [ $1 == prod ]
  then
    prod

  elif [ $1 == key ]
  then
    key

  else
    help
  fi
}

function bundle_install {
  cd /var/www
  bundle install
}
