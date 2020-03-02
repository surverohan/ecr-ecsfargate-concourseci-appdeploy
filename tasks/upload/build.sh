#!/bin/bash

echo "invoking upload to ecr process ......"
# Check that the application environment is set
if [ ! -n "${ENVIRONMENT_NAME}" ]; then
    echo "The ENVIRONMENT_NAME environment variable must be set"
    exit 1
fi
if [ ! -n "${APPLICATION_NAME}" ]; then
    echo "The APPLICATION_NAME environment variable must be set"
    exit 1
fi

#
# Get the build version
#
BUILD_VERSION_FILE="./graphql-artifact/version"
if [ ! -f ${BUILD_VERSION_FILE} ]; then
    echo "${BUILD_VERSION_FILE} does not exists"
    exit 1
fi
BUILD_VERSION=$(cat ${BUILD_VERSION_FILE})

mkdir ./bundle
pushd ./bundle

pwd
	ls
	
cp ../graphql-artifact/*.jar ../ci-pipeline/tasks/upload/graphql-poc.jar

pwd
	ls

    echo "****************** BUILDING  ******************"
	cd  ../ci-pipeline/tasks/upload
	pwd
	ls
    echo "BUILDING terraform init..."
    terraform init
    echo "BUILDING  terraform plan......."
	terraform plan -var-file="terraform.tfvars"
    echo "BUILDING  terraform apply..............."
	terraform apply -auto-approve -var-file="terraform.tfvars"
	echo "BUILDING  terraform apply done !!!!!!!!!!!!!!!!!!!!!!!!"


popd

ls -lha build/
