CREATE TABLE receipt_data as (

WITH

raw_format as (
	
SELECT CAST(data ->> '_id.$oid' as VARCHAR) 													as receipt_id 
,	data ->> 'bonusPointsEarned' 																as bonus_points_earned 
,	data ->> 'bonusPointsEarnedReason' 															as reason_for_bonus_points_earned 
,	data ->> 'createDate.$date'																	as receipt_created_date 
,	data ->> 'dateScanned.$date'																as date_scanned 
,	data ->> 'finishedDate.$date'	 															as finished_date 
,	data ->> 'modifyDate.$date' 																as date_receipt_modified 
,	data ->> 'pointsAwardedDate.$date' 															as date_points_awarded 
,	data ->> 'pointsEarned' 																	as total_points_earned 
,	data ->> 'purchaseDate.$date' 																as purchase_date 
,	data ->> 'purchasedItemCount' 																as total_items_purchased 
,	jsonb_array_elements(data -> 'rewardsReceiptItemList') ->> 'barcode' 						as barcode 
,	jsonb_array_elements(data -> 'rewardsReceiptItemList') ->> 'description' 					as product_description 
,	jsonb_array_elements(data -> 'rewardsReceiptItemList') ->> 'finalPrice' 					as final_price 
,	jsonb_array_elements(data -> 'rewardsReceiptItemList') ->> 'itemPrice' 						as item_qty_price 
,	jsonb_array_elements(data -> 'rewardsReceiptItemList') ->> 'needsFetchReview' 				as needs_fetch_review 
,	jsonb_array_elements(data -> 'rewardsReceiptItemList') ->> 'partnerItemId' 					as partner_item_id 
,	jsonb_array_elements(data -> 'rewardsReceiptItemList') ->> 'preventTargetGapPoints' 		as prevent_target_gap_points 
,	jsonb_array_elements(data -> 'rewardsReceiptItemList') ->> 'quantityPurchased' 				as purchase_qty 
,	jsonb_array_elements(data -> 'rewardsReceiptItemList') ->> 'userFlaggedBarcode' 			as user_flagged_barcode 
,	jsonb_array_elements(data -> 'rewardsReceiptItemList') ->> 'userFlaggedNewItem' 			as user_flagged_new_item 
,	jsonb_array_elements(data -> 'rewardsReceiptItemList') ->> 'userFlaggedPrice' 				as user_flagged_price 
,	jsonb_array_elements(data -> 'rewardsReceiptItemList') ->> 'userFlaggedQuantity' 			as user_flagged_qty 
, 	data ->> 'rewardsReceiptStatus' 															as receipt_status 
,	data ->> 'totalSpent' 																		as total_spent 
,	data ->> 'userId' 																			as user_id 
	
FROM receipts_raw
	
	)
	
	SELECT user_id 
	,	receipt_id
	,	receipt_status
	,	CASE 
  			WHEN "date_scanned" ~ '^\d+$' 
			THEN ('1970-01-01'::date + ("date_scanned"::double precision/1000) * '1 second'::interval)::timestamp
  			ELSE to_date("date_scanned", 'dd/mm/yyyy')
  		END                                                                                                                 as date_scanned
	,	CASE 
  			WHEN "receipt_created_date" ~ '^\d+$' 
			THEN ('1970-01-01'::date + ("receipt_created_date"::double precision/1000) * '1 second'::interval)::timestamp
  			ELSE to_date("receipt_created_date", 'dd/mm/yyyy')
  		END                                                                                                                 as receipt_created_date
	,	CASE 
  			WHEN "purchase_date" ~ '^\d+$' 
			THEN ('1970-01-01'::date + ("purchase_date"::double precision/1000) * '1 second'::interval)::timestamp
  			ELSE to_date("purchase_date", 'dd/mm/yyyy')
  		END                                                                                                                 as purchase_date
	,	CASE 
  			WHEN "finished_date" ~ '^\d+$' 
			THEN ('1970-01-01'::date + ("finished_date"::double precision/1000) * '1 second'::interval)::timestamp
  			ELSE to_date("finished_date", 'dd/mm/yyyy')
  		END                                                                                                                 as finished_date
	,	total_spent
	,	bonus_points_earned
	,	reason_for_bonus_points_earned
	,	total_points_earned
	,	CASE 
  			WHEN "date_points_awarded" ~ '^\d+$' 
			THEN ('1970-01-01'::date + ("date_points_awarded"::double precision/1000) * '1 second'::interval)::timestamp
  			ELSE to_date("date_points_awarded", 'dd/mm/yyyy')
  		END                                                                                                                 as date_points_awarded
	,	total_items_purchased
	,	product_description
	,	barcode
	,	purchase_qty
	,	item_qty_price
	,	final_price
	,	partner_item_id
	,	prevent_target_gap_points
	,	CASE 
  			WHEN "date_receipt_modified" ~ '^\d+$' 
			THEN ('1970-01-01'::date + ("date_receipt_modified"::double precision/1000) * '1 second'::interval)::timestamp
  			ELSE to_date("date_receipt_modified", 'dd/mm/yyyy')
  		END                                                                                                                 as date_receipt_modified
	,	needs_fetch_review
	,	user_flagged_barcode
	,	user_flagged_new_item
	,	user_flagged_price
	, 	user_flagged_qty
	
	FROM raw_format
	
	)
