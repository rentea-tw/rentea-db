# Example of PostGIS

Create a Docker container and setup the environment with PostgreSQL and PostGIS.
The main purpose is to prove the feasibility of the polygon query function on the map.
There are some simple result shown in the last.

## Requirement

```
Docker
```

## Setup and Run

```bash
git clone https://github.com/rentea-tw/rentea-db.git
cd example_postgis
sudo docker build . -o example:postgis
```

## Results

After the docker build is complete, there are some results shown as following.

- Show two records '台科大' and '台北 101' in the table which created by us.

'location' is a field with 'geometry' type. This type is used by PostGIS to represent the coordinate on the map.

```
root@ad29ec9346f3:/# sudo -u postgres psql -c "SELECT * FROM points;" postgres

 id |   name    |                      location                      
----+-----------+----------------------------------------------------
  1 | 台北101 | 0101000020E61000000C056C0723645E4012E22593AE083940
  2 | 台科大 | 0101000020E610000026DAFA8E86625E406DF882BB58033940
(2 rows)
```

- Show the distance between '台科大' to '台北 101'

```
root@ad29ec9346f3:/# sudo -u postgres psql -c "SELECT ST_Distance( ST_Transform((SELECT location FROM points WHERE name='台北101'), 900913), ST_Transform((SELECT location FROM points WHERE name='台科大'), 900913) )as distance;

     distance     
------------------
 3795.96382487221
(1 row)
```

- Show all records which are within 4000m near the '台北 101'.

```
root@ad29ec9346f3:/# sudo -u postgres psql -c "SELECT * FROM points WHERE ST_Distance( ST_Transform(location, 900913), ST_Transform((SELECT location FROM points WHERE name='台北101'), 900913) ) < 4000 and name<>'台北101';" post

 id |   name    |                      location                      
----+-----------+----------------------------------------------------
  2 | 台科大 | 0101000020E610000026DAFA8E86625E406DF882BB58033940
(1 row)
```

- Show all records which are in a custom polygon.

```
root@ad29ec9346f3:/# sudo -u postgres psql -c "SELECT * FROM points WHERE ST_Contains('SRID=4326;POLYGON((121.564205 25.035180, 121.565315 25.034793, 121.565277 25.033619, 121.564559 25.033099, 121.563510 25.034197, 121.564205 25.035180))', location);" postgres

 id |   name    |                      location                      
----+-----------+----------------------------------------------------
  1 | 台北101 | 0101000020E61000000C056C0723645E4012E22593AE083940
(1 row)
```