# Philanthropy Data Pilot: Alumni Contact Information Reconciliation with LionLink

## Overview

This pilot addresses the issue of **unsynchronized and outdated alumni addresses** by incorporating updated address data collected in LionLink and applying a governed validation workflow.

The approach:

- uses LionLink as a **source of updated address data**
- validates updates against DonorPerfect using BigQuery
- incorporates **human review (HITL)** into the validation loop
- applies approved updates to both Veracross and DonorPerfect
- verifies reconciliation through a subsequent pipeline run

This is a **controlled, iterative data quality workflow**, not a direct system sync.

---

## Architecture Overview

| Layer | Tool | Purpose |
|------|------|--------|
| Source Input | LionLink | Collect updated alumni addresses |
| Ingestion | Airbyte | Extract DonorPerfect and Veracross data |
| Validation | BigQuery | Compare, validate, and generate discrepancies |
| Review | Human (HITL) | Evaluate discrepancies and refine rules |
| Output | Update Files | Approved address updates |
| Systems of Record | Veracross / DonorPerfect | Authoritative systems |
| Verification | BigQuery | Confirm reconciliation after updates |

---

## Workflow Summary

### Stage 1: Validate Incoming Data (LionLink → DonorPerfect)

1. Export updated addresses from LionLink  
2. Ingest DonorPerfect data via Airbyte  
3. Compare LionLink data with DonorPerfect data in BigQuery  
4. Apply validation and discrepancy rules  
5. Review discrepancies through HITL process  
6. Refine validation rules as needed (iterative loop)  
7. Generate approved update file  

---

### Stage 2: Apply Updates + Verify (Veracross ↔ DonorPerfect)

8. Manually import approved updates into:
   - Veracross  
   - DonorPerfect  

9. Run Airbyte sync to re-ingest updated data  
10. Re-run validation layer comparing Veracross and DonorPerfect  
11. Confirm no discrepancies remain  

---

## Data Model (Pilot Schema)

### `lionlink_addresses_raw`

| Field | Type | Description |
|------|------|-------------|
| constituent_id | STRING | Unique identifier |
| address_line1 | STRING | Street address |
| address_line2 | STRING | Secondary line |
| city | STRING | City |
| state | STRING | State |
| zip | STRING | ZIP code |
| updated_at | TIMESTAMP | Submission timestamp |

---

### `donorperfect_addresses_raw`

| Field | Type | Description |
|------|------|-------------|
| donor_id | STRING | Unique identifier |
| address_line1 | STRING | Street address |
| address_line2 | STRING | Secondary line |
| city | STRING | City |
| state | STRING | State |
| zip | STRING | ZIP code |
| updated_at | TIMESTAMP | Last update |

---

### `address_validation_stage1`

| Field | Type | Description |
|------|------|-------------|
| master_id | STRING | Matched ID |
| lionlink_address | STRING | Submitted address |
| dp_address | STRING | Existing DonorPerfect address |
| is_match | BOOLEAN | Match flag |
| discrepancy_type | STRING | mismatch / missing / stale |
| proposed_address | STRING | Suggested update |

---

### `address_update_approved`

| Field | Type | Description |
|------|------|-------------|
| master_id | STRING | Unique identifier |
| final_address | STRING | Approved address |
| approved_by | STRING | Reviewer |
| approved_at | TIMESTAMP | Approval timestamp |
| source | STRING | LionLink |

---

### `address_validation_stage2`

| Field | Type | Description |
|------|------|-------------|
| master_id | STRING | Unique identifier |
| vc_address | STRING | Veracross address |
| dp_address | STRING | DonorPerfect address |
| is_match | BOOLEAN | Match result |
| verification_status | STRING | reconciled / mismatch |

---

## Validation Logic (Initial Rules)

| Rule | Description |
|------|-------------|
| Address mismatch | LionLink vs DonorPerfect differ |
| Missing data | Address present in one system only |
| Recency conflict | Newer data conflicts with existing |
| Null/invalid | Incomplete or malformed address |

---

## Human-in-the-Loop (HITL) Role

The HITL step is part of the **validation loop**, not a downstream task.

Responsibilities:
- review discrepancies  
- determine correct address  
- identify rule gaps  
- inform refinement of validation logic  

---

## Key Design Principles

- **External data is not automatically trusted**
- **Validation precedes all updates**
- **Human review is part of the system, not an exception**
- **Rules are iterative and improve over time**
- **Systems of record are updated only after approval**
- **All updates are verified through re-validation**

---

## Success Criteria

- Updated LionLink addresses are reflected in both systems  
- Veracross and DonorPerfect remain aligned after updates  
- Manual reconciliation effort is reduced  
- Validation rules improve over time  
- A repeatable governance workflow is established  

---

## Key Insight

This pilot establishes:

> a controlled pathway for external data (LionLink) to become trusted institutional data

---

## Next Steps (Post-Pilot)

- Automate write-back via APIs  
- Expand validation to additional domains:
  - email
  - phone
  - engagement data  
- Introduce AI-assisted validation and recommendations  
- Formalize stewardship workflows  
