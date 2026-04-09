#!/bin/bash

set -x

# Make apt fully non-interactive
export DEBIAN_FRONTEND=noninteractive



echo ">> user-data-started :+1:";

cd /home/ubuntu/;



# Variables
SQUID_USER="prod-user"
SQUID_PASS="QViUkSCNZUKuA1232SGRDSSD"
SQUID_DIR="/etc/squid"
PASS_FILE="$SQUID_DIR/passwd"
SQUID_CONF="$SQUID_DIR/squid.conf"

echo ">>> Updating system..."
apt-get update -y

echo ">>> Installing Squid and apache2-utils (for htpasswd)..."
DEBIAN_FRONTEND=noninteractive apt-get install -y squid apache2-utils

echo ">>> Ensuring squid directory exists..."
sudo mkdir -p "$SQUID_DIR"
sudo mkdir -p /var/log/squid
sudo touch /var/log/squid/access.log
sudo touch /var/log/squid/cache.log
sudo chown -R proxy:proxy /var/log/squid
sudo chmod -R 755 /var/log/squid



echo ">>> Backing up existing squid.conf (if exists)..."
if [ -f "$SQUID_CONF" ]; then
  cp "$SQUID_CONF" "$SQUID_CONF.bak.$(date +%s)"
fi

echo ">>> Writing new Squid config..."
cat > "$SQUID_CONF" <<EOF
http_port 8080
cache_mem 256 MB

auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm Squid Basic Authentication
auth_param basic credentialsttl 2 hours

acl auth_users proxy_auth REQUIRED
http_access allow auth_users

# Deny all other traffic
http_access deny all
EOF

htpasswd -b -c "$PASS_FILE" "$SQUID_USER" "$SQUID_PASS"

echo ">>> Setting permissions on password file..."
chown proxy:proxy "$PASS_FILE"
chmod 640 "$PASS_FILE"

echo ">>> Restarting Squid... "
systemctl restart squid
systemctl enable squid

echo ">>> Squid proxy setup complete! :+1:"
echo "You can now connect using:"

sudo cat /etc/squid/passwd

sudo systemctl status squid



TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
PUBLIC_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)

echo "Public IP is: $PUBLIC_IP"

echo " curl -x http://$SQUID_USER:$SQUID_PASS@$PUBLIC_IP:8080 https://ipinfo.io"

# sudo cat /var/log/cloud-init-output.log