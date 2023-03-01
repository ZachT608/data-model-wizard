-- DQ Issue: item_qty_price is mostly the same as final_price where the qty_purchased is greater than 1, 
-- 			 meaning its not getting how much each but instead total as the final_price would give
-- Resolution?: divide final_price paid per product purchase by purchase qty

WITH

receipt as (

	SELECT item_qty_price, final_price, purchase_qty
	
	FROM receipts_data

)

SELECT CAST((final_price / purchase_qty) AS NUMERIC(10,2)) as new_item_qty_price 
, item_qty_price as old_item_qty_price
, final_price

FROM receipt

-- Query to DQ Issue:

--quantity not equal to final price

	SELECT item_qty_price 
	, final_price
	, receipt_id

	FROM receipts_data

	WHERE item_qty_price <> final_price
	
--quantity  equal to final price

	SELECT item_qty_price 
	, final_price
	, receipt_id

	FROM receipts_data
	
	WHERE item_qty_price = final_price