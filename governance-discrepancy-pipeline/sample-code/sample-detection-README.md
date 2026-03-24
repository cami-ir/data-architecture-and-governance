# Sample Query for Detection

## Detection code "sample-unified-detection.sql"

Running one unified "Detection Job" is often much easier to manage (and cheaper on the BigQuery bill) than scheduling 50 tiny individual queries.

- Sample code for unified-detection:  It uses Common Table Expressions (CTEs) to isolate the logic for each rule, then "stacks" them using a UNION ALL to pipe everything into your persistent discrepancy table.
- Why this works for Governance
  - The Payload: Using TO_JSON_STRING(STRUCT(...)) is a BigQuery "pro-tip." It allows you to store rule-specific debug info without adding 100 empty columns to your main discrepancy table.
  - Traceability: Every row tells you exactly which rule caught it and when.
  - Efficiency: BigQuery scans the source_data once (or uses its cache effectively) rather than re-reading the table for every single rule.
 
 ```mermaid
graph TD
    subgraph Input [Data Source]
        C[(Conformed Entities Table)]
    end

    subgraph DetectionLogic [Unified Detection SQL]
        C --> R1{Rule 001:<br/>Missing ID}
        C --> R2{Rule 002:<br/>Price Mismatch}
        C --> R3{Rule 003:<br/>Date Range}
        
        R1 -- "If Fails" --> U[UNION ALL]
        R2 -- "If Fails" --> U
        R3 -- "If Fails" --> U
    end

    subgraph Output [Governance Layer]
        U --> DT[(Unified Discrepancy Table)]
        DT --> Res[Resolution Workflow]
    end

    style DT fill:#fdb,stroke:#333,stroke-width:2px
    style U fill:#eee,stroke:#333
