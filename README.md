# OJS3_multiRoadWarrior
Bash script for installing a user-defined amount of OJS3 installations on Debian 10. Great for setting up a workshop where multiple people will require their own installation of OJS3.

:warning: **This script creates an unsafe environment and should only be used for purposes of demonstrating OJS to a limited audience**

## Instructions

Run `bash roadWarrior.sh` as root from a fresh Debian 10 installation and provide:

- the desired MySQL root password
- the desired amount of OJS3 installations
- the desired specific OJS3 version (or use the default)

The script will automatically:

1. Install prerequisite packages for OJS3
2. Configure MySQL with an `ojs` user
3. Download and install OJS3 for a user-set amount of times under `/var/www/html/journal1`, `/var/www/html/journal2`, `/var/www/html/journal3`, etc.
4. The installations are available on `http://your.ip/journal1`, `http://your.ip/journal2`, etc.

## Notes

- Each OJS3 installation has its own database
- All installations use the same MySQL user: `ojs` with a password `ojsPass1234`
- Username for each installation is the journal number, e.g. `journal1`, `journal2`, etc.
- Password for each installation is `ojsPass1234`
- The script sets the `base_url` parameter in `config.inc.php` by the result of `hostname -I` command. If you have a domain, it's safer to change the first line of `roadWarrior.sh` to `ip="your.domain.name"`
