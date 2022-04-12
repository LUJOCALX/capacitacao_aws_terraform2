#!/bin/bash
sudo apt update
sudo apt install net-tools

#Instalação do Apache
sudo apt install apache2 -y

#habilitar módulo rewrite
sudo a2enmod rewrite

#Iniciar o apache
sudo systemctl start apache2

# Desabilita o HTTP 1.0
sudo echo "
#Rewrite condition to allow only HTTP 1.1
RewriteEngine On
RewriteCond %{THE_REQUEST} !HTTP/1.1$
RewriteRule .* - [F]
" > /etc/apache2/httpd.conf

#Direciona o apache para responder na porta 3001
sudo echo "
Listen 3001
<IfModule ssl_module>
        Listen 443
</IfModule>
<IfModule mod_gnutls.c>
        Listen 443
</IfModule>
" > /home/ubuntu/ports3001.conf

#Direciona o apache para responder na porta 3001
sudo echo "<VirtualHost *:3001>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
"> /home/ubuntu/000-default3001.conf

# Habilitar o rewrite e o recycle
# ??? Muitas referências informam que o recycle não é utilizado desde o kernel 4.12
sudo echo "
net.ipv4.tcp_max_tw_buckets = 1440000
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1

" > /home/ubuntu/sysctl_apache.conf

#Altera a pagina padrão do apache para mostrar o servidor
sudo echo "<!doctype html>
<html lang=\"en\">
  <head>
    <meta charset=\"utf-8\">
    <title>Servidor Apache 1</title>
    <meta name=\"description\" content=\"Servidor Apache 1\">
  </head>
  <body>
    <h1 style=\"background-color:blue;color:white;\">Servidor Apache 1</h1>
  </body>
</html>" > /var/www/html/index.html

#ServerSignature Off - esconder a versão do servidor
#ServerTokens Prod - Está opção revela somente o nome do produto, caso scaneado só apareceria o nome "Apache"
#TraceEnable Off - Desabilitar métodos TRACE/TRACK
sudo echo "
ServerTokens Prod
ServerSignature Off
TraceEnable Off
" > /etc/apache2/conf-enabled/security.conf

# Backup de arquivos de configuração, substituição e restart dos serviços do apache
# para assumir as novas configurações.
sudo cp /etc/sysctl.conf /home/ubuntu/sysctl.conf.original
sudo cp /home/ubuntu/sysctl_apache.conf /etc/sysctl.conf
sudo chmod 644 /etc/sysctl.conf
sudo chmod 644 /var/www/html/index.html
sudo /sbin/sysctl -p
sudo cp /etc/apache2/sites-enabled/000-default.conf /home/ubuntu/000-default.conf.original
sudo cp /home/ubuntu/000-default3001.conf /etc/apache2/sites-enabled/000-default.conf
sudo chmod 644 /etc/apache2/sites-enabled/000-default.conf
sudo cp /etc/apache2/ports.conf /home/ubuntu/ports.conf.original
sudo cp /home/ubuntu/ports3001.conf /etc/apache2/ports.conf
sudo chmod 644 /etc/apache2/ports.conf
sudo chmod 644 /etc/apache2/httpd.conf
sudo chmod 644 /etc/apache2/conf-enabled/security.conf
sudo systemctl restart apache2 #SystemD
