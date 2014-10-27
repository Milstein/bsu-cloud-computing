#!/bin/bash

aws cloudformation create-stack --stack-name zdv-test-stack --template-body file://aws.cloudformation.example.json --parameters ParameterKey=KeyName,ParameterValue=bcc_key
