#!/bin/bash

# Enable strict mode
set eo pipefail

PS3=""
echo "Select An EC2 Management Option Below: "
select option in 'Display Running Instances' 'Start An EC2 Instance' 'Stop An EC2 Instance' 'Terminate An EC2 Instance'
do
	echo $option
done
