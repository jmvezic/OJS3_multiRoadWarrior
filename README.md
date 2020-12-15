# OJS3_multiRoadWarrior
Bash script for installing a user-defined amount of **latest unstable** OJS3 installations on a fresh Debian 10 image from https://github.com/pkp/ojs master branch.

:warning: This branch (**dev**) installs an unstable development version from the https://github.com/pkp/ojs master branch. If you want to install a stable version, check out the **master** branch of this repo.

:warning: **This script creates an unsafe environment and should only be used for purposes of demonstrating OJS to a limited audience**

## Instructions

Run `bash roadWarrior.sh` as root from a fresh Debian 10 image and provide:

- the desired MySQL root password
- the desired amount of OJS3 installations

The script will automatically:

1. Install prerequisite packages for OJS3
2. Configure MySQL with an `ojs` user
3. Download and install OJS3, along with composer and npm dependancies, for a user-set amount of times under `/var/www/html/journal1`, `/var/www/html/journal2`, `/var/www/html/journal3`, etc.
4. The installations are available on `http://your.ip/journal1`, `http://your.ip/journal2`, etc.

## Notes

- Each OJS3 installation has its own database
- All installations use the same MySQL user: `ojs` with a password `ojsPass1234`
- Username for each installation is the journal number, e.g. `journal1`, `journal2`, etc.
- Password for each installation is `ojsPass1234`
- The script sets the `base_url` parameter in `config.inc.php` by the result of `hostname -I` command. If you have a domain, it's safer to change the first line of `roadWarrior.sh` to `ip="your.domain.name"`
