select
  --  Identidad y demografía
  "ResponseId" as response_id,
  "MainBranch" as main_branch,
  "Age" as age,
  "EdLevel" as ed_level,
  "Country" as country,
  -- Carrera y empleo
  "Employment" as employment,
  "DevType" as dev_type,
  TRY_CAST("WorkExp" AS INTEGER) as work_exp,
  TRY_CAST("YearsCode" AS INTEGER) as years_code,
  "OrgSize" as org_size,
  "RemoteWork" as remote_work,
  "ICorPM" as icorpm,
  "Industry" as industry,
  -- Compensación
  "Currency" as currency,
  "CompTotal" as comp_total,
  TRY_CAST("ConvertedCompYearly" AS FLOAT) as converted_comp_yearly,
  "JobSat" as job_sat,    
  -- Tecnologías
  "LanguageHaveWorkedWith" as language_have_worked_with,
  "DatabaseHaveWorkedWith" as database_have_worked_with,
  "PlatformHaveWorkedWith" as platform_have_worked_with,
  -- AI
  "AISelect" as ai_select,
  "AISent" as ai_sent,
  "AIAcc" as ai_acc,
  "AIThreat" as ai_threat,
  "AIAgents" as ai_agents
from {{ source('STACKOVERFLOW', 'SURVEY_RESULTS_PUBLIC') }}