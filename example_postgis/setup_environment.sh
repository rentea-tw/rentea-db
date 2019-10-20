#!bin/bash

apt-get update
apt-get install -y sudo
sudo apt-get install -y wget
sudo apt-get install -y gnupg

echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" >> "/etc/apt/sources.list"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-10
sudo apt install -y postgresql-10-postgis-2.4 
sudo apt install -y postgresql-10-postgis-scripts

sudo service postgresql start
sudo -u postgres psql -c "CREATE EXTENSION adminpack;" postgres
sudo -u postgres psql -c "CREATE EXTENSION postgis;" postgres
sudo -u postgres psql -c "CREATE EXTENSION postgis_topology;" postgres
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '123456';" postgres
sudo -u postgres createdb main
sudo -u postgres psql -d main -f /usr/share/postgresql/10/contrib/postgis-2.4/postgis.sql
sudo -u postgres psql -d main -f /usr/share/postgresql/10/contrib/postgis-2.4/spatial_ref_sys.sql
sudo -u postgres psql -d main -f /usr/share/postgresql/10/contrib/postgis-2.4/postgis_comments.sql
sudo -u postgres psql -c "CREATE SEQUENCE points_id_seq;" postgres
sudo -u postgres psql -c "CREATE TABLE points ( id INTEGER PRIMARY KEY DEFAULT nextval('points_id_seq'), name VARCHAR(40) );" postgres
sudo -u postgres psql -c "SELECT AddGeometryColumn('points', 'location', 4326, 'POINT', 2);" postgres
sudo -u postgres psql -c "CREATE INDEX points_location_idx on points using GIST (location);" postgres
sudo -u postgres psql -c "INSERT INTO points(name, location) VALUES ('台北101', ST_GeomFromText('POINT(121.5646380 25.0339138)', 4326));" postgres
sudo -u postgres psql -c "INSERT INTO points(name, location) VALUES ('台科大', ST_GeomFromText('POINT(121.5394628 25.0130727)', 4326));" postgres
sudo -u postgres psql -c "SELECT * FROM points;" postgres
sudo -u postgres psql -c "SELECT ST_Distance( ST_Transform((SELECT location FROM points WHERE name='台北101'), 900913), ST_Transform((SELECT location FROM points WHERE name='台科大'), 900913) )as distance;" postgres
sudo -u postgres psql -c "SELECT * FROM points WHERE ST_Distance( ST_Transform(location, 900913), ST_Transform((SELECT location FROM points WHERE name='台北101'), 900913) ) < 4000 and name<>'台北101';" postgres
