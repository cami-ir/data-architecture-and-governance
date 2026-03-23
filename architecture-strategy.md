# Advancement Data & Analytics Vision

## Overview

This vision establishes a modern, governed data architecture for Advancement that:

- eliminates data silos across systems
- defines clear ownership of data by domain
- introduces controlled data flows and validation
- centralizes data in BigQuery for consistency, analysis, and audit
- improves usability through dashboards and natural-language access
- clearly defines the role of the Philanthropy Analyst within this system

The goal is not just to connect systems, but to create a trusted, scalable, and usable data ecosystem for the Advancement team.

---

## 1. Core Principles

### 1.1 Source of Truth by Data Domain

- **Veracross** is the authoritative source for identity, demographic, and contact data.
- **DonorPerfect** is the authoritative source for gifts, fundraising activity, and advancement-specific data.

Each data element has a single authoritative owner.

**Simple framing:** ownership means where the truth lives.

### 1.2 Controlled Data Flow

Data does not move freely between systems. All updates follow a defined pathway so that data quality rules, validation, and auditability are preserved.

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

- Lion Link, Boost My School, Greater Giving, and similar tools collect data but do not define truth.

### 2.2 Airbyte as the Ingestion Layer

Airbyte moves data from systems (APIs/exports) into BigQuery, standardizing ingestion and reducing custom code. CDK enables custom connectors when needed.

**Boundary:** Airbyte handles movement, not governance.

### 2.3 BigQuery as the Central Data Layer

- **Ingestion/Staging:** raw + normalized tables with metadata  
- **Validation:** auto-approve / needs review / reject  
- **Routing:** determines target system for updates  
- **Audit:** full change history

### 2.4 Source-of-Truth Systems

- **Veracross:** identity, contact, demographics  
- **DonorPerfect:** gifts, fundraising activity

### 2.5 Write-Back Layer

Cloud Run (or similar) reads approved updates from BigQuery and writes to Veracross/DonorPerfect via APIs.

---

## 3. Data Governance Model

### 3.1 Single Authoritative Write Path

Each field is finalized in one system only.

### 3.2 Human-in-the-Loop Validation

Updates classified as:
- auto-approve  
- needs review  
- reject  

### 3.3 Audit and Traceability

Every change is logged with full lineage.

---

## 4. Analytics and Visualization

### 4.1 BigQuery Foundation

Curated datasets and consistent definitions.

### 4.2 Metabase Layer

Dashboards and reporting on governed tables.

---

## 5. Agent Layer (Usability & Intelligence)

Agents enable:
- natural-language querying  
- explanation and context  
- guided analysis  
- review assistance  

Agents assist but do not control data ownership or write-back.

---

## 6. AI-First Enablement

### 6.1 Principle

AI is the primary interface for interacting with data, supported by governed systems and human oversight.

### 6.2 Rationale

AI systems are only as reliable as the data they operate on. Without:
- clear ownership
- consistent definitions
- controlled data flow

AI produces inconsistent or misleading results.

This architecture ensures:
- trusted, consistent data
- centralized access via BigQuery
- structured layers for safe AI interaction

### 6.3 Implementation

- BigQuery provides governed, unified datasets  
- Agents provide natural-language access and explanation  
- Metabase provides structured visualization  
- Governance ensures AI outputs are consistent and trustworthy  

### 6.4 Key Insight

AI-first does not mean AI replaces systems—it means:

> data is structured so AI can be reliably used as the primary interface.

---

## 7. Philanthropy Analyst Role

### 7.1 Purpose

Operate at the insight layer using governed data.

### 7.2 Responsibilities

- build dashboards (Metabase)  
- analyze fundraising performance  
- support strategy  
- use AI/agents for exploration  

### 7.3 Not Responsible For

- architecture  
- pipelines  
- source-of-truth definitions  

### 7.4 Role Summary

The analyst generates insight within a governed system, not infrastructure.

---

## 8. Strategic Impact

- consistent data  
- reduced manual work  
- scalable analytics  
- AI-enabled usability  
- faster onboarding  

---

## Summary Statement

We are creating a governed data ecosystem where systems have defined roles, Airbyte supports ingestion, BigQuery governs data flow, and AI (via agents) becomes the primary interface for interacting with trusted data.
