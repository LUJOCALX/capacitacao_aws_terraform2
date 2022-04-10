#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx

# sudo echo "##
# # You should look at the following URL's in order to grasp a solid understanding
# # of Nginx configuration files in order to fully unleash the power of Nginx.
# # https://www.nginx.com/resources/wiki/start/
# # https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/
# # https://wiki.debian.org/Nginx/DirectoryStructure
# #
# # In most cases, administrators will remove this file from sites-enabled/ and
# # leave it as reference inside of sites-available where it will continue to be
# # updated by the nginx packaging team.
# #
# # This file will automatically load configuration files provided by other
# # applications, such as Drupal or Wordpress. These applications will be made
# # available underneath a path with that package name, such as /drupal8.
# #
# # Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
# ##

# # Default server configuration
# #
# server {
#         listen 3400 default_server;
#         listen [::]:3400 default_server;

#         # SSL configuration
#         #
#         # listen 443 ssl default_server;
#         # listen [::]:443 ssl default_server;
#         #
#         # Note: You should disable gzip for SSL traffic.
#         # See: https://bugs.debian.org/773332
#         #
#         # Read up on ssl_ciphers to ensure a secure configuration.
#         # See: https://bugs.debian.org/765782
#         #
#         # Self signed certs generated by the ssl-cert package
#         # Don't use them in a production server!
#         #
#         # include snippets/snakeoil.conf;

#         root /var/www/html;

#         # Add index.php to the list if you are using PHP
#         index index.html index.htm index.nginx-debian.html;

#         server_name _;

#         location / {
#                 # First attempt to serve request as file, then
#                 # as directory, then fall back to displaying a 404.
#                 try_files \$uri  \$uri/ =404;
#         }

#         # pass PHP scripts to FastCGI server
#         #
#         #location ~ \.php$ {
#         #       include snippets/fastcgi-php.conf;
#         #
#         #       # With php-fpm (or other unix sockets):
#         #       fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
#         #       # With php-cgi (or other tcp sockets):
#         #       fastcgi_pass 127.0.0.1:9000;
#         #}

#         # deny access to .htaccess files, if Apache's document root
#         # concurs with nginx's one
#         #
#         #location ~ /\.ht {
#         #       deny all;
#         #}
# }


# # Virtual Host configuration for example.com
# #
# # You can move that to a different file under sites-available/ and symlink that
# # to sites-enabled/ to enable it.
# #
# #server {
# #       listen 80;
# #       listen [::]:80;
# #
# #       server_name example.com;
# #
# #       root /var/www/example.com;
# #       index index.html;
# #
# #       location / {
# #               try_files \$uri \$uri =404;
# #       }
# #}
# " > /home/ubuntu/default3400


sudo echo "user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
        worker_connections 768;
        # multi_accept on;
}

http {
  upstream ec2_apache {
    #server 10.0.1.10:3001;
    server 10.0.2.10:3002;
    server 10.0.3.10:3003;
  }

   # This server accepts all traffic to port 80 and passes it to the upstream. 
   # Notice that the upstream name and the proxy_pass need to match.

   server {
      listen 3400; 

      location / {
          proxy_pass http://ec2_apache;
      }
   }
}

#mail {
#       # See sample authentication script at:
#       # http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
#
#       # auth_http localhost/auth.php;
#       # pop3_capabilities "TOP" "USER";
#       # imap_capabilities "IMAP4rev1" "UIDPLUS";
#
#       server {
#               listen     localhost:110;
#               protocol   pop3;
#               proxy      on;
#       }
#
#       server {
#               listen     localhost:143;
#               protocol   imap;
#               proxy      on;
#       }
#}
# Define which servers to include in the load balancing scheme. 
# It's best to use the servers' private IPs for better performance and security.
# You can find the private IPs at your UpCloud control panel Network section.
"> /home/ubuntu/nginx_loadbalancer.conf

sudo cp /etc/nginx/nginx.conf /home/ubuntu/nginx.conf.original
sudo cp /home/ubuntu/nginx_loadbalancer.conf /etc/nginx/nginx.conf
sudo chmod 644 /etc/nginx/nginx.conf

sudo cp /etc/nginx/sites-enabled/default /home/ubuntu/default.original
sudo cp /home/ubuntu/default3400 /etc/nginx/sites-enabled/default
sudo chmod 644 /etc/nginx/sites-enabled/default
sudo rm /home/ubuntu/default3400
sudo systemctl restart nginx