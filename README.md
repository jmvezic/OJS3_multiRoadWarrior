# OJS3_multiRoadWarrior
Bash script for installing a user-defined amount of OJS3 installations on Debian 10. Great for setting up a workshop where multiple people will require their own installation of OJS3.

## Instructions

Run `bash ojsWarrior.sh` as root from a fresh Debian 10 installation, enter the desired MySQL root password and the desired amount of OJS3 installations. The script will automatically:

1. Install prerequisite packages for OJS3
2. Configure MySQL with an `ojs` user
3. Download and install OJS3 for a user-set amount of times under `/var/www/html/journal1`, `/var/www/html/journal2`, `var/www/html/journal3`, etc.
4. The installations are available on `http://your.domain./journal1`, `http://your.domain./journal2`, etc.

## Notes

- Each OJS3 installation has its own database
- All installations use the same MySQL user: `ojs` with a password `ojsPass1234`
- Username for each installation is the journal number, e.g. `journal1`, `journal2`, etc.
- Password for each installation is `ojsPass1234`
