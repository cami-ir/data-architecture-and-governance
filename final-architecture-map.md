```mermaid
flowchart TD

    %% 1. START: PRIMARY SOURCES
    subgraph M2 [Primary Operational Sources]
        direction LR
        A1[Institutional CRM<br/>Veracross, DonorPerfect]
        A2[Steward-Managed Data<br/>e.g., Connected Sheets]
    end

    %% 2. INGESTION PHASE
    M2 --> B1[Automated Ingestion<br/>Airbyte]
    M2 --> B2[Structured Input Process TBD]

    %% 3. THE GOVERNANCE HUB
    subgraph M1 [BigQuery / Google Cloud: Governance Hub]
        direction TB
        C[Validation & Discrepancy]
        D[AI-Assisted Review - HITL]
        E[Governed Output Tables]
        K[API Orchestration Layer]
    end

    %% 4. SIDECAR: OTHER PHILANTHROPY
    A3[Other Philanthropy Data:<br/>Wealth Screening, Events]
    
    subgraph M3 [Future Ingestion for Agentic AI]
        direction TB
        B3[Semantic Layer & Metadata]
    end

    %% 5. OUTPUT & ACTION LAYER
    subgraph M5 [Output, Future AI Agent, and Action Layer]
        direction TB
        
        subgraph M4 [Agentic AI Layer: Future Direction]
            H[Natural Language Query and Metabase Interaction]
            I[Automated Insights Surfacing]
            J[Agentic Workflows]
        end

        F[Dashboards<br/>Metabase]
        V[Veracross Update]
        DP[DonorPerfect Sync]
    end

    %% --- Connections ---
    
    %% Main Governed Waterfall
    B1 & B2 --> C --> D --> E
    E --> K
    K --> V
    K --> DP

    %% Metabase Logic
    E -->|Governed Data| F
    
    %% Peripheral/Future Logic
    A3 ===>|Dashboard Ready Transformation Step| F
    A3 -.-> B3
    B3 -.-> C

    %% Agentic AI Logic (Dotted Connections)
    E -.->|Semantic Context| M4
    M4 <.->|NL Interface| F
    M4 -.->|Actionable Triggers| K

    %% --- Styling ---
    
    %% Box Styles
    style M1 fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    style M2 fill:#fffde7,stroke:#fbc02d,stroke-width:3px
    style M5 fill:#e8f5e9,stroke:#2e7d32
    
    %% Specific Dotted Styles for Future Components
    style M4 fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px,stroke-dasharray: 5 5
    style M3 fill:#fafafa,stroke:#9e9e9e,stroke-dasharray: 5 5
    
    %% Node Styles
    style E font-weight:bold,fill:#bbdefb
    style A3 fill:#fff4e6,stroke:#e67e22
    
    %% Link Styles (Targeting specific line indices)
    linkStyle 10 stroke:#e67e22,stroke-width:3px;
    linkStyle 13 stroke:#7b1fa2,stroke-width:2px,stroke-dasharray: 5 5;
    linkStyle 14 stroke:#7b1fa2,stroke-width:2px,stroke-dasharray: 5 5;
    linkStyle 15 stroke:#7b1fa2,stroke-width:2px,stroke-dasharray: 5 5;
