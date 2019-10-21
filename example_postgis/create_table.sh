#!bin/bash

# Enable postgis extension in the postgre.
sudo service postgresql start
sudo -u postgres psql -c "CREATE EXTENSION adminpack;" postgres
sudo -u postgres psql -c "CREATE EXTENSION postgis;" postgres
sudo -u postgres psql -c "CREATE EXTENSION postgis_topology;" postgres
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '123456';" postgres

# Create all tables used by POSTGIS extension.
sudo -u postgres createdb main
sudo -u postgres psql -d main -f /usr/share/postgresql/10/contrib/postgis-2.4/postgis.sql
sudo -u postgres psql -d main -f /usr/share/postgresql/10/contrib/postgis-2.4/spatial_ref_sys.sql
sudo -u postgres psql -d main -f /usr/share/postgresql/10/contrib/postgis-2.4/postgis_comments.sql

# Create all the data used by the demo.
sudo -u postgres psql -c "CREATE SEQUENCE points_id_seq;" postgres
sudo -u postgres psql -c "CREATE TABLE points ( id INTEGER PRIMARY KEY DEFAULT nextval('points_id_seq'), name VARCHAR(40) );" postgres
sudo -u postgres psql -c "SELECT AddGeometryColumn('points', 'location', 4326, 'POINT', 2);" postgres
sudo -u postgres psql -c "CREATE INDEX points_location_idx on points using GIST (location);" postgres
sudo -u postgres psql -c "INSERT INTO points(name, location) VALUES ('台北101', ST_GeomFromText('POINT(121.5646380 25.0339138)', 4326));" postgres
sudo -u postgres psql -c "INSERT INTO points(name, location) VALUES ('台科大', ST_GeomFromText('POINT(121.5394628 25.0130727)', 4326));" postgres