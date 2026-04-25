# Stack Overflow Developer Survey 2025 — dbt + Snowflake

End-to-end analytics engineering project built with dbt Core and Snowflake, using the Stack Overflow 2025 Developer Survey dataset (~49,000 responses). The goal is to transform raw survey data into a clean, tested, and documented dimensional model ready for BI consumption.

---

## Stack

- **dbt Core 1.11** — transformation, testing, documentation
- **Snowflake** — cloud data warehouse
- **Python 3.13** — environment and dbt runtime

---

## Architecture

```
RAW (Snowflake)
└── SURVEY_RESULTS_PUBLIC       ← raw CSV loaded via Snowflake internal stage

STAGING (dbt views)
└── stg_survey_responses        ← column renaming, type casting, source declaration

MARTS (dbt tables)
├── dim_respondent              ← demographic and professional profile
├── dim_tech_stack              ← languages, databases and platforms used
├── dim_ai_usage                ← AI tool adoption and sentiment
└── fct_survey_responses        ← quantitative metrics (compensation, experience, satisfaction)
```

---

## Lineage

![dbt lineage graph](dbt_stackoverflow/docs/lineage.png)

---

## Project Structure

```
dbt_stackoverflow/
├── models/
│   ├── staging/
│   │   ├── stg_survey_responses.sql
│   │   └── _sources.yml           ← source and staging model documentation + tests
│   └── marts/
│       ├── dim_respondent.sql
│       ├── dim_tech_stack.sql
│       ├── dim_ai_usage.sql
│       ├── fct_survey_responses.sql
│       └── _marts.yml             ← marts documentation + tests
├── tests/
│   └── assert_ai_select_valid_values.sql
├── dbt_project.yml
└── profiles.yml                   ← not included, configure locally (see setup)
```

---

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/adrianffigueroa/stackoverflowsurvey2025.git
cd dbt-stackoverflow
```

### 2. Create virtual environment and install dependencies

```bash
python -m venv venv
source venv/bin/activate        # Mac/Linux
# venv\Scripts\activate         # Windows
pip install dbt-snowflake
```

### 3. Configure Snowflake connection

Create `~/.dbt/profiles.yml` with your Snowflake credentials:

```yaml
dbt_stackoverflow:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <your_account_identifier>
      user: <your_user>
      password: <your_password>
      role: ACCOUNTADMIN
      database: DBT_STACKOVERFLOW
      warehouse: COMPUTE_WH
      schema: DEV
      threads: 4
```

### 4. Load raw data

- Create a Snowflake internal stage in `DBT_STACKOVERFLOW.RAW`
- Upload `survey_results_public.csv` to the stage
- Use `INFER_SCHEMA` + `CREATE TABLE ... USING TEMPLATE` to create the table
- Load with `COPY INTO ... MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE`

### 5. Run the project

```bash
dbt debug          # validate connection
dbt run            # build all models
dbt test           # run all tests
dbt docs generate  # generate documentation
dbt docs serve     # serve docs locally
```

---

## Tests

| Model                | Test                 | Column      |
| -------------------- | -------------------- | ----------- |
| stg_survey_responses | unique, not_null     | response_id |
| stg_survey_responses | not_null             | main_branch |
| stg_survey_responses | custom: valid values | ai_select   |
| dim_respondent       | unique, not_null     | response_id |
| dim_tech_stack       | unique, not_null     | response_id |
| dim_ai_usage         | unique, not_null     | response_id |
| fct_survey_responses | unique, not_null     | response_id |

---

## Dataset

[Stack Overflow Developer Survey 2025](https://www.kaggle.com/datasets/aliaslam25/stack-overflow-developer-survey-2025) — ~49,000 responses, 172 columns covering developer demographics, technology adoption, compensation, and AI tool usage.
