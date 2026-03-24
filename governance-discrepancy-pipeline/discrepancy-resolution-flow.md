# Discrepancy Resolution in Metabase
```mermaid
graph TD
    subgraph Dashboard [1. The View]
        V["<b>Filtered Dashboard</b><br/>(status = 'OPEN')"]
    end

    subgraph UserAction [2. The Fix]
        V --> Click["Click Alumni_ID"]
        Click --> External["Open Veracross Link"]
        External --> Update["Update Contact Info"]
    end

    subgraph Automation [3. The Resolution]
        Update --> Sync["Next BigQuery Run"]
        Sync --> M["<b>The MERGE</b><br/>(status -> 'RESOLVED')"]
    end

    subgraph Result [4. The Cleanup]
        M --> Gone["Record drops off<br/>'OPEN' Dashboard"]
    end

    style V fill:#e1f5fe,stroke:#01579b
    style Gone fill:#e8f5e9,stroke:#2e7d32
