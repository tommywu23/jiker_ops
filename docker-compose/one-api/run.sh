#!/bin/bash

php artisan key:generate 
php artisan jwt:secret 
php artisan migrate 
php artisan db:seed --class=PermissionsSeeder 
php artisan passport:keys  

php-fpm