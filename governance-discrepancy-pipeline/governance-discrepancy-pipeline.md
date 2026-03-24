# Governance and Discrepancy Pipeline

```mermaid
graph LR
    subgraph Layer1 [1. Standardization Layer]
        direction TB
        Raw[(Raw Ingestion Tables)] --> SQL1[Transformation SQL<br/><i>CTAS / Scheduled DML</i>]
        SQL1 --> StdTable[(Standardized Tables<br/><i>Materialized/Persistent</i>)]
    end

    subgraph Layer2 [2. Matching / Conformed Layer]
        direction TB
        StdTable --> SQL2[Matching Logic SQL<br/><i>Candidate Gen + Confirm</i>]
        SQL2 --> ConfTable[(Conformed Tables<br/><i>Persistent Entities</i>)]
        Overrides[(Manual Overrides)] -.-> SQL2
    end

    subgraph Layer3 [3. Rule Evaluation]
        direction TB
        ConfTable --> SQL3[Detection SQL<br/><i>Rule A, B, C...</i>]
        SQL3 --> DiscTable[(Discrepancy Table<br/><i>Unified Records</i>)]
    end

    subgraph Layer4 [4. Resolution & Analytics]
        direction TB
        DiscTable --> SQL4[Analytical / Update SQL]
        SQL4 --> ResTable[(Status & Resolution Tables)]
        ResTable --> Dash[Dashboards / Workflows]
    end

    %% Styling
    style Raw fill:#f9f,stroke:#333
    style StdTable fill:#bbf,stroke:#333
    style ConfTable fill:#bbf,stroke:#333
    style DiscTable fill:#fdb,stroke:#333,stroke-width:2px
    style ResTable fill:#dfd,stroke:#333
