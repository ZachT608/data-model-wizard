-- Question: Which brand has the most spend among users who were created within the past 6 months?
-- DQ Issue: Again, possible missing many barcodes from brands json.file that receipts json data has.
-- Answer: Cracker Barrel Cheese has the highest amount spent from new user account creations in the past 6 months. 
-- Query to get answer:

WITH

users as (

	SELECT user_id

	FROM users_data
	
	WHERE account_creation BETWEEN '2020-09-01' AND '2021-03-01'

),

receipt as (

	SELECT receipt_id, barcode, final_price, user_id
	
	FROM receipts_data

),

brands as (

	SELECT barcode, brand_name
	
	FROM brands_data

)

SELECT brands.brand_name as brand
,	SUM(receipt.final_price) as total_spent

FROM users
LEFT JOIN receipt ON users.user_id = receipt.user_id
JOIN brands ON receipt.barcode = brands.barcode

GROUP BY 1
ORDER BY 2 DESC
LIMIT 1