CREATE TABLE brands_data AS (

WITH

brands_raw as (

	SELECT jsondata ->> '_id.$oid' 		as brand_id
	,	jsondata ->> 'barcode' 			as barcode
	,	jsondata ->> 'category' 		as category
	,	jsondata ->> 'categoryCode' 	as category_code
	,	jsondata ->> 'cpg.$id.$oid' 	as cpg_id
	,	jsondata ->> 'cpg.$ref' 		as cpg_ref
	,	jsondata ->> 'name' 			as brand_name
	,	jsondata ->> 'topBrand' 		as top_brand
	,	jsondata ->> 'brandCode' 		as brand_code
	
	FROM brands_raw

)

SELECT CAST(brand_id as VARCHAR) 				as brand_id
,	CAST(barcode as VARCHAR) 					as barcode
,	CAST(brand_code as VARCHAR) 				as brand_code
,	CAST(category as VARCHAR) 					as category
,	CAST(category_code as VARCHAR) 				as category_code
,	CAST(cpg_ref as VARCHAR) 					as cpg_ref
,	CAST(top_brand as BOOLEAN) 					as top_brand
,	CAST(brand_name as VARCHAR) 				as brand_name

FROM brands_raw
	)