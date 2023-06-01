#! /bin/bash

sed -i "s|APP_URL.\+|APP_URL=http://localhost|" .env
sed -i "s/APP_PORT.\+/#APP_PORT/" .env
sed -i "s/DB_CONNECTION.\+/DB_CONNECTION=mysql/" .env
sed -i "s|DB_HOST.\+|DB_HOST=$DB_HOST|" .env
sed -i "s|DB_PORT.\+|DB_PORT=$DB_PORT|" .env
sed -i "s|DB_DATABASE.\+|DB_DATABASE=$DB_DATABASE|" .env
sed -i "s|DB_USERNAME.\+|DB_USERNAME=$DB_USERNAME|" .env
sed -i "s|DB_PASSWORD.\+|DB_PASSWORD=$DB_PASSWORD|" .env
