select response_id, language_have_worked_with, database_have_worked_with, platform_have_worked_with
from {{ ref('stg_survey_responses') }}