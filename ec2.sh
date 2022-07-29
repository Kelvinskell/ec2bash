#!/bin/bash


# Define Colours
Red='\033[1;31m'
Green='\033[1;32m'
Blue='\033[1;34m'
Cyan='\033[1;36m'
Purple='\033[1;35m'
NC='\033[0;m'


StartInstance() {
	for id in $*
	do
		aws ec2 --dry-run start-instances --instance-ids $id
	done
	exit $?
}


# Check if parameters are supplied
if [[ $# > 0 ]]
then
	# Valiidate parameters
	if [[ $1 =~ [1-4] ]]
	then
		option=$1
	fi

	# Validate Instance ids and collect them into an array
	for id in $*
	do
		if [[ $id =~ ^i- ]]
		then
			ids+=($id)
		fi
	done
fi

StartInstance ${ids[@]}





PS3=""
echo -e "${Blue}Select An EC2 Management Option Below: ${Cyan}"
select option in 'Display Running Instances' 'Start An EC2 Instance' 'Stop An EC2 Instance' 'Terminate An EC2 Instance'
do
	echo $option
done
