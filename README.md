# SSH Login Notification

[![Release](https://img.shields.io/github/v/release/bloodhunterd/ssh-login-notification?include_prereleases&style=for-the-badge)](https://github.com/bloodhunterd/ssh-login-notification/releases)
[![License](https://img.shields.io/github/license/bloodhunterd/ssh-login-notification?style=for-the-badge)](https://github.com/bloodhunterd/ssh-login-notification/blob/master/LICENSE)

[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/P5P51U5SZ)

A simple script which sends a notification via email on every SSH login.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.
See deployment for notes on how to deploy the project on a live system.

### Prerequisites

The script requires a [Debian](https://www.debian.org/index.de.html) based system, Mailutils and dnsutils installed.
A configured and working MTA like [Exim](https://www.exim.org/) or equivalent is also required to send mails.

### Installing

Place the script and the configuration file into the **/etc/profile.d** folder.

## Deployment

The script works instantly without restarting any services or the server.

## Build With

* [Bash](https://wiki.ubuntuusers.de/Bash/)
* [Mailutils](https://mailutils.org/) - To send email notifications
* [dnsutils](https://packages.debian.org/de/buster/dnsutils) - To resolve IP's

## Authors

* [BloodhunterD](https://github.com/bloodhunterd)

## License

This project is licensed under the MIT - see [LICENSE.md](https://github.com/bloodhunterd/ssh-login-notification/blob/master/LICENSE) file for details.
