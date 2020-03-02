#!/bin/bash

echo "invoking upload to ecr process ......"

pwd
	ls
	
cp /graphql-artifact/*.jar /ci-pipeline/tasks/upload/graphql-poc.jar

pwd
	ls

    echo "****************** BUILDING  ******************"
	cd  /ci-pipeline/tasks/upload
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
