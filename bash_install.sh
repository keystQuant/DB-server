# Firewall Setting
sudo ufw app list
sudo ufw allow OpenSSH
sudo ufw enable

# Download PostgreSQL & setting
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib

# DB SETTING
su -c "psql -c \"CREATE DATABASE arbiter;\"" postgres
su -c "psql -c \"CREATE USER arbiter WITH PASSWORD 'makeitpopweAR!1';\"" postgres
su -c "psql -c \"ALTER ROLE arbiter SET client_encoding TO 'utf8';\"" postgres
su -c "psql -c \"ALTER ROLE arbiter SET default_transaction_isolation TO 'read committed';\"" postgres
su -c "psql -c \"ALTER ROLE arbiter SET timezone TO 'UTC';\"" postgres
su -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE arbiter TO arbiter;\"" postgres
su -c "psql -c \"\du\"" postgres

### PostgreSQL localhost setting
cd /etc/postgresql/9.5/main
vim +":%s/#listen_addresses = 'localhost'/#listen_addresses = '*'/g | wq" postgresql.conf

cd /etc/postgresql/9.5/main
vim +"%s/127.0.0.1\/32/0.0.0.0\/0   /g | %s/::1\/128/::\/0/g | wq" pg_hba.conf

sudo systemctl start postgresql.service
sudo systemctl enable postgresql.service
sudo systemctl status postgresql.service
sudo systemctl restart postgresql.service
