# SSH Login Notification

[![Release](https://img.shields.io/github/v/release/bloodhunterd/SSH-Login-Notification?include_prereleases&style=for-the-badge)](https://gitlab.com/bloodhunterd-labs/tools/SSH-Login-Notification/-/releases)
[![License](https://img.shields.io/github/license/bloodhunterd/SSH-Login-Notification?style=for-the-badge)](https://gitlab.com/bloodhunterd-labs/tools/SSH-Login-Notification/-/blob/master/LICENSE)

The script makes sure that you are notified by email about every user login via SSH.

## Deployment

The script `ssh-login-notification.sh` only needs to be placed under `/etc/profile.d/` so that it is executed every time the user logs on via SSH.

### Requirements

If not already installed, the `dnsutils` and `mailutils` packages are needed to resolve IP to FQDN and send emails. It is assumed that a working MTA like [Exim](https://www.exim.org/) is installed.

## Configuration

The script need to be customized. All that is required is to create a file with the name `ssh-login-notification.conf`.

Please configure the following settings:

| Setting  | Description                             |
|----------|-----------------------------------------|
| MESSAGE  | A message that describes what happened. |
| RECEIVER | Any valid email address.                |
| SUBJECT  | A meaningful email subject.             |

### Example

~~~shell
MESSAGE="An SSH login was detected."
RECEIVER="example@example.com"
SUBJECT="SSH Login"
~~~

## Update

Please note the [changelog](https://gitlab.com/bloodhunterd-labs/tools/SSH-Login-Notification/-/blob/master/CHANGELOG.md) to check for configuration changes before updating.

## Authors

* [BloodhunterD](https://gitlab.com/BloodhunterD)

## License

This project is licensed under the MIT - see [LICENSE.md](https://gitlab.com/bloodhunterd-labs/tools/SSH-Login-Notification/-/blob/master/LICENSE) file for details.

## Funding

[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/bloodhunterd)

*[MTA]: Mail Transport Agent
*[SSH]: Secure Shell
