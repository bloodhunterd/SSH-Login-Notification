# SSH Login Notification

A script which sends a notification via email on every SSH login.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

To run this script you need a debian based system or equivalent and also Bash, Mailutils and dnsutils installed. A working MTA like [Exim](https://www.exim.org/) or equivalent is needed to send emails.

### Installing

Place this script and the configuration file into the **/etc/profile.d** folder.

## Deployment

The script is directly running without restarting any services or the server.

## Build With

* [Bash](https://wiki.ubuntuusers.de/Bash/)
* [Mailutils](https://mailutils.org/) - To send email notifications
* [dnsutils](https://packages.debian.org/de/buster/dnsutils) - To resolve IP's

## Authors

* [BloodhunterD](https://github.com/bloodhunterd)

## License

This project is licensed under the Unlicense License - see [LICENSE.md](https://github.com/bloodhunterd/ssh-login-notification/blob/master/LICENSE) file for details.
