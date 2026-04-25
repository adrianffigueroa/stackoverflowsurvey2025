SELECT *
FROM {{ ref('stg_survey_responses') }}
WHERE ai_select NOT IN (
    'Yes, I use AI tools daily',
    'Yes, I use AI tools weekly',
    'Yes, I use AI tools monthly or infrequently',
    'No, but I plan to soon',
    'No, and I don''t plan to',
    'NA'
)
AND ai_select IS NOT NULL