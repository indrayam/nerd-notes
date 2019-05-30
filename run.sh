#!/bin/bash

CEC_ID="${CEC_ID:-anasharm}"
APP_ID="${APP_ID:-c213f037dbbffec86ff2f9551d9619bf}"
AD_ALL_GROUPS="${AD_ALL_GROUPS:-cd2-hackitx-admin}"

echo "Using the following values..."
echo "CEC_ID: $CEC_ID"
echo "CEC_ID: $APP_ID"
echo "CEC_ID: $AD_ALL_GROUPS"

echo "Let's get into the right folder before running our automation..."
cd ~/tmp

# Step 1: Use codectl to create a new Git Repo
codectl create scm repo --repo-name cd2-hackitx-$CEC_ID --project-key cch

# Step 2: Use codectl to create a new Git Repo
git clone ssh://git@gitscm.cisco.com/ccd/cd2-demo-greenfield-rtp.git
mv cd2-demo-greenfield-rtp cd2-hackitx-$CEC_ID
cd cd2-hackitx-$CEC_ID
ls -ahl
rm -rf .git
git init
git add --all
git commit -m "Initial Commit"
git remote add origin ssh://git@gitscm.cisco.com/cch/cd2-hackitx-$CEC_ID.git
git push -u origin master

# Step 3: Use codectl to get IT Application Metadata
echo "Skipping Step 3 of getting IT Application Metadata..."
echo "Why? Since we already have the values..."

# Step 4: Use codectl to create software
codectl create software --app-id $APP_ID --all-groups $AD_ALL_GROUPS
codectl get software -o json | jq .

# Step 5: Use codectl to create CD 2.0 Pipeline
codectl create pipeline --server-name ci4.cisco.com \
  --job-folder-path IT-GATS-IT_Architecture/CD-Demo/ \
  --repo-name cd2-hackitx-$CEC_ID \
  --org-name it_gats_it_architecture \
  --spin-app spin-app-$CEC_ID






