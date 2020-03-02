#!/bin/bash

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


popd

ls -lha build/
