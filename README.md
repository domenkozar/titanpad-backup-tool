Place titanpad_backup.sh in ~/titanpad/ and configure crontab as following::
	
	0 0 * * * ~/titanpad/titanpad_backup.sh -u <username> -p <password>

If you don't want to specify a password on the command line, create a file `~/titanpad/.auth` containing username and password:

``
MyUsername
MySecretPassword
``

Then use the `-a` option

	0 0 * * * ~/titanpad/titanpad_backup.sh -a ~/titanpad/.auth
