#!/bin/bash
set -eou pipefail

regexString=$1

semanticVersion=''
branchName=''

if [ $regexString ]; then
    branchName=$(git for-each-ref --format='%(refname:short)' refs/heads/ | grep $regexString | grep -E '([0-9]+\.){1}[0-9].?{1}[0-9]?+' | sort --version-sort | tail -n 1 | sed 's@.*/@@')
    semanticVersion=$(git for-each-ref --format='%(refname:short)' refs/heads/ | grep $regexString | egrep -o '([0-9]+\.){1}[0-9].?{1}[0-9]?+' | sort --version-sort | tail -n 1)
else
    branchName=$(git for-each-ref --format='%(refname:short)' refs/heads/ | grep -E '([0-9]+\.){1}[0-9].?{1}[0-9]?+' | sort --version-sort | tail -n 1 | sed 's@.*/@@')
    semanticVersion=$(git for-each-ref --format='%(refname:short)' refs/heads/ | egrep -o '([0-9]+\.){1}[0-9].?{1}[0-9]?+' | sort --version-sort | tail -n 1)
fi

echo '{"semanticVersion": "'$semanticVersion'", "branchName": "'$branchName'"}'
