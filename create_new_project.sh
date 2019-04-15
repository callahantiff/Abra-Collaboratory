#!/bin/bash

if [ $# != 2 ]
  then
    echo "Please provide user name and project name"
    exit 1
fi

USER_NAME=$1
PROJECT_NAME=$2

git clone https://github.com/callahantiff/Abra-Collaboratory.git
mkdir resources
mkdir .github
mv Abra-Collaboratory/.github/ISSUE_TEMPLATE .github/
mv Abra-Collaboratory/resources/documentation resources/
mv Abra-Collaboratory/resources/New_Collaborators_Invitation_Email.md resources/

rm -rf Abra-Collaboratory/

git clone https://github.com/callahantiff/Abra-Collaboratory.wiki.git
cd Abra-Collaboratory.wiki
rm Home.md
rm Our-Reproducible-Repository-Guidelines-😃.md
rm Resources-📚🖥.md
rm Using-GitHub-as-a-Reproducible-Research-Platform.md

git add .
git commit -m "Removed Abra-C specific files"

find . -type f -exec sed -i 's/callahantiff/{$USER_NAME}/g' {} \;
find . -type f -exec sed -i 's/Abra-Collaboratory/{$PROJECT_NAME}/g' {} \;

git add .
git commit -m "Replaced links"

git remote add wiki-fork https://github.com/${USER_NAME}/${PROJECT_NAME}.wiki.git
git push wiki-fork -f

cd ..
rm -rf Abra-Collaboratory.wiki