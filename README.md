## Certified-Dockerised-Nginx-Reverse-Proxy Template
A fairly straightforward template for setting up Nginx reverse proxy with Let's Encrypt certificates obtained via DNS challenge with Cloudflare as the provider.

### What You Need To Do
- You need a Cloudflare API token with `Zone:Read` permission for all zones/domains that you'll need certificates for. Put your API token in `data/certbot/secrets/cloudflare.ini` - see the example file in the same directory for guidance. Make sure to set restrictive permissions or you'll get complaints - `chmod 600 data/certbot/secrets/cloudflare.ini`.
- Set up your overall `nginx.conf` file. You can use the example file at `data/nginx/nginx.conf.example` as a guide.
- Make sure your Nginx container can forward requests to your web app. See the example file given for `docker-compose.override.yml` for simple deployments - this means mounting your webserver root dir with a Unix socket to your Nginx container or putting both containers on the same external network.
- Configure your HTTP requests in `data/nginx/sites`. An `app.conf.example` is provided.
- Configure any stream traffic in `data/nginx/streams`.
- Create and update `config.sh` from the example file with, at minimum, the domains you need to certify and an email address.
- Run the `init-letsencrypt.sh` script!

### To Acquire New Certificates
`./register_new_domains.sh my.new.domain`

### To Immediately Delete A Certificate
Run `certbot delete --cert-name my.old.domain` within the certbot context. E.g. `docker compose run --rm --entrypoint "/bin/sh -c 'certbot delete --cert-name hk.uw.au'" certbot`.

### To Stop Renewing A Certificate
If you want to keep the current certificate but just stop renewing it, rename, move, or delete the renewal configuration file, e.g.: `rm /etc/letsencrypt/renewal/my.old.domain.conf` within certbot. (See `docker compose run ...` in previous paragraph.)

### If You're Not Using Cloudflare
You'll need to forge your own path. Override the image tag to set your own provider in docker-compose.yml. Check the documentation for that client to see how to set up and handle any secrets involved. In the init script, you'll need to change the flags in the initial certbot call.

### Thanks
This template was originally adapted from a Medium guide by @pentacent:
https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71
