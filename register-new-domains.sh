#!/bin/bash
if ! [ -x "$(command -v docker)" ]; then
  echo 'Error: docker is not installed.' >&2
  exit 1
fi

source ./config.sh
domain_args=""
for domain in $@; do
  domains+=($domain)
  domain_args="$domain_args -d $domain"
done

if [ -d "$data_path/conf/live/$domains" ]; then
  read -p "Existing certs found for $domains. Continue and replace existing certificate? (y/N) " decision
  if [ "$decision" != "Y" ] && [ "$decision" != "y" ]; then
    exit
  fi
fi

echo "### Requesting Let's Encrypt certificate for $domains ..."
# Select appropriate email arg
case "$email" in
  "") email_arg="--register-unsafely-without-email" ;;
  *) email_arg="--email $email" ;;
esac

# Enable staging mode if needed
if [ $staging != "0" ]; then staging_arg="--staging"; fi

docker compose run --rm --entrypoint "\
  certbot certonly --dns-cloudflare \
    --dns-cloudflare-credentials /root/.secrets/cloudflare/cloudflare.ini \
    $staging_arg \
    $email_arg \
    $domain_args \
    --rsa-key-size $rsa_key_size \
    --agree-tos \
    --no-eff-email \
    --force-renewal" certbot
echo

echo "### Script finished! Note, no containers restarted or recreated."
