#!/bin/bash
path='/Users/raunakpilani/Library/Application Support/Firefox'
profile_path=`grep "Path.*empty" "${path}/profiles.ini" | cut -d'=' -f2`
rm -rf "${path}/${profile_path}"
cp -rf "${path}/${profile_path}.bkp" "${path}/${profile_path}"
