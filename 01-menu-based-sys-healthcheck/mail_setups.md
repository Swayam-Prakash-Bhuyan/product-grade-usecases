I'll help you set up Postfix on your Ubuntu server to send emails. Here's a step-by-step guide:

## 1. Install Postfix

```bash
sudo apt update
sudo apt install postfix
```

During installation, you'll see a configuration screen:
- Select **"Internet Site"**
- Enter your server's fully qualified domain name (FQDN) or your domain name

## 2. Configure Postfix

Edit the main configuration file:

```bash
sudo nano /etc/postfix/main.cf
```

Key settings to configure:

```
myhostname = your-server.yourdomain.com
mydestination = localhost
relayhost =
inet_interfaces = loopback-only
inet_protocols = ipv4
```

## 3. Set Up SMTP Relay (Recommended)

For better deliverability, use an SMTP relay service (Gmail, SendGrid, etc.). Here's an example with Gmail:

```bash
sudo nano /etc/postfix/main.cf
```

Add/modify these lines:

```
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_tls_security_level = encrypt
```

Create the password file:

```bash
sudo nano /etc/postfix/sasl_passwd
```

Add your credentials:
```
[smtp.gmail.com]:587 your-email@gmail.com:your-app-password
```

Secure and hash the file:

```bash
sudo chmod 600 /etc/postfix/sasl_passwd
sudo postmap /etc/postfix/sasl_passwd
```

## 4. Restart Postfix

```bash
sudo systemctl restart postfix
sudo systemctl enable postfix
```

## 5. Test Sending Email

```bash
echo "Test email body" | mail -s "Test Subject" recipient@example.com
```

Or install `mailutils`:

```bash
sudo apt install mailutils
echo "Test message" | mail -s "Test" your-email@example.com
```

## Important Notes:

- **Gmail users**: Use an [App Password](https://myaccount.google.com/apppasswords), not your regular password
- **SPF/DKIM**: Configure these DNS records for better deliverability
- **Firewall**: Ensure port 587 (or 25) is open for outbound traffic
- **Logs**: Check `/var/log/mail.log` for troubleshooting
