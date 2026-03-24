

```mermaid
graph TD
    subgraph BigQuery [BigQuery Warehouse]
        A[(Raw Data)] --> B[Layer 1-3:<br/>Detection SQL]
        B --> C{<b>The MERGE</b>}
        C --> D[(Discrepancy Registry<br/>Table)]
    end

    subgraph Connectivity [Data Connection]
        D -- "Service Account<br/>(Read-Only)" --> E((Metabase))
    end

    subgraph MetabaseApp [Metabase Features]
        E --> F[<b>GUI Questions</b><br/>'How many High severity<br/>errors are OPEN?']
        E --> G[<b>Dashboard</b><br/>Trend of errors<br/>over last 30 days]
        E --> H[<b>Alerts</b><br/>Slack ping when<br/>Critical error appears]
    end

    subgraph Action [User Workflow]
        F --> I[Assign to Team]
        G --> J[Business Review]
        H --> K[Immediate Fix]
    end

    style D fill:#dfd,stroke:#333,stroke-width:2px
    style E fill:#509ee3,color:#fff
```
```mermaid
graph TD
    subgraph Detection [Layer 3: Detection]
        RuleA[Rule Logic A]
        RuleB[Rule Logic B]
    end

    subgraph Logic [The Worker]
        M{<b>The MERGE Code</b><br/>Logic Layer}
    end

    subgraph Storage [The Bucket]
        T[(<b>Discrepancy Registry</b><br/>Table Schema)]
    end

    subgraph Viz [The Lens]
        Meta[[<b>Metabase</b>]]
    end

    RuleA --> M
    RuleB --> M
    M -- "Updates or Inserts" --> T
    T -- "Displays Data" --> Meta

    style M fill:#f9f,stroke:#333
    style T fill:#bbf,stroke:#333
    style Meta fill:#509ee3,color:#fff
