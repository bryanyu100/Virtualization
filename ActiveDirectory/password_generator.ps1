# Import the Active Directory module
Import-Module ActiveDirectory

# Initialize a variable for the list of users
$users = Get-ADUser -Filter *

# Read each user
foreach ($user in $users) {

    # Generate a password for the users
    Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Password" -Force)

}