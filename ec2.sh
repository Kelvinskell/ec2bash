#!/bin/bash

PS3=""
echo "Select an option: "
select option in 'Display running instances' 'Start an ec2 instance' 'Stop an ec2 instance' 'Terminate an ec2 instance'
do
	echo $option
done
