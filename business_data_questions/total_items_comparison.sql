-- Question: When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
-- DQ Issue: N/A
-- Answer: Receipts in finished status have a higher total items spent than those that are rejected.
-- Query to get answer:

WITH

receipts_finished as (

	SELECT DISTINCT receipt_id, total_items_purchased
	
	FROM receipts_data
		
	WHERE receipt_status = 'FINISHED'

),

receipts_rejected as (

	SELECT DISTINCT receipt_id, total_items_purchased
	
	FROM receipts_data
		
	WHERE receipt_status = 'REJECTED'

)

SELECT SUM(receipts_finished.total_items_purchased) as sum_of_finished
,	SUM(receipts_rejected.total_items_purchased) as sum_of_rejected

FROM receipts_finished, receipts_rejected