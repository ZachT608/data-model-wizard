--- Question: How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
-- Query used from getting top 5 brands. Added in a Diff column that shows a positive increase from previous > recent
-- DQ Issue: The data is missing a lot of barcodes in receipts + not every barcode is in brands json file. DQ issue.
-- Answer: Previous month has zero comparison to recent month.
-- Query to get answer:
WITH

receipts_recent_month as (

	SELECT receipt_id
	,	barcode
	,	date_scanned

	FROM receipts_data
	
	WHERE date_scanned BETWEEN '2021-01-01' AND '2021-02-01'

),
receipts_previous_month as (

	SELECT receipt_id
	,	barcode
	,	date_scanned

	FROM receipts_data
	
	WHERE date_scanned BETWEEN '2020-11-01' AND '2020-12-01'

),

brand_data as (

	SELECT barcode
	,	brand_name
	
	FROM brands_data

)

SELECT COUNT(receipts_recent_month.receipt_id) as count_of_current
,	COUNT(receipts_previous_month.receipt_id) as count_of_previous
,	 COUNT(receipts_recent_month.receipt_id) - COUNT(receipts_previous_month.receipt_id) as diff
,	brand_data.brand_name

FROM receipts_recent_month
JOIN brand_data ON receipts_recent_month.barcode = brand_data.barcode
FULL JOIN receipts_previous_month ON receipts_previous_month.barcode = brand_data.barcode

GROUP BY 4
LIMIT 5;