#!/bin/bash

# usage: ./deploy.sh staging sddffafaafaf
# license: public domain

BRANCH=$1
SHA1=$2
DOCKER_ID=$3
DOCKER_PASSWORD=$4

DOCKER_REGISTRY_HUB_ID="manojkmhub"
application_name="Wishlist-app"
environment_name="Wishlistapp-env"

AWS_ACCOUNT_ID=5433-7271-5125
NAME=user-wishlist-app
EB_BUCKET=jenkins-docker-aws-eb

VERSION=$BRANCH-$SHA1
ZIP=$VERSION.zip

aws configure set default.region ap-south-1

# Authenticate against our Docker registry
#eval $(aws ecr get-login)

# Build and push the image
docker build -t $NAME:$VERSION .
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_ID" --password-stdin
#docker tag $NAME:$VERSION $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$NAME:$VERSION
#docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$NAME:$VERSION
docker push $DOCKER_REGISTRY_HUB_ID/$NAME:$VERSION

# Replace the <AWS_ACCOUNT_ID> with the real ID
sed -i='' "s/<AWS_ACCOUNT_ID>/$AWS_ACCOUNT_ID/" Dockerrun.aws.json
# Replace the <NAME> with the real name
sed -i='' "s/<NAME>/$NAME/" Dockerrun.aws.json
# Replace the <TAG> with the real version number
sed -i='' "s/<TAG>/$VERSION/" Dockerrun.aws.json

# Zip up the Dockerrun file (feel free to zip up an .ebextensions directory with it)
zip -r $ZIP Dockerrun.aws.json

aws s3 cp $ZIP s3://$EB_BUCKET/$ZIP

# Create a new application version with the zipped up Dockerrun file
aws elasticbeanstalk create-application-version --application-name $application_name \
    --version-label $VERSION --source-bundle S3Bucket=$EB_BUCKET,S3Key=$ZIP

# Update the environment to use the new application version
aws elasticbeanstalk update-environment --environment-name $environment_name \
      --version-label $VERSION
