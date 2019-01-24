## Config
- nginx conf "conf/nginx/php.conf"
``` txt
server {
    listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;
    root /var/www/html/public;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-Port $remote_port;
    }
    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass ${FMP_SERVICE_NAME}:9000;
        fastcgi_index index.php;
        fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}

```

## Refs
- https://github.com/docker-library/docs/blob/master/php/README.md
