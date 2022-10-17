#!/bin/bash

# Download latest hosts
stevelBlackHostsUrl="https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
fileName="hosts.txt"
curl -o $fileName $stevelBlackHostsUrl

# Delete initial mappings
sed -i -n '/^# Start StevenBlack$/,$p' $fileName

# Delete comments
search="#.*"
replace=""
sed -i "s/$search/$replace/g" $fileName

# Replace '0.0.0.0 domain' with '||domain^'
search="^0.0.0.0 \(.*\)"
replace="||\\1^"
sed -i "s/$search/$replace/g" $fileName

# Delete empty lines
sed -i -r '/^\s*$/d' $fileName

# Sort
sort $fileName > $fileName

# Push to main
git add *
git commit -m "Update hosts"
git push origin main