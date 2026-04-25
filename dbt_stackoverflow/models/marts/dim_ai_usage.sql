select response_id, ai_select, ai_sent, ai_acc, ai_threat, ai_agents
from {{ ref('stg_survey_responses') }}