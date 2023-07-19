#!/bin/bash

# Inputs are 
# secret_name=$1
# k8s_context=$2
# secret_file_path=$3
# Output is 
# a kubernetes secret created with the content of the file

source ./log_util.sh

secret_name=$1
k8s_context=$2
secret_file_path=$3

export SCRIPT_NAME="create_secret.sh"

log "$SCRIPT_NAME is running"

kubectl config use-context $k8s_context

kubectl create secret generic $secret_name --from-file=$secret_file_path

warning "File created in context $k8s_context, context is still switched."

log "$SCRIPT_NAME is finished"