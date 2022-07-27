#!/bin/bash

PS3=""
echo "Select An Option Below: "
select option in 'Display Running Instances' 'Start An EC2 Instance' 'Stop An EC2 Instance' 'Terminate An EC2 Instance'
do
	echo $option
done
