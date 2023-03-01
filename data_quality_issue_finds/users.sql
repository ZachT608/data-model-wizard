-- DQ Issue: Not a huge data quality issue, as user may have not filled out info, but will hurt in future if we need to query against user data
--			 and the state/sign_up_source are missing info
-- Resolution?: sign_up_source may be a upstream data issue, capturing from a different source, or may be a backend issue that needs to be reported to an backend engineer
--				state can be filled manually by contacting support, or as mentioned above, check upstream source, and w/ backend engineeer.
-- Query to DQ Issue:

WITH

user_data as (

	SELECT sign_up_source, state
	
	FROM users_data

)

SELECT COUNT(CASE WHEN sign_up_source IS NULL THEN 1 END) count_null_source
,	COUNT(CASE WHEN state IS NULL THEN 1 END) as count_null_state

FROM user_data