# Philanthropy Data Architecture & AI-First Strategy

## Executive Summary
This repository houses the orchestration logic, data schemas, and governance rules for our institutional advancement data. Our goal is to move from manual data entry to a **Control Tower** model—where data is validated in Google Cloud, enriched by AI, and synchronized back to our core systems (Veracross and DonorPerfect) with 100% integrity.

---

## 🏗 The Architecture
The following diagram illustrates our end-to-end data flow. Note the **Double-Layer Governance**: Stewardship at the source and Automated Rules at the core.

```mermaid
flowchart TD

    %% 1. Data Stewardship Layer (Governance at Source)
    subgraph M2 [Data Stewardship & Governance: Systems and Sovereignty]
        direction TB
        spacer1[ ]:::spacer
        A1[Operational Systems<br/>Veracross, DonorPerfect, LionLink, Stelter, etc.]
        A2[Steward-Managed Data<br/>e.g., College Info, Clubs]
    end

    %% 2. Ingestion Path
    A1 --> B1[Automated Ingestion<br/>Airbyte]
    A2 --> B2[Structured Input<br/>Connected Sheets and Forms]

    %% 3. BigQuery / Google Cloud Control Tower (Governance at Core)
    subgraph M1 [BigQuery / Google Cloud: Governance and Control Hub]
        direction TB
        spacer2[ ]:::spacer
        C[Validation and Discrepancy Detection]
        D[AI-Assisted Review - HITL<br/>AI suggests, Analyst approves]
        E[Governed Output Tables]

        %% 4. AI / Agent Expansion
        subgraph M4 [AI / Agent Layer: Future Expansion]
            direction TB
            spacer3[ ]:::spacer
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
        spacer4[ ]:::spacer
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

    %% Insight Flow
    E --> F
    F --> G

    %% Feedback Loops
    G -.->|Feedback: Refine Logic| C
    G -.->|Feedback: Train Agents| M4

    %% --- Styling ---
    classDef spacer fill:none,stroke:none,color:none,height:25px;
    class spacer1,spacer2,spacer3,spacer4 spacer;

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
```

# Governance Pillars

## Governance at the Source (Stewardship)
Data quality begins with the people who own the systems.

* **Accuracy:** Stewards are responsible for the validity of data entered into LionLink, Stelter, and Veracross.
* **Timeliness:** Data entry must be completed by weekly deadlines to ensure ingestion accuracy.
* **Sovereignty:** Departments maintain ownership of their data while adhering to institutional standards for formatting and definitions.

---

## Governance at the Core (BigQuery)
Our "Control Tower" acts as a filter, not just a pipe.

* **Validation (The Orange Box):** Automated scripts flag discrepancies (e.g., mismatched IDs, invalid dates).
* **HITL (Human-in-the-Loop):** The Philanthropy Analyst reviews AI-suggested corrections. No "Writeback" happens without human oversight.
* **Rule-Based Writeback:** Our API Orchestration Layer follows strict rules to ensure we do not overwrite "Primary" registrar data with "Secondary" engagement data (e.g., LionLink/Stelter).

---

## Future Vision: AI & Agents
Our architecture is built for the next phase of Advancement:

* **Natural Language Access:** Fundraisers will be able to ask *"Who in New York is overdue for a visit?"* and get an answer derived directly from our Governed Output Tables.
* **Proactive Insights:** AI agents will identify patterns in giving before they become obvious in standard reporting.
