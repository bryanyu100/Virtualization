# Initialize the variable for the user list
$users = Get-ADUser -Filter *

# Reading each user
foreach ($user in $users) {

    # Initialize each user's email
    $email = $user.SamAccountName

    # Display of each user's email
    Write-Host "$email@example.com"

    # Assign the email to each user
    Set-ADUser -Identity $user -EmailAddress "$email@example.com"

}