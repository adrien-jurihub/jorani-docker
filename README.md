# jorani-docker
Docker for [Jorani](https://github.com/bbalet/jorani) (Leave Management System)
Images and binaries set to "latest" whenever possible.

1. Clone repo
2. Build: `docker-compose build`
3. Install vendors: `docker exec -ti jorani_jorani_1 sh -c "cd /var/www/html; composer install"`

Enjoy Jorani on localhost:8084
