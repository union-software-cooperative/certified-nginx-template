## Certified-Dockerised-Nginx-Reverse-Proxy Template
A fairly straightforward template for setting up Nginx reverse proxy with Let's Encrypt certificates obtained via DNS challenge with Cloudflare as the provider.

### What You Need To Do
- You need a Cloudflare API token with `Zone:Read` and `DNS:Edit` permission for all zones (doesn't work with single zones yet). Put your API token in `data/certbot/secrets/cloudflare.ini` - see the example file for guidance. Make sure to set restrictive permissions or you'll get complaints - `chmod 600 data/certbot/secrets/cloudflare.ini`.
- Make sure your Nginx container can forward requests to your web app. See the example file given for `docker-compose.override.yml` for simple deployments - this means mounting your webserver root dir with a Unix socket to your Nginx container or putting both containers on the same external network.
- Set up your Nginx config at `data/nginx/app.conf`. Use the example file as needed. Set your upstream to a container and port, or a Unix socket, depending what strategy you chose.
- Create and update `config.sh` from the example file with, at minimum, the domains you need to certify and your email address.
- Run the `init-letsencrypt.sh` script!

### If You're Not Using Cloudflare
You'll need to forge your own path. Override the image tag to set your own provider in docker-compose.yml. Check the documentation for that client to see how to set up and handle any secrets involved. In the init script, you'll need to change the flags in the initial certbot call.

### Thanks
This template was adapted from a Medium guide by @pentacent:
https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71
