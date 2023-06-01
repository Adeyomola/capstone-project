#! /bin/bash

mv wp-config-sample.php wp-config.php

sed -i "s|demo_db.\+|$DB_DATABASE|" wp-config.php
sed -i "s|demo_user.\+|$DB_USERNAME|" wp-config.php
sed -i "s|demo_password.\+|$DB_PASSWORD|" wp-config.php
