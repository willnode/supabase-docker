# Supabase Docker

A simple Docker setup for Supabase.

## Features

- Remove some unnecessary services, including `realtime`, `storage`, `vector`, `supavisor` and `function`.
- Add support for OAuth providers.
- Add support for EMail Template.
- Use external database.

## Getting started

### Prerequisites

- Docker
- Docker Compose
- Git

### Installation

```bash
git clone https://github.com/willnode/supabase-docker.git
cd supabase-docker
cp .env.example .env
# Edit .env file to your needs

# Start Supabase
docker compose up -d

# Stop Supabase
docker compose down
```

### Usage

After running `docker compose up -d`, you can access Supabase at http://127.0.0.1:8000.

## Configuration

You can configure Supabase by editing the `.env` file.

### Basic Configuration

- `SITE_URL`: The URL of your Application.
- `API_EXTERNAL_URL`: The URL of your Supabase Instance.

### Auth Provider

Add OAuth provider to auth section of  `docker-compose` file. For example, to add Github OAuth provider:

```yaml
# Github OAuth config in auth.enviroment
GOTRUE_EXTERNAL_GITHUB_ENABLED: true
GOTRUE_EXTERNAL_GITHUB_CLIENT_ID: ${GITHUB_CLIENT_ID}
GOTRUE_EXTERNAL_GITHUB_SECRET: ${GITHUB_CLIENT_SECRET}
GOTRUE_EXTERNAL_GITHUB_REDIRECT_URI: ${AUTH_REDIRECT_URL}
```

Note that you need to set `GITHUB_CLIENT_ID` and `GITHUB_CLIENT_SECRET` in your `.env` file.

After adding the provider, You can use the API to verify the configuration of your OAuth providers:

```bash
curl 'https://<PROJECT_REF>.supabase.co/auth/v1/settings' \
-H "apikey: <ANON_KEY>" \
-H "Authorization: Bearer <ANON_KEY>"
```

### SMTP

Like the official Supabase, you can use SMTP to send emails. In your `.env` file, add the following:

```shell
SMTP_ADMIN_EMAIL=
SMTP_HOST=
SMTP_PORT=
SMTP_USER=
SMTP_PASS=
SMTP_SENDER_NAME=
```

See [Supabase SMTP](https://supabase.com/docs/guides/auth/auth-smtp) for more details.

### Email Templates

You can customize the email templates by editing the files in `./docker-compose.yml`.


```yml
GOTRUE_MAILER_TEMPLATES_RECOVERY: ${MAILER_TEMPLATES_RECOVERY}
GOTRUE_MAILER_TEMPLATES_INVITE: ${MAILER_TEMPLATES_INVITE}
GOTRUE_MAILER_TEMPLATES_CONFIRMATION: ${MAILER_TEMPLATES_CONFIRMATION}
GOTRUE_MAILER_TEMPLATES_MAGIC_LINK: ${MAILER_TEMPLATES_MAGIC_LINK}
GOTRUE_MAILER_TEMPLATES_EMAIL_CHANGE: ${MAILER_TEMPLATES_EMAIL_CHANGE}
```

Set your environment value in `.env`:

```shell
MAILER_TEMPLATES_INVITE="https://example.com/templates/invite.html"
MAILER_TEMPLATES_CONFIRMATION="https://example.com/templates/confirm.html"
MAILER_TEMPLATES_RECOVERY="https://example.com/templates/recovery.html"
MAILER_TEMPLATES_MAGIC_LINK="https://example.com/templates/magic-link.html"
MAILER_TEMPLATES_EMAIL_CHANGE="https://example.com/templates/email-change.html"
```

### Other Configuration

API Keys, Secrets, and other configurations can be found in the official Supabase documentation. Make sure to update your `.env` file accordingly.

See [Docker Configuration](https://supabase.com/docs/guides/self-hosting/docker) for more details.


## Development

All development is done in the `main` branch.
There is a `develop` docker file for development. You can override the `docker-compose.yml` file to use it:

```
docker compose -f docker-compose.yml -f ./dev/docker-compose.dev.yml up
```

##  Deploy in Dokploy

[Dokploy](https://dokploy.com/) is a stable deployment platform for Docker applications. It is a simple way to deploy your Docker application to the cloud.

Dokploy provide some [templates](https://docs.dokploy.com/docs/core/templates) for all sort of Docker applications. we can use it to deploy Supabase.

If you want some customization, you can deploy through your `docker-compose.yml` file. Here is an [example](./docker-compose.dokploy.yml).

Here is the process to deploy Supabase from `docker-compose.yml` file.
1. Create a new project in Dokploy.
2. Create a Compose service in project.
3. Configure the deployment.
- Provider: set your github repo in github provider. or you can paste the contents of `./docker-compose.dokploy.yml` in raw provider.
- Environment: paste the contents of `./.env` in environment.
- Volumes: add all of volume files in volumes setting. for example: 
  - Content: content of [vector.sql](./volumes/logs/vector.yml)
  - Path: set to `/volumes/logs/vector.yml`
- Docker links: enable `Isolate Deployment` in Utilities configuration.
- Domains: set your domain in domains.
4. Deploy.

## License

[MIT](https://choosealicense.com/licenses/mit/)

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

