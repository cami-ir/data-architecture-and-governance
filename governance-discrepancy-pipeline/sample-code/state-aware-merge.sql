MERGE `project.governance.active_discrepancies` T
USING (
  -- This is the output from your Layer 3 (Detection SQL)
  SELECT * FROM `project.staging.detected_errors_today`
) S
ON T.entity_id = S.entity_id 
   AND T.rule_id = S.rule_id
   AND T.status != 'RESOLVED'  -- Only match against items still "in flight"

-- 1. If we already know about it, just update the "last seen" heartbeats
WHEN MATCHED THEN
  UPDATE SET 
    T.last_detected_at = S.detected_at,
    T.occurrence_count = T.occurrence_count + 1,
    T.metadata_payload = S.metadata_payload

-- 2. If it's brand new, create a new record
WHEN NOT MATCHED BY TARGET THEN
  INSERT (rule_id, entity_id, status, first_detected_at, last_detected_at, occurrence_count)
  VALUES (S.rule_id, S.entity_id, 'OPEN', S.detected_at, S.detected_at, 1)

-- 3. OPTIONAL: If it was OPEN but the rule didn't find it today, it might be fixed!
-- (Careful with this logic, usually handled by a separate "cleanup" job)
