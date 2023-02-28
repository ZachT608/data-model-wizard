--Creating table
create table brands_raw (jsondata jsonb)

--Using PSQL in pgAdmin 4 to insert json file into table

\copy brands_raw (jsondata) from '/users/zachthomson/desktop/brands_raw.json'