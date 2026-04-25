select response_id, age, ed_level, country, main_branch, employment, dev_type, org_size, remote_work, industry 
from {{ ref('stg_survey_responses') }}