# Philanthropy Data & Analytics Strategy

## Overview

This vision establishes a modern, governed data architecture for Philanthropy that:

- reduces data silos across systems  
- defines clear ownership of data by domain  
- introduces controlled data flows where needed  
- centralizes key data in BigQuery for consistency, analysis, and audit  
- improves usability through dashboards and natural-language access  
- clarifies how data is managed across systems and where governance applies  
- clearly defines the role of the Philanthropy Analyst within this system  

The goal is not to move all data into one place, but to create a trusted, scalable, and usable data ecosystem for the Philanthropy team.

---

## 1. Core Principles

### 1.1 Source of Truth by Data Domain

- **Veracross** is the authoritative source for identity, demographic, and contact data  
- **DonorPerfect** is the authoritative source for gifts, fundraising activity, and advancement-specific data  

Each data element has a defined owner.

**Simple framing:** ownership means where the truth lives.

---

### 1.2 Controlled Data Flow (Where It Matters)

Data does not move freely between systems when it impacts shared or high-value data.

- Cross-system and shared data flows through BigQuery for validation  
- Philanthropy-owned data that is not shared across the institution may be managed directly in DonorPerfect  

This keeps governance focused where it is needed without slowing down day-to-day work.

---

### 1.3 Separation of Responsibilities

| Layer | Responsibility |
|---|---|
| Capture systems | Collect data |
| Ingestion layer | Move data into BigQuery |
| BigQuery | Standardize, validate, route, audit |
| Source-of-truth systems | Maintain authoritative operational records |
| Visualization layer | Present insights |
| Agent layer | Improve accessibility, explanation, and guided use |

---

## 2. System Architecture

### 2.1 Capture Layer (Non-Authoritative Systems)

Lion Link, Boost My School, Greater Giving, and similar tools collect and store data but do not define truth.

These systems act as inputs into the broader data ecosystem.

---

### 2.2 Airbyte as the Ingestion Layer

Airbyte moves data from systems (APIs/exports) into BigQuery, standardizing ingestion and reducing custom code. CDK enables custom connectors when needed.

**Boundary:** Airbyte handles movement, not governance.

---

### 2.3 BigQuery as the Central Data Layer

BigQuery acts as the control and governance layer where needed.

- **Ingestion/Staging:** raw + normalized tables with metadata  
- **Validation:** All updates have HITL approval to build trust in the system. Future direction is to enable auto-approve / needs review / reject  workflow where the HITL only reviews those flagged for review.
- **Routing:** determines target system for updates  
- **Audit:** full change history  

Not all data is required to pass through this layer, but any data that is shared, cross-system, or relied on for reporting should.

BigQuery also maintains metadata about external data sources so that all data is visible and intentionally managed, even if it is not ingested.

---

### 2.4 Source-of-Truth Systems

- **Veracross:** identity, contact, demographics  
- **DonorPerfect:** gifts, fundraising activity  

These systems maintain authoritative operational records.

---

### 2.5 Write-Back Layer

Cloud Run (or similar) reads approved updates from BigQuery and writes to Veracross/DonorPerfect via APIs.

---

## 3. Data Governance Model

### 3.1 Governed vs Direct Workflows

Not all data needs to go through the BigQuery validation process.

- **Governed workflows:**  
  Used for shared, cross-system, or high-impact data (e.g., contact information, relationships). These are validated in BigQuery before being written to source systems.

- **Direct workflows:**  
  Used for Philanthropy-owned data that does not need to stay aligned across systems (e.g., donor capacity ratings, event outcomes). These may be imported directly into DonorPerfect with human review.

If data later becomes shared or used beyond Philanthropy, it can be brought into the governed process.

---

### 3.2 Human-in-the-Loop Validation

For governed data, updates are classified as:

- auto-approve  
- needs review  
- reject  

Human review is used to approve all changes as trust is build in the system to ensure quality and context. Later auto-approve can allow automation of auto-approved updates.

---

### 3.3 Audit and Traceability

Every governed change is logged with full lineage, including source, transformation, and write-back.

---

## 4. Data Classification and Use

Data is intentionally handled in different ways depending on its role.

- **Trusted and governed data**  
  Managed through BigQuery and used for reporting and decision-making across systems  
  (e.g., alumni contact information, reportable data from DonorPerfect as determined by Philanthropy Team)

- **Philanthropy-owned data**  
  May be managed directly in DonorPerfect when it does not need to stay aligned with other systems unless it is to be used in dashboarding. Dashboarding data must go through the governance process. Philanthropy-owned data to be used with AI Agents in future phase will also need to go through governance in BigQuery.  
  (e.g., donor capacity ratings, event outcomes).
  Non-governed Philanthropy data is still catalogued in BigQuery as metadata.

The goal is to ensure that:
- trusted data is clearly defined and consistent  
- supplemental data is used appropriately  
- no data is invisible or unmanaged  

---

## 5. Analytics and Visualization

### 5.1 BigQuery Foundation

Curated datasets and consistent definitions support analysis.

---

### 5.2 Metabase Layer

Dashboards and reporting are built on governed datasets.

---

## 6. Agent Layer (Usability & Intelligence)

Agents enable:

- natural-language querying  
- explanation and context  
- guided analysis  
- review assistance  

Agents assist but do not control write-back in initial phases and do not control data ownership.

---

## 7. AI-First Enablement

### 7.1 Principle

AI is at the core of the systems we build and can act as a primary interface for interacting with data, supported by governed systems and human oversight.

---

### 7.2 Rationale

AI systems are only as reliable as the data they operate on. Without:

- clear ownership  
- consistent definitions  
- controlled data flow
- semantic context

AI produces inconsistent or misleading results.

---

### 7.3 Implementation

- BigQuery provides governed, unified datasets  
- Agents provide natural-language access and explanation  
- Metabase provides structured visualization  
- Governance ensures AI outputs are consistent and trustworthy  

---

### 7.4 Key Insight

AI-first does not mean AI replaces systems—it means:

> data is structured so AI can be reliably used as a primary interface.

---

## 8. Philanthropy Analyst Role

### 8.1 Purpose

Operate at the insight layer using governed data. Operate at the Data Steward level for Philanthropy data and platforms.

---

### 8.2 Responsibilities

- maintain Philanthropy data platforms
- support data cataloguing and metadata management/maintenance
- build dashboards (Metabase)  
- analyze fundraising performance  
- support data-informed strategy
- use AI/agents for exploration  

---

### 8.3 Not Responsible For

- architecture  
- pipelines  
- source-of-truth definitions  

---

### 8.4 Role Summary

The analyst generates insight within a governed system, not infrastructure.

---

## 9. Strategic Impact

- more consistent data  
- reduced manual reconciliation  
- scalable analytics  
- AI-enabled usability  
- faster onboarding  
- clearer ownership and expectations  

---

## Summary Statement

We are creating a data ecosystem where:

- systems have defined roles  
- Airbyte supports ingestion  
- BigQuery governs shared and high-impact data  
- Philanthropy retains flexibility where appropriate  
- AI (via agents) eventually becomes a primary interface for interacting with trusted data  
