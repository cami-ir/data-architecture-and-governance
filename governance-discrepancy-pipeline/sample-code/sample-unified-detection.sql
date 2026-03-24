-- Target: your_project.governance.discrepancy_records
INSERT INTO `your_project.governance.discrepancy_records` (
  rule_id,
  rule_name,
  entity_id,
  entity_type,
  discrepancy_description,
  severity,
  detected_at,
  metadata_payload
)
WITH 
-- 1. Get our conformed data once
source_data AS (
  SELECT * FROM `your_project.warehouse.conformed_entities`
),

-- 2. Rule: Missing Critical Tax ID
rule_missing_tax_id AS (
  SELECT 
    'ERR_001' AS rule_id,
    'Missing Tax ID' AS rule_name,
    entity_id,
    'Customer' AS entity_type,
    'Entity exists in CRM but is missing a valid Tax ID in the ERP' AS discrepancy_description,
    'High' AS severity,
    CURRENT_TIMESTAMP() AS detected_at,
    TO_JSON_STRING(STRUCT(crm_id, erp_id, country_code)) AS metadata_payload
  FROM source_data
  WHERE tax_id IS NULL OR tax_id = ''
),

-- 3. Rule: Price Variance > 10%
rule_price_mismatch AS (
  SELECT 
    'ERR_002' AS rule_id,
    'Price Variance Alert' AS rule_name,
    entity_id,
    'Product' AS entity_type,
    CONCAT('Price difference of ', ROUND(price_diff, 2), ' exceeds 10% threshold') AS discrepancy_description,
    'Medium' AS severity,
    CURRENT_TIMESTAMP() AS detected_at,
    TO_JSON_STRING(STRUCT(source_price, target_price, price_diff)) AS metadata_payload
  FROM source_data
  WHERE ABS(price_diff_percent) > 0.10
)

-- 4. Unified Stack
SELECT * FROM rule_missing_tax_id
UNION ALL
SELECT * FROM rule_price_mismatch;
