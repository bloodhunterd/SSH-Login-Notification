# SSH Login Notification

[![Release](https://img.shields.io/github/v/release/bloodhunterd/SSH-Login-Notification?include_prereleases&style=for-the-badge)](https://gitlab.com/bloodhunterd-labs/tools/SSH-Login-Notification/-/releases)
[![License](https://img.shields.io/github/license/bloodhunterd/SSH-Login-Notification?style=for-the-badge)](https://gitlab.com/bloodhunterd-labs/tools/SSH-Login-Notification/-/blob/master/LICENSE)

The script makes sure that you are notified by email and/or webhook about every user login via SSH.

## Deployment

The script `ssh-login-notification.sh` only needs to be placed under `/etc/profile.d/` so that it is executed every time the user logs on via SSH.

### Requirements

If not already installed, the `dnsutils` package is needed to resolve IP to FQDN.

For email notifications the `mailutils` package is needed. It is assumed that a working MTA like [Exim](https://www.exim.org/) is installed.

For webhook notifications the `curl` package is needed.

## Configuration

The script need to be customized. All that is required is to create a file with the name `ssh-login-notification.conf`.

Please configure the following settings:

| Setting              | Description                                                         | Default                |
|----------------------|---------------------------------------------------------------------|------------------------|
| MESSAGE              | A message that describes what happened.                             |                        |
| MAIL_ENABLED         | Send email notification (`true` or `false`).                        | `true`                 |
| RECEIVER             | Any valid email address.                                            |                        |
| SUBJECT              | A meaningful email subject.                                         |                        |
| WEBHOOK_ENABLED      | Send webhook notification (`true` or `false`).                      | `false`                |
| WEBHOOK_URL          | The webhook URL.                                                    |                        |
| WEBHOOK_METHOD       | The HTTP method.                                                    | `POST`                 |
| WEBHOOK_CONTENT_TYPE | The content type of the payload.                                    | `application/json`     |
| WEBHOOK_HEADERS      | Optional array of additional HTTP headers.                          |                        |
| WEBHOOK_TEMPLATE     | The payload template, see [placeholders](#webhook-placeholders).    | `{"text":"{{TEXT}}"}`  |

Email and webhook can be enabled independently, so either one or both are used.

### Webhook placeholders

The following placeholders are replaced in `WEBHOOK_TEMPLATE`. The values are escaped for use inside JSON strings.

| Placeholder       | Description                                |
|-------------------|--------------------------------------------|
| `{{TEXT}}`        | The complete notification text (as email). |
| `{{MESSAGE}}`     | The configured message.                    |
| `{{SUBJECT}}`     | The configured subject.                    |
| `{{TIME}}`        | Date and time of the login.                |
| `{{USER}}`        | The logged in user.                        |
| `{{SERVER_NAME}}` | Short hostname of the server.              |
| `{{SERVER_IP}}`   | IP address of the server.                  |
| `{{SERVER_PORT}}` | SSH port of the server.                    |
| `{{SERVER_FQDN}}` | FQDN of the server.                        |
| `{{CLIENT_IP}}`   | IP address of the client.                  |
| `{{CLIENT_FQDN}}` | FQDN of the client.                        |

### Examples

Email only:

~~~shell
MESSAGE="An SSH login was detected."
RECEIVER="example@example.com"
SUBJECT="SSH Login"
~~~

Webhook only (e.g. Slack, Mattermost or Rocket.Chat):

~~~shell
MESSAGE="An SSH login was detected."
MAIL_ENABLED=false
WEBHOOK_ENABLED=true
WEBHOOK_URL="https://hooks.example.com/services/XXX"
~~~

Email and webhook with custom template and authorization header:

~~~shell
MESSAGE="An SSH login was detected."
RECEIVER="example@example.com"
SUBJECT="SSH Login"
WEBHOOK_ENABLED=true
WEBHOOK_URL="https://example.com/webhook"
WEBHOOK_HEADERS=("Authorization: Bearer XXX")
WEBHOOK_TEMPLATE='{"message":"{{MESSAGE}}","user":"{{USER}}","server":"{{SERVER_FQDN}}","client":"{{CLIENT_IP}}","time":"{{TIME}}"}'
~~~

Discord:

~~~shell
WEBHOOK_TEMPLATE='{"content":"{{TEXT}}"}'
~~~

## Update

Please note the [changelog](https://gitlab.com/bloodhunterd-labs/tools/SSH-Login-Notification/-/blob/master/CHANGELOG.md) to check for configuration changes before updating.

## Authors

* [BloodhunterD](https://gitlab.com/BloodhunterD)

## License

This project is licensed under the MIT - see [LICENSE.md](https://gitlab.com/bloodhunterd-labs/tools/SSH-Login-Notification/-/blob/master/LICENSE) file for details.

## Funding

[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/bloodhunterd)

*[FQDN]: Fully Qualified Domain Name
*[MTA]: Mail Transport Agent
*[SSH]: Secure Shell
