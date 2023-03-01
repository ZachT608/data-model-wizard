-- Question: What are the top 5 brands by receipts scanned for most recent month?
-- DQ Issue: There is no data for most recent month, have to go 3 months back. barcodes from receipts are more than whats in brands
-- Answer: "Cheetos", "Cracker Barrel Cheese", "Diet Chris Cola", "Grey Poupon", "Jell-O"
-- Query to get answer:
WITH

receipts as (

	SELECT receipt_id
	,	barcode

	FROM receipts_data
	
	WHERE date_scanned BETWEEN '2021-01-01' AND '2021-02-01'

	
),

brand_data as (

	SELECT barcode
	,	brand_name
	
	FROM brands_data

)

SELECT COUNT(receipts.receipt_id) as count
,	brand_name

FROM receipts
JOIN brand_data 
ON receipts.barcode = brand_data.barcode

GROUP BY 2
ORDER BY 1 DESC
LIMIT 5;
