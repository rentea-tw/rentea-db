#!bin/bash

echo "Show two records '台科大' and '台北 101' in the table which created by us."
sudo -u postgres psql -c "SELECT * FROM points;" postgres

echo "Show the distance between '台科大' to '台北 101'"
sudo -u postgres psql -c "SELECT ST_Distance( ST_Transform((SELECT location FROM points WHERE name='台北101'), 900913), ST_Transform((SELECT location FROM points WHERE name='台科大'), 900913) )as distance;" postgres

echo "Show all records which are within 4000m near the '台北 101'."
sudo -u postgres psql -c "SELECT * FROM points WHERE ST_Distance( ST_Transform(location, 900913), ST_Transform((SELECT location FROM points WHERE name='台北101'), 900913) ) < 4000 and name<>'台北101';" postgres

echo "Show all records which are in a custom polygon."
sudo -u postgres psql -c "SELECT * FROM points WHERE ST_Contains('SRID=4326;POLYGON((121.564205 25.035180, 121.565315 25.034793, 121.565277 25.033619, 121.564559 25.033099, 121.563510 25.034197, 121.564205 25.035180))', location);" postgres