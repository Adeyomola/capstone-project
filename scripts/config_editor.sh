#! /bin/bash

mv wp-config-sample.php wp-config.php

sed -i "s|database_name_here.\+|$DB_DATABASE|" wp-config.php
sed -i "s|username_here'.\+|$DB_USERNAME|" wp-config.php
sed -i "s|password_here.\+|$DB_PASSWORD|" wp-config.php
