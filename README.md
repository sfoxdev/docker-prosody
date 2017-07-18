1. Get images:
docker pull sfoxdev/mariadb
and 
docker pull sfoxdev/prosody
and
docker pull sfoxdev/movim

2. Craete network:
docker network create --driver bridge prosody_network
 
3. Run database:
docker run -d -p 3306:3306 --net=prosody_network --name mariadb -e MARIADB_PASS="a6L1G0V4RnwF" sfoxdev/mariadb:latest

4. Run prosody:
docker run -d -p 5000:5000 -p 5222:5222 -p 5223:5223 -p 5269:5269 -p 5280:5280 -p 5281:5281 -p 5298:5298 -p 5347:5347 --net=prosody_network --name example.com sfoxdev/prosody:latest

5. Add user to prosody
docker exec -i -t example.com prosodyctl adduser admin@example.com
or
http://example.com:5280/register-on-example.com

6. Run movim:
docker run -d -p 80:80 -p 8080:8080 -p 8170:8170 --net=prosody_network --name movim sfoxdev/movim:latest

-----------------------
If you would like to use localhost MySQL database, just add -v /var/lib/mysql/mysql.sock:/var/run/mysqld/mysqld.sock:

docker run -d -v /var/lib/mysql/mysql.sock:/var/run/mysqld/mysqld.sock -p 5000:5000 -p 5222:5222 -p 5223:5223 -p 5269:5269 -p 5280:5280 -p 5281:5281 -p 5298:5298 -p 5347:5347 --net=prosody_network --name example.com sfoxdev/prosody:latest

----------------------
Add to Nginx to fix uploads and Bosh:

location /http-bind {
    proxy_pass  https://example.com:5281/http-bind;
    proxy_set_header Host $host;
    proxy_buffering off;
    tcp_nodelay on;
}
location /upload {
    proxy_pass  https://example.com:5281/upload;
    proxy_set_header Host $host;
    proxy_buffering off;
    tcp_nodelay on;
}

---------------------------

For Movim upload files add fix to Nginx in location section:

https://enable-cors.org/server_nginx.html
or
add_header 'Access-Control-Allow-Origin' '*';
add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
