# Description
**Ec2bash** is a robust bash script designed to automate to a very large extent, the management of AWS EC2 instances.
Ec2bash streamlines and automates common instance management tasks such as:
- Starting an instance
- Stopping an instance
- Rebooting an Instance
- Terminating an instance

This script also describes your available instances while providing concise output, with a succint summary of instance information.

This script is designed to run in two modes:
- Interactive mode
- Non-interactive mode
These features make it even more robust, dynamic and adaptable to different use cases. 

# Usage
## Interactive mode
To run this script in an interactive mode:
- Clone this repository 
- Navigate to the repository directory
- Execute the ec2.sh script ( `bash ec2.sh` )
- Follow the prompts

## Non-interactive mode
To run this script in a non-interactive mode, you have to supply arguments while executing the script.
The first argument supplied is expected to be a valid option (ranging from 1 to 5).
The second to the nth arguments are expected to be the instance ids upon which the script will act.

*For example, to start an instance or instances, the following command would be executed: `bash ec2.sh 1 i-0b15946639e1cb593 i-0ed62084fed3d96c6`.*
In the above example, the parameter 1 represents an option for starting instances, while other parameters are the instance ids upon which the script will act on.

### Below is a brief representation of valid options
- 1: Start an instance
- 2: Stop an instance
- 3: Reboot an instance
- 4: Terminate an instance
- 5: Describe instances


