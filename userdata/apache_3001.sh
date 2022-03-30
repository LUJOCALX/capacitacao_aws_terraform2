#!/bin/bash
sudo apt update
sudo apt install apache2 -y
sudo systemctl start apache2

sudo echo "# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 3001

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
" > /home/ubuntu/ports3001.conf


sudo echo "<VirtualHost *:3001>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>
"> /home/ubuntu/000-default3001.conf




sudo cp /etc/apache2/sites-enabled/000-default.conf /home/ubuntu/000-default.conf.original
sudo cp /home/ubuntu/000-default3001.conf /etc/apache2/sites-enabled/000-default.conf
sudo chmod 644 /etc/apache2/sites-enabled/000-default.conf

sudo cp /etc/apache2/ports.conf /home/ubuntu/ports.conf.original
sudo cp /home/ubuntu/ports3001.conf /etc/apache2/ports.conf
sudo chmod 644 /etc/apache2/ports.conf

sudo systemctl restart apache2 #SystemD
sudo service apache2 restart #SysVInit