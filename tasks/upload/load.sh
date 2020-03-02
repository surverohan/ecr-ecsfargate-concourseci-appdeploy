#!/bin/sh
pwd
# Fail fast
set -e

# This is the order of arguments
build_folder=$1
aws_ecr_repository_url_with_tag=$2
aws_region=$3
AWS_KEY=$4
AWS_SECRET=$5


build_folder=ci-pipeline/tasks/build


echo " current pwd"
pwd

echo " build file contents"
$build_folder

ls -ltr $build_folder

#cp ci-pipeline/tasks/build/dockerfile  $build_folder

echo "final build file contents"

ls -ltr $build_folder

# Login to AWS ECR process
aws configure set aws_access_key_id $AWS_KEY
aws configure set aws_secret_access_key $AWS_SECRET
aws configure set default.region $aws_region
aws configure set default.output json

login="$(aws ecr get-login --no-include-email --region us-east-1)"
${login}

echo "AWS ECR LOGIN SUCCESSFULLY*******"
# Login to AWS ECR process

# Allow overriding the aws region from system
if [ "$aws_region" != "" ]; then
  aws_extra_flags="--region $aws_region"
else
  aws_extra_flags=""
fi

# Check that aws is installed
which aws > /dev/null || { echo 'ERROR: aws-cli is not installed' ; exit 1; }

# Connect into aws
$(aws ecr get-login --no-include-email $aws_extra_flags) || { echo 'ERROR: aws ecr login failed' ; exit 1; }

# Check that docker is installed and running
which docker > /dev/null && docker ps > /dev/null || { echo 'ERROR: docker is not running' ; exit 1; }

# Some Useful Debug
echo "tag $aws_ecr_repository_url_with_tag from $build_folder/Dockerfile"

# Build image
docker build -t $aws_ecr_repository_url_with_tag $build_folder

# docker tag $build_folder $aws_ecr_repository_url_with_tag

# Push image
docker push $aws_ecr_repository_url_with_tag
