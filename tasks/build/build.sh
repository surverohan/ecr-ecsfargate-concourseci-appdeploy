#!/bin/bash

set -euxo pipefail

pushd graphql-src/

mvn package -Dmaven.repo.local=.m2
cp target/*.jar ../build/graphql-poc.jar

    cd ../build/
	pwd
	ls
    echo "****************** BUILDING  ******************"
	cd  ci-pipeline/tasks/terraform
    echo "BUILDING terraform init..."
    terraform init
    echo "BUILDING  terraform plan......."
	terraform plan -var-file="terraform.tfvars"
    echo "BUILDING  terraform apply..............."
	terraform apply -auto-approve -var-file="terraform.tfvars"
	echo "BUILDING  terraform apply done !!!!!!!!!!!!!!!!!!!!!!!!"


popd

ls -lha build/
