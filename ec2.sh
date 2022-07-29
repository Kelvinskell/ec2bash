#!/bin/bash

# Define Colours
Red='\033[1;31m'
Green='\033[1;32m'
Blue='\033[1;34m'
Cyan='\033[1;36m'
Purple='\033[1;35m'
NC='\033[0;m'


# Return the number of running and stopped instances
count() {
	for inst in $*
	do
		if [[ $(echo $inst |grep -w "running") ]]
		then
			run+=($inst)
		elif [[ $(echo $inst |grep -w "stopped") ]]
		then
			stop+=($inst)
		fi
	done
	echo ${#run[*]} ${#stop[*]}
}


StartInstance() {
	for id in $*
	do
		aws ec2 --dry-run start-instances --instance-ids $id
	done
	exit $?
}


StopInstance() {
	for id in $*
	do
		aws ec2 --dry-run stop-instances --instance-ids $id
	done
	exit $?
}


RebootInstance() {
	for id in $*
	do
		aws ec2 --dry-run reboot-instance --instance-ids $id
	done

	# Produce custom output since rebooot-instance command does not produce any output if successful
	if [[ $? == 0 ]]
	then
		echo "Instances successfully rebooted"
	fi
}


TerminateInstance() {
	for id in $*
	do
		aws ec2 --dry-run terminate-instances --instance-ids $id
	done
	exit $?
}


DescribeInstance() {
	local ids+=( $(aws ec2 describe-instances --output text |grep -w INSTANCES |awk '{print $8}') )
	local types+=( $(aws ec2 describe-instances --output text |grep -w INSTANCES |awk '{print $9}') ) 
	local vpcs+=( $(aws ec2 describe-instances --output text |grep -w INSTANCES |awk '{print $(NF)}') )
	local state+=( $( aws ec2 describe-instances --output text |grep -w STATE | awk '{print $3}') )
	local tags+=( $(aws ec2 describe-instances --output text |grep -w TAGS |grep -w Name |awk '{print $3}') )

	for (( i == 0; i < ${#ids[*]}; i++ ))
	do
		echo -e "Instance id: ${ids[$i]}"
		echo -e "Instance type: ${types[$i]}"
		echo -e "Instance State: ${state[$i]}"
		echo -e "VPC id: ${vpcs[$i]}"
		echo -e "Name tag: ${tags[$i]}\n"
	done

	# Display summary statistics
	runcount=$(count ${state[@]} |awk '{print $1}') 
	stopcount=$(count ${state[@]} |awk '{print $2}')
	echo -e "SUMMARY STATS"
	echo "TOTAL NUMBER OF INSTANCES -----> ${#ids[*]}"
	echo "RUNNING INSTANCES -----> " $runcount
	echo "STOPPED INSTANCES -----> " $stopcount
	exit $?
}


# Check if parameters are supplied
if [[ $# > 0 ]]
then
	# Valiidate parameters
	if [[ $1 =~ [1-5] ]]
	then
		option=$1
	fi

	# Validate Instance ids and collect them into an array
	for id in $*
	do
		if [[ $id =~ ^i-[a-z0-9]+{17} ]]
		then
			ids+=($id)
		fi
	done
fi

# Call ec2 functions based on supllied argument
case $option in

	1)
		StartInstance ${ids[@]}
		;;
	2)
		StopInstance ${ids[@]}
		;;
	3)
		TerminateInstance ${ids[@]}
		;;
	4)
		RebootInstance ${ids[@]}
		;;
	5)
		DescribeInstance
		;;
esac


PS3=""
echo -e "${Blue}Select An EC2 Management Option Below: ${Cyan}"
select option in 'Display Running Instances' 'Start An EC2 Instance' 'Stop An EC2 Instance' 'Terminate An EC2 Instance'
do
	echo $option
done
