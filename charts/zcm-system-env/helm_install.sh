#!/bin/sh

dirlist="ls"
for dir in `$dirlist`
do
  if [ -d $dir ]; then
    helm install $dir $dir -n zcm9 -f ../values.yaml
  fi
done
