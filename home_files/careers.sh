#!/usr/bin/env sh
#
# Resolve the sub-domain from either an environment variable or the first
# positional argument.
#
#   subdomain=bob ./careers.sh     # via env-var
#   ./careers.sh bob               # via 1st arg
#   careers bob                    # after you add the alias below
#

subdomain="${subdomain:-$1}"

if [ -z "$subdomain" ]; then
  printf '❌  Error: SUBDOMAIN is not set!\n'
  printf '    Usage: subdomain=bob ./careers.sh  – or – ./careers.sh bob\n'
  exit 1
fi

domain="$subdomain.careers.hibob.com"

# Grab the first IPv4 address returned by dig
ip_address="$(dig +short A "$domain" | head -n 1)"

if [ -z "$ip_address" ]; then
  printf '❌  Failed to retrieve IPv4 address for %s\n' "$domain"
  exit 1
fi

# Update /etc/hosts (needs sudo privileges)
sudo sh -c "grep -v '\s$domain\$' /etc/hosts > /etc/hosts.tmp &&
            printf '%s %s\n' '$ip_address' '$domain' >> /etc/hosts.tmp &&
            mv /etc/hosts.tmp /etc/hosts"

printf '✅  Added: %s %s to /etc/hosts\n' "$ip_address" "$domain"

# Launch the frontend
subdomain="$subdomain" npm run careers
