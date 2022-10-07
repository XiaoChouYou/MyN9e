


echo "init .. nginx .. "
docker run -it --rm  --name nginx-demo  -d xiaochouyou/nginx:1.23.1-alpine


if [  ! -d ${PROJECTHOME}/nginx/ ]
then
  mkdir -p ${PROJECTHOME}/nginx/
fi
if [  ! -d ${PROJECTHOME}/nginx/etc/ ]
then
  docker cp nginx-demo:/etc/nginx/        ${PROJECTHOME}/nginx/etc/
fi



docker stop nginx-demo


cat > ${PROJECTHOME}/nginx/etc/conf.d/default.conf <<EOF
server {
    listen       10080;
    listen  [::]:10080;
    server_name  localhost;

    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        auth_basic "Please enter your username and password";
        auth_basic_user_file /etc/nginx/htpasswd;
        autoindex on;
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    #location ~ \.php$ {
    #    root           html;
    #    fastcgi_pass   127.0.0.1:9000;
    #    fastcgi_index  index.php;
    #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    #    include        fastcgi_params;
    #}

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}


EOF

docker run --rm -ti xmartlabs/htpasswd userapp 123456 > ${PROJECTHOME}/nginx/etc/htpasswd