# Author : Bryan Yu

# TUTORIAL - Export Active Directory Users to Zimbra Server

*NOTE : You need to have Active Directory users in one department (OU/Organization Unit) for it to work perfectly.

## Step 1 : Data Modification
In my version of the `autoprov.txt` script, I added data examples that give an insight of what your script should look like, such as the password, domain, etc. But the
data in my script example could be different for you, as my Active Directory can be different from yours.

So make sure that you don't execute the script right away because it won't export your AD users to Zimbra.

## Step 2 : The Right Directory
In order for the `autoprov.txt` to function correctly, make sure that the script file is in the `/opt/zimbra/bin/` directory of your Zimbra server.

## Step 3 : The Execution
After saving your script in the right directory, run the `sudo ./zmprov < autoprov.txt` command to execute it.
Then, restart your Zimbra service with the `sudo service zimbra restart` command.

Start the service with the `sudo service zimbra start` command.

After you wait about 5 minutes, refresh your admin center page and you'll see that the users are created.
