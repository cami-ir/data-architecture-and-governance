# Layer 1: The Transformation Flow (Portrait)
### In BigQuery, this is where you convert Raw Ingestion Tables (often JSON, CSV, or external streams) into Standardized Tables.


```mermaid
graph TD
    subgraph RawZone [Raw Ingestion Layer]
        A[(Landing Table)]
        B[<i>Characteristics:</i><br/>- All Strings/JSON<br/>- Duplicate rows<br/>- Raw timestamps]
    end

    subgraph Logic [Standardization SQL]
        direction TB
        C{<b>Transformation Actions</b>}
        C1[<b>Type Casting:</b><br/>STRING to INT64/DATE]
        C2[<b>Deduplication:</b><br/>QUALIFY ROW_NUMBER...]
        C3[<b>Naming:</b><br/>snake_case_headers]
        C4[<b>Hardcoding:</b><br/>Source System Tags]
        
        C --> C1 & C2 & C3 & C4
    end

    subgraph StdZone [Standardized Layer]
        D[<b>CTAS / DML</b>]
        E[(Standardized Table)]
        F[<i>Characteristics:</i><br/>- Strongly Typed<br/>- No Duplicates<br/>- Audit Columns]
    end

    A --> C
    C1 & C2 & C3 & C4 --> D
    D --> E

    style A fill:#f9f,stroke:#333
    style E fill:#bbf,stroke:#333
    style C fill:#fff,stroke:#333,stroke-dasharray: 5 5
```

## What happens inside the SQL?
Here is an example of what that Standardization SQL actually does to a "Customer" record. Notice how it takes "garbage" and creates "truth."

SQL
CREATE OR REPLACE TABLE `project.std_dataset.customers` AS
SELECT
  -- 1. Identity & Deduplication logic
  TRIM(CAST(cust_id AS STRING)) AS customer_id,
  
  -- 2. Type Casting (The most important part)
  SAFE_CAST(signup_date AS DATE) AS signup_date,
  SAFE_CAST(total_spend AS FLOAT64) AS total_spend_amount,
  
  -- 3. Cleaning Strings
  UPPER(TRIM(country_code)) AS country_code,
  COALESCE(email, 'unknown') AS email_address,
  
  -- 4. Audit Columns (Essential for Governance)
  'CRM_SYSTEM_ALPHA' AS source_system,
  CURRENT_TIMESTAMP() AS _standardized_at
FROM `project.raw_dataset.crm_export_raw`
-- 5. Filter out completely broken records early
WHERE cust_id IS NOT NULL;

## Why this matters for the Pipeline
- Uniformity: If you have data from three different regions, Layer 1 makes sure DATE is always YYYY-MM-DD before you try to match them in Layer 2.
- Performance: By casting to proper types (like INT64 or DATE), BigQuery processes the data significantly faster and cheaper than if it were all STRING.
- Governance Start: This is where you first define what "valid" data looks like. If it can't be cast to a DATE here, it's already a candidate for a discrepancy.
