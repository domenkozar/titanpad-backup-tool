# titanpad-backup-tool

Make backups of a [titanpad](https://github.com/titanpad/titanpad) subdomain.

<!-- BEGIN-MARKDOWN-TOC -->
* [Usage](#usage)
* [cronjob](#cronjob)
* [Authentication](#authentication)
<!-- END-MARKDOWN-TOC -->

## Usage

```
Usage: ./titanpad_backup.sh [-hx] -d <subdomain> {-u <user> -p <password> | -a <user-password-file>}
	-h	This usage note
	-x	Delete backups older than 30 days
	-d	Subdomain to backup
	-u	Username
	-p	Password
	-a	File containing Username (first line) and Password (second line)
```

## cronjob

Place titanpad_backup.sh in ~/titanpad/ and configure crontab as following::

	0 0 * * * ~/titanpad/titanpad_backup.sh -u <username> -p <password>

## Authentication

If you don't want to specify a password on the command line, create a file `~/titanpad/.auth` containing username and password:

```
MyUsername
MySecretPassword
```

Then use the `-a` option

	0 0 * * * ~/titanpad/titanpad_backup.sh -a ~/titanpad/.auth
