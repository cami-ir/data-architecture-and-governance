# Source of Truth Governance
By separating these Rules A and B, you can tell exactly where the human or the machine is failing. If you see a lot of "Failure Mode 2," you know your API is broken. If you see "Failure Mode 1," you know your office staff needs to process the Lion Link queue faster.

If Advancement is contacted by an Alum with and update to contact information, that information is entered into VERACROSS.

## Failure Mode 1: The "Input Gap" (Lion Link → Veracross)
Logic: IF LL_Update_TS > VX_Update_TS AND LL_Address != VX_Address
- Meaning: An alum updated their info in Lion Link, but it hasn't been manually or automatically moved into Veracross yet.
- Metabase Alert: "New Alumni Data Pending in Veracross."

## Failure Mode 2: The "Sync Gap" (Veracross → Donor Perfect)
Logic: IF VX_Address != DP_Address
- Meaning: Veracross has the correct info, but the API failed to push it to Donor Perfect, or the sync is delayed.
- Metabase Alert: "API Sync Error: Donor Perfect is out of sync with Veracross."

```mermaid
graph TD
    subgraph Layer1 [1. Standardization]
        LL[(Lion Link<br/><i>New Submissions</i>)]
        VX[(Veracross<br/><i>System of Record for Alumni contact information</i>)]
        DP[(Donor Perfect<br/><i>Downstream Mirror</i>)]
    end

    subgraph Layer2 [2. The Audit Join]
        LL & VX & DP --> Join[<b>Triple Join</b><br/>on Alumni_ID]
        Join --> AuditTable[(<b>Audit Master</b>)]
    end

    subgraph Layer3 [3. Discrepancy Rules]
        AuditTable --> RuleA{<b>Rule A:</b><br/>Is LL newer than VX?}
        AuditTable --> RuleB{<b>Rule B:</b><br/>Does VX match DP?}
        
        RuleA -- "Yes" --> D1[<b>Action:</b> Update Veracross]
        RuleB -- "No" --> D2[<b>Action:</b> Check API / Sync]
        
        D1 & D2 --> Disc[(Discrepancy Registry)]
    end

    subgraph Layer4 [4. Metabase]
        Disc --> Meta[[Metabase Monitoring]]
    end

    style VX fill:#d1e7dd,stroke:#0f5132,stroke-width:3px
    style DP fill:#f8f9fa,stroke:#333
    style Disc fill:#f8d7da,stroke:#842029
```
# Sample Code for Failure Mode 2/Rule B

```SQL
SELECT 
  alumni_id,
  'API_SYNC_ERROR' AS rule_id,
  'Veracross vs Donor Perfect Mismatch' AS rule_name,
  'Donor Perfect' AS system_to_fix,
  vx_email AS expected_value,
  dp_email AS actual_value,
  'High' AS severity
FROM `project.conformed.audit_master`
WHERE vx_email != dp_email;
```

# Sample Code for joining descrepancy table back to standardized alum table 
This view flattens the logic so a Metabase user can filter by system_to_fix or severity.
```SQL
CREATE OR REPLACE VIEW `your_project.governance.vw_metabase_action_queue` AS
SELECT
  -- 1. Human Readable Info
  a.first_name,
  a.last_name,
  a.class_year,
  
  -- 2. The Discrepancy Details
  d.rule_name,
  d.severity,
  d.system_to_fix,
  
  -- 3. The "Fix-It" Instructions
  d.expected_value AS value_should_be,
  d.actual_value AS current_value_in_system,
  
  -- 4. Metadata for Context
  d.first_detected_at,
  d.occurrence_count,
  
  -- 5. Deep Link (Pro-tip: Create a link directly to the record if possible)
  CONCAT('https://veracross.com/your_school/alumni/', a.alumni_id) AS veracross_link

FROM `your_project.governance.discrepancy_registry` d
JOIN `your_project.std_dataset.alumni_master` a 
  ON d.entity_id = a.alumni_id
WHERE d.status = 'OPEN';
