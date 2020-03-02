#!/bin/bash

set -euxo pipefail

pushd graphql-src/

mvn package -Dmaven.repo.local=.m2
cp target/*.jar ../ci-pipeline/tasks/build/graphql-poc.jar
#	pwd
#	ls
#	cd ../
	
#	pwd
#	ls
#	cd ../

#	pwd
#	ls
#    cd ../build/
#	pwd
#	ls
    echo "****************** BUILDING  ******************"
	cd  ../ci-pipeline/tasks/build
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
