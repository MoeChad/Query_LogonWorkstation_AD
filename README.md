# Query LogonWorkstations property in AD
This Script is designed to help with administration of user accounts that contain DNS names of computers that are disabled or have been removed from Active Directory

### Functionality
1. Prompts for username
2. The "LogonWorkstations" property is queried in AD and is stored as an array
3. Each machine in the new array is then queried against the "Enabled" property
4. A CSV file is created with the machine name and with it's associated "Enabled" value

### Example
``` Get-LogonWorkstations -Username ``` 


### Notes
- This script does have error handling with Try/Catch for the username input
- This script automatically returns a $false value for InAD if the machine isn't found at all using Try/Catch
