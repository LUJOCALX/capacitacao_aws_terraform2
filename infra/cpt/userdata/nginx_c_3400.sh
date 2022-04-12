#!/bin/bash
sudo apt update

#Instalação do Nginx
sudo apt install nginx -y

sudo systemctl start nginx

# habilita o balanceamento para os servidores APACHE nas portas 3002, 3003 e "NÃO" desabilita
# informações do servidor no header através do parametro "server_tokens off;"
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
"> /home/ubuntu/nginx_loadbalancer.conf

sudo cp /etc/nginx/nginx.conf /home/ubuntu/nginx.conf.original
sudo cp /home/ubuntu/nginx_loadbalancer.conf /etc/nginx/nginx.conf
sudo chmod 644 /etc/nginx/nginx.conf

sudo cp /etc/nginx/sites-enabled/default /home/ubuntu/default.original
sudo cp /home/ubuntu/default3400 /etc/nginx/sites-enabled/default
sudo chmod 644 /etc/nginx/sites-enabled/default
sudo rm /home/ubuntu/default3400
sudo systemctl restart nginx