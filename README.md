## Certified-Dockerised-Nginx-Reverse-Proxy Template
A fairly straightforward template for setting up Nginx reverse proxy with Let's Encrypt certificates obtained via DNS challenge with Cloudflare as the provider.

### What You Need To Do
- You need a Cloudflare API token with `Zone:Read` and `DNS:Edit` permission for all zones (doesn't work with single zones yet). Put your API token in `data/certbot/secrets/cloudflare.ini` - see the example file for guidance. Make sure to set restrictive permissions or you'll get complaints - `chmod 600 data/certbot/secrets/cloudflare.ini`.
- Update `docker-compose.override.yml` - make sure the Nginx container will be on the same network as any containers that it's the reverse proxy for.
- Set up your Nginx config at `data/nginx/app.conf`. Use the example file as needed.
- Update `init-letsencrypt.sh` with the domains you need to certify and your email address.

### If You're Not Using Cloudflare
You'll need to forge your own path. Override the image tag to set your own
provider in docker-compose.yml. Check the documentation for that client to see
how to set up and handle any secrets involved. In the init script, you'll need
to change the flags in the initial certbot call.
