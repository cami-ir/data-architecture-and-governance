# Data Steward Engagement Plan (Non-Philanthropy Data Domains)

## Overview

This workstream focuses on **centralizing and standardizing non-philanthropy-owned data** by partnering with Data Owners and Data Stewards across the school.

The goal is to ensure that data used by Philanthropy is:
- clearly defined  
- consistently structured  
- maintained at the source  
- reliable when integrated into the validation layer  

This work runs in parallel with the Philanthropy address reconciliation pilot.

---

# Phase 0: Define Philanthropy Data Needs (Critical First Step)

## Goal

Clearly define **what data Philanthropy needs from other functions** before engaging with data stewards.

---

## Key Questions

- What business questions is Philanthropy trying to answer?
- What segmentation or targeting depends on this data?
- What data is currently missing or unreliable?
- What data is manually gathered today?

---

## Output

### Priority Data Needs

| Data Domain | Use Case | Key Fields | Priority |
|------------|----------|-----------|----------|
| College Outcomes | Alumni engagement, segmentation | College name, graduation year | High |
| Athletics Participation | Affinity, engagement strategy | Sport, level, years | High |
| Student Activities | Interest-based outreach | Activity name, role | Medium |

---

## Important Principle

> Do not standardize data in isolation—standardize based on how it will be used.

---

# Phase 1: Stakeholder Identification

## Goals

- Identify Data Owners (Director-level)
- Identify Data Stewards (day-to-day managers)
- Confirm scope of each data domain

## Output

- Named owner + steward per domain
- Initial understanding of system(s) used

---

# Phase 2: Data Steward Interviews

## Purpose

To understand:
- how data is actually maintained  
- what the data represents  
- where inconsistencies or risks exist  

---

## Interview Template

### 1. Role & Data Ownership

- What is your role?
- What data are you responsible for?

---

### 2. Data Definition

- What does this data represent?
- How is it used within your team?
- How is it used outside your team (if applicable)?

---

### 3. System & Storage

- Where is this data stored?
  - system, spreadsheet, etc.

- Is there a single source of truth?

---

### 4. Data Entry & Maintenance

- Who enters the data?
- How often is it updated?
- Are there required fields or standards?

---

### 5. Structure & Format

- Are there defined formats or conventions?
  - naming
  - dates
  - categories

- Are these consistently followed?

---

### 6. Data Quality

- What issues do you see with the data?
- Where does inconsistency occur?
- What causes those issues?

---

### 7. Workflow

- Walk me through how data gets created and updated
- Where does it:
  - break down?
  - require manual cleanup?

---

### 8. Integration & Use by Others

- Does another team use your data?
- How is it shared today?
- Are there challenges in using it outside your team?

---

### 9. Alignment with Philanthropy Needs

- Does your data support the following use cases:
  - segmentation
  - engagement tracking
  - reporting

- Are there gaps between how the data is collected and how it is used?

---

### 10. Closing

- If you could fix one thing about this data, what would it be?

---

# Phase 3: Documentation & Standardization

## For Each Data Domain

Document the following:

### Data Definition

- What the data represents  
- Key fields and meanings  

---

### Source of Truth

| Element | System | Owner | Steward |
|--------|--------|------|--------|

---

### Data Structure

| Field | Description | Format | Required |
|------|-------------|--------|---------|

---

### Update Process

- Who updates the data  
- When and how often  
- Expected turnaround time  

---

### Data Quality Rules

- Required fields  
- Valid values  
- Formatting rules  

---

### Known Issues

- Inconsistencies  
- Gaps  
- Risks  

---

# Phase 4: Standardization Plan

## Goals

- Establish consistent structure and expectations
- Reduce ambiguity in data entry
- Enable reliable integration into validation layer

---

## Actions

- Define standard formats for key fields
- Align naming conventions
- Clarify required vs optional fields
- Establish update cadence expectations

---

# Phase 5: Integration Preparation

## Goal

Prepare data for inclusion in the BigQuery validation layer.

---

## Steps

- Identify how data will be ingested:
  - direct system connection  
  - structured sheet  
- Define mapping to existing entities (IDs)
- Determine validation rules needed
- Identify dependencies with Philanthropy use cases

---

# Deliverables

- Data needs definition (Philanthropy-driven)
- Data domain documentation (per domain)
- Defined owner/steward roles
- Standardized field definitions and formats
- Identified integration pathway
- Initial validation rule candidates

---

# Key Principles

- **Start with use case, not data**
- **Data is maintained at the source**
- **Ownership is explicit and respected**
- **Standards are simple and practical**
- **Processes reflect real workflows**
- **Integration follows validation, not the reverse**

---

# Success Criteria

- Philanthropy data needs are clearly defined  
- Each domain has a clearly defined owner and steward  
- Data definitions and structures are documented  
- Inconsistencies are reduced  
- Data is ready for governed integration into BigQuery  

---

# Relationship to Philanthropy Pilot

This work enables:

- reliable enrichment data for Philanthropy  
- reduced manual reconciliation  
- consistent inputs into validation workflows  

Together, these efforts establish:

> a governed, scalable data ecosystem across the school
