#!/bin/sh

set -e

if [ ! -z ${DEBUG_MODE} ]
then
  if [ ${DEBUG_MODE} = "true" ]
  then
    echo "DEBUG MODE"
    set -x
  fi
fi

RED='\033[0;31m'



# "Building" terraform
export TF_IN_AUTOMATION="true"

echo "invoking upload to ecr process ......"

pwd
	ls

echo "new path ......"
ls -ltr graphql-artifact/

ls -ltr ci-pipeline/


cp graphql-artifact/graphql-poc.jar ci-pipeline/tasks/upload/

pwd
	ls

    echo "****************** BUILDING  ******************"
	cd  ci-pipeline/tasks/upload
	pwd
	ls
    echo "BUILDING terraform init..."
    terraform init
    echo "BUILDING  terraform plan......."
	terraform plan -var-file="terraform.tfvars"
    echo "BUILDING  terraform apply..............."
	terraform apply -auto-approve -var-file="terraform.tfvars"
	echo "BUILDING  terraform apply done !!!!!!!!!!!!!!!!!!!!!!!!"
	
	
	pwd
# Fail fast
set -e

# This is the order of arguments
build_folder= .
aws_ecr_repository_url_with_tag=077062247894.dkr.ecr.us-east-1.amazonaws.com/poctest:0.0.2
aws_region=us-east-1  
AWS_KEY=AKIARD4KESXLKY4HA4WW
AWS_SECRET=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

build_folder= .

echo " current pwd"
pwd



ls -ltr $build_folder


echo "final build file contents"


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


popd

ls -lha build/
