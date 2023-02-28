--Creating table
create table users_raw (jsondata jsonb)

--Using PSQL in pgAdmin 4 to insert json file into table

\copy users_raw (jsondata) from '/users/zachthomson/desktop/users_raw.json’