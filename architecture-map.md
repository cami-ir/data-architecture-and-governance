```mermaid
flowchart TD

    %% 1. Data Stewardship Layer (Governance at Source)
    subgraph M2 [Data Stewardship & Governance: Systems and Sovereignty]
        direction TB
        A1[Operational Systems<br/>Veracross, DonorPerfect, LionLink, Stelter, etc.]
        A2[Steward-Managed Data<br/>e.g., College Info, Clubs]
    end

    %% 2. Ingestion Path
    A1 --> B1[Automated Ingestion<br/>Airbyte]
    A2 --> B2[Structured Input<br/>Connected Sheets and Forms]

    %% 3. BigQuery / Google Cloud Control Tower (Governance at Core)
    subgraph M1 [BigQuery / Google Cloud: Governance and Control Hub]
        direction TB
        C[Validation and Discrepancy Detection]
        D[AI-Assisted Review - HITL<br/>AI suggests, Analyst approves]
        E[Governed Output Tables]

        %% 4. AI / Agent Expansion
        subgraph M4 [AI / Agent Layer: Future Expansion]
            direction TB
            H[Natural Language Access]
            I[Insight Generation]
            J[Workflow Assistance]
        end

        %% 6. API Integration Layer (Governed Writeback)
        K[API Orchestration Layer<br/>Governed Writeback Rules]
    end

    %% 5. Output and Action Layer
    subgraph M5 [Output and Action Layer]
        direction TB
        V[Veracross Update]
        DP[DonorPerfect Sync]
        F[Dashboards<br/>Metabase]
        G[Insight and Action]
    end

    %% --- Connections ---
    B1 & B2 --> C
    C --> D
    D --> E

    %% The Integration Flow (Posting to APIs)
    E --> K
    K -->|POST: Institutional Data| V
    K -->|Direct POST: LionLink, Stelter, etc.| DP
    V -.->|Native Bio/Demo Sync| DP

    %% AI Layer feeds from Governed Data
    E --> H
    E --> I
    D --> J

    %% Insight Flow (To Metabase)
    E --> F
    F --> G

    %% Feedback Loops
    G -.->|Feedback: Refine Logic| C
    G -.->|Feedback: Train Agents| M4

    %% --- Styling ---
    classDef rules stroke:#f39c12,stroke-width:4px,stroke-dasharray: 5 5;
    class C,D,K rules;

    style M1 fill:#f4f7f9,stroke:#3498db,stroke-width:2px
    style M2 fill:#fdfcf0,stroke:#f1c40f
    style M4 fill:#f5eef8,stroke:#8e44ad,stroke-width:2px,stroke-dasharray: 3 3
    style M5 fill:#ffffff,stroke:#27ae60,stroke-width:1px

    style C fill:#d6eaf8
    style D fill:#fcf3cf
    style E fill:#d6eaf8,font-weight:bold
    style K fill:#e1f5fe,stroke:#f39c12,stroke-dasharray: 5 5
    style G fill:#d4efdf,stroke:#27ae60,stroke-width:2px
