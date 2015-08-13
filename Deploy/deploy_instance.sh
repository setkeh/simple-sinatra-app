#!/bin/bash

##########
# Config #
##########

AWS="aws ec2" 			# AWS Commandline tools
AMI="ami-e9d091d3" 		# Ubuntu HVM Sydney
PRODNIC="eni-4f0c752b" 		# Production Network interface
DEVNIC="eni-4f0c752b" 		# Development Network Interface
PRODSECURID="sg-2808604d" 	# Production Security Group
DEVSECURID="sg-3e08605b" 	# Development Security Group
PRODSUBNET="subnet-237aad46"	# Production Subnet ID
DEVSUBNET="subnet-237aad46"	# Development Subnet ID
INSTANCE="t2.micro"		# Instance Size
PRODCOUNT="1"			# Number of Production Instances to Create
DEVCOUNT="1"			# Bumber of Development Instances to Create
KEYPAIR="Laptop"		# SSH Keypair name as it appears in AWS Console

##########
# Script #
##########

function r {
  if [ $1 == dev ]
  then
    dev

  elif [ $1 == prod ]
  then
    prod

  elif [ $1 == key ]
  then
    key

  else
    help
  fi
}

function dev {
  $AWS run-instances --image-id $AMI --count $DEVCOUNT --instance-type $INSTANCE --key-name $KEYPAIR --security-group-ids $DEVSECURID --subnet-id $DEVSUBNET
}

function prod {
  $AWS run-instances --image-id $AMI --count $PRODCOUNT --instance-type $INSTANCE --key-name $KEYPAIR --security-group-ids $PRODSECURID --subnet-id $PRODSUBNET
}

function key {
 $AWS create-key-pair --key-name $KEYPAIR --query 'KeyMaterial' --output text > ${HOME}/.ssh/$KEYPAIR.pem
}

function help {
  echo "Please Specify Enviroment to Deploy"
  echo "Valid Opts are dev, prod and key"
}

r $1
