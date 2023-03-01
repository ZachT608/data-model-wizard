-- DQ Issue: Barcodes appear more on the receipts scanned vs recorded in the brands data
-- Resolution?: Map or insert updated barcodes per brand based off product_description to corresponding brand_name 
-- Query to DQ Issue:

WITH

barcode as (
	
	SELECT receipts_data.barcode as count_receipt_barcode
		 , brands_data.barcode as count_brand_barcode 
	FROM receipts_data
	LEFT JOIN brands_data ON receipts_data.barcode = brands_data.barcode
)

SELECT COUNT(CASE WHEN count_receipt_barcode IS NULL THEN 1 END) as count_receipt_null
,	COUNT(CASE WHEN count_brand_barcode IS NULL THEN 1 END) as count_brand_null

FROM barcode