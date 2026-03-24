# Phase 1: Address Reconciliation Workflow (LionLink → Validation → Systems)

```mermaid
flowchart TD
    A[LionLink Export]
    B[DonorPerfect via Airbyte]
    
    A --> C[BigQuery Validation Layer comparing Lion Link address data with Veracross and DonorPerfect data]
    B --> C

    C --> D[Validation/Discrepancy Rules]
    D --> E[Reconciliation Update Table - Refine Validation Rules As Needed]

    E --> F[HITL Review]
    F --> G[Approved Updates File]

    G --> H[Manual Update Veracross]
    G --> I[Manual Update DonorPerfect]

    H --> J[Airbyte Sync to BigQuery]
    I --> J

    J --> K[Validation Layer Tested]
    K --> L[Verification No Discrepancies]
