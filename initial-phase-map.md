Address Reconciliation Workflow (LionLink → Validation → Systems)

```mermaid
flowchart TD
    A[LionLink Export]
    B[DonorPerfect via Airbyte]
    
    subgraph V[BigQuery Validation Layer]
        C[BigQuery Validation Layer comparing Lion Link address data with Veracross and DonorPerfect data]
        D[Validation and Discrepancy Rules]
        F[Human Review of Discrepancy and Validation Findings]
        E[Refine Validation Rules As Needed]
    end

    A --> C
    B --> C

    C --> D
    D --> F
    F --> E
    E --> D

    E --> G[Approved Updates Files]

    G --> H[Manual Import Veracross]
    G --> I[Manual Import DonorPerfect]

    H --> J[Airbyte Sync to BigQuery]
    I --> J

    J --> K[Validation Layer Tested]
    K --> L[Verification No Discrepancies]
