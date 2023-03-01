CREATE TABLE user_data AS (

WITH

user_raw as (

		SELECT jsondata ->> '_id.$oid' 			as user_id
	,	jsondata ->> 'active' 					as active
	,	jsondata ->> 'createdDate.$date' 		as account_creation
	,	jsondata ->> 'lastLogin.$date' 			as last_login
	,	jsondata ->> 'role' 					as user_role
	,	jsondata ->> 'signUpSource' 			as sign_up_source
	,	jsondata ->> 'state' 					as state
	
		FROM users_raw

)

SELECT CAST(user_id as VARCHAR)                                                                                     as user_id
,	CAST(active as BOOLEAN)                                                                                         as active
,	CASE 
  		WHEN "account_creation" ~ '^\d+$' 
		THEN ('1970-01-01'::date + ("account_creation"::double precision/1000) * '1 second'::interval)::timestamp
  		ELSE to_date("account_creation", 'dd/mm/yyyy')
  	END                                                                                                             as account_creation
,	CASE 
  		WHEN "last_login" ~ '^\d+$' 
		THEN ('1970-01-01'::date + ("last_login"::double precision/1000) * '1 second'::interval)::timestamp
  		ELSE to_date("last_login", 'dd/mm/yyyy')
  	END                                                                                                             as last_login
,	CAST(user_role as VARCHAR)                                                                                      as user_role
,	CAST(sign_up_source as VARCHAR)                                                                                 as sign_up_source
,	CAST(state as VARCHAR)                                                                                          as state

FROM user_raw
	
	)