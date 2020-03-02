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
errors=0

    echo "****************** BUILDING  ******************"
	cd  ci-pipeline/tasks/terraform
    echo "BUILDING terraform init..."
    terraform init
    echo "BUILDING  terraform plan......."
	terraform plan
    echo "BUILDING  terraform apply..............."
	terraform apply -auto-approve
	echo "BUILDING  terraform apply done !!!!!!!!!!!!!!!!!!!!!!!!"