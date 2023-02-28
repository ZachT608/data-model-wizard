--Creating table
create table receipts_raw (data json)

--Using PSQL in pgAdmin 4 to insert json file into table

\copy receipts_raw (data) from '/users/zachthomson/desktop/receipts_raw.json