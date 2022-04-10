#!/bin/bash
sudo apt update
sudo apt install apache2 -y
sudo systemctl start apache2

# sudo echo "# If you just change the port or add more ports here, you will likely also
# # have to change the VirtualHost statement in
# # /etc/apache2/sites-enabled/000-default.conf

# Listen 3003

# <IfModule ssl_module>
#         Listen 443
# </IfModule>

# <IfModule mod_gnutls.c>
#         Listen 443
# </IfModule>

# # vim: syntax=apache ts=4 sw=4 sts=4 sr noet
# " > /home/ubuntu/ports3003.conf

# sudo echo "<VirtualHost *:3003>
#         # The ServerName directive sets the request scheme, hostname and port that
#         # the server uses to identify itself.

#         ServerAdmin webmaster@localhost
#         DocumentRoot /var/www/html

#         # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
#         # error, crit, alert, emerg.
#         # It is also possible to configure the loglevel for particular
#         # modules, e.g.
#         #LogLevel info ssl:warn

#         ErrorLog \${APACHE_LOG_DIR}/error.log
#         CustomLog \${APACHE_LOG_DIR}/access.log combined

#         # For most configuration files from conf-available/, which are
#         # enabled or disabled at a global level, it is possible to
#         # include a line for only one particular virtual host. For example the
#         # following line enables the CGI configuration for this host only
#         # after it has been globally disabled with "a2disconf".
#         #Include conf-available/serve-cgi-bin.conf
# </VirtualHost>
# "> /home/ubuntu/000-default3003.conf


# sudo echo "
# #
# # /etc/sysctl.conf - Configuration file for setting system variables
# # See /etc/sysctl.d/ for additional system variables.
# # See sysctl.conf (5) for information.
# #

# #kernel.domainname = example.com

# # Uncomment the following to stop low-level messages on console
# #kernel.printk = 3 4 1 3

# ##############################################################3
# # Functions previously found in netbase
# #

# # Uncomment the next two lines to enable Spoof protection (reverse-path filter)
# # Turn on Source Address Verification in all interfaces to
# # prevent some spoofing attacks
# #net.ipv4.conf.default.rp_filter=1
# #net.ipv4.conf.all.rp_filter=1

# # Uncomment the next line to enable TCP/IP SYN cookies
# # See http://lwn.net/Articles/277146/
# # Note: This may impact IPv6 TCP sessions too
# #net.ipv4.tcp_syncookies=1

# # Uncomment the next line to enable packet forwarding for IPv4
# #net.ipv4.ip_forward=1

# # Uncomment the next line to enable packet forwarding for IPv6
# #  Enabling this option disables Stateless Address Autoconfiguration
# #  based on Router Advertisements for this host
# #net.ipv6.conf.all.forwarding=1
# # Lastly apply changes
# # sudo /sbin/sysctl -p
# "> /home/ubuntu/sysctl_apache.conf


sudo echo "<!doctype html>
<html lang=\"en\">
  <head>
    <meta charset=\"utf-8\">
    <title>Servidor Apache 3</title>
    <meta name=\"description\" content=\"Servidor Apache 3\">
  </head>
  <body>
    <h1 style=\"background-color:green;color:white;\">Servidor Apache 3</h1>
  </body>
</html>" > /var/www/html/index.html


# sudo cp /etc/sysctl.conf /home/ubuntu/sysctl.conf.original
# sudo cp /home/ubuntu/sysctl_apache.conf /etc/sysctl.conf
# sudo chmod 644 /etc/sysctl.conf
# sudo chmod 644 /var/www/html/index.html
# # Digite o seguinte comando para recarregar as configurações dos arquivos de
# # configuração sem reinicializar.
# sudo /sbin/sysctl -p

# sudo cp /etc/apache2/sites-enabled/000-default.conf /home/ubuntu/000-default.conf.original
# sudo cp /home/ubuntu/000-default3003.conf /etc/apache2/sites-enabled/000-default.conf
# sudo chmod 644 /etc/apache2/sites-enabled/000-default.conf

# sudo cp /etc/apache2/ports.conf /home/ubuntu/ports.conf.original
# sudo cp /home/ubuntu/ports3003.conf /etc/apache2/ports.conf
# sudo chmod 644 /etc/apache2/ports.conf

sudo systemctl restart apache2 #SystemD
sudo service apache2 restart #SysVInit
