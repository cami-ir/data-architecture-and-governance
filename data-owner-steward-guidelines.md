# Data Owner & Steward Guidelines

## Overview

This document outlines how data is managed across the school to support Advancement’s data operations strategy.

The goal is to ensure that data is:
- accurate at the source  
- clearly owned and maintained  
- consistently structured  
- and reliable when it flows into reporting and fundraising systems  

This approach works alongside the central validation layer in BigQuery, where data is reviewed before it becomes part of our core systems.

---

## 1. Roles and Responsibilities

To support this structure, we define two key roles: Data Owners and Data Stewards.

### **Data Owner (Director Level)**

Data Owners are responsible for the overall quality and use of data within their area.

They are responsible for:
- defining what the data represents and how it should be used  
- setting expectations for accuracy and completeness  
- approving who has permission to manage the data  
- ensuring the data supports the needs of the school  

Examples include leaders in areas such as Athletics, College Counseling, or those responsible for Veracross data.

---

### **Data Steward (Daily Manager / Coordinator)**

Data Stewards are responsible for the day-to-day care of the data.

They are responsible for:
- entering and maintaining data using agreed-upon formats  
- ensuring records are complete and up to date  
- reviewing and resolving issues when discrepancies are identified  
- serving as the primary contact for questions about the data  

In larger systems like Veracross, stewardship may be distributed across multiple areas (for example, student demographics vs. activity participation).

---

## 2. Core Practices

These are the shared expectations that keep the system working effectively.

### **1. Maintain Data at the Source**

Each system has a defined role. Updates should always be made in the system where the data is owned.

**In practice:**
- Do not request fixes directly in reports or dashboards  
- Make corrections in the source system so they flow through correctly  

---

### **2. Keep Data Current on a Regular Schedule**

To support consistent reporting, data should be updated on a regular cadence.

**In practice:**
- Complete weekly updates by the end of the work week when possible  
- Ensure event participation, updates, and key changes are entered in a timely way  

---

### **3. Follow Consistent Formatting**

Consistent formatting helps prevent errors and reduces the need for manual cleanup.

**In practice:**
- Use agreed-upon formats for dates, phone numbers, and addresses  
- Follow naming conventions established for your area  

---

## 3. Discrepancy Resolution Process

When data does not align across systems, it is flagged through the validation process.

The resolution process is straightforward:

1. **Detection**  
   A mismatch is identified (for example, conflicting contact information between systems)

2. **Notification**  
   The issue is shared with the appropriate Data Steward

3. **Resolution**  
   The steward reviews the source data, determines the correct value, and updates the source system

4. **Verification**  
   The next data update confirms whether the issue has been resolved

This ensures that corrections are made at the source and remain consistent across systems.

---

## 4. Ongoing Review

At least once per year, Data Owners and key partners review how the system is working.

This includes:
- whether data is flowing as expected  
- whether new data needs have emerged  
- whether definitions or expectations need to be updated  

This helps ensure the system continues to support the school’s needs over time.

---

## System Roles and Authority

| System Tier | Functional Role | Authority Level |
|------------|-----------------|-----------------|
| **BigQuery / Google Cloud (Control and Governance Layer)** | Central validation and decision layer | Defines how data is evaluated, how discrepancies are resolved, and what is approved for use and write-back |
| **Veracross (Operational System)** | System of record for identity and relationships | Primary source of truth for biographical, demographic, and relationship data |
| **DonorPerfect (Operational System)** | System of record for fundraising activity | Primary source of truth for gifts, allocations, and advancement engagement |
| **Satellite Systems (LionLink, Stelter, etc.)** | Data collection environments | Not authoritative; data is treated as unverified until it is validated and approved through BigQuery |
| **Steward-Managed Data (College, Clubs, Athletics)** | Structured data maintained across the school | Owned and maintained by designated stewards; becomes reliable once validated through BigQuery |

---

## Priority Data Domains

| Data Domain | Primary Source | Stewardship | Current State | Target Approach |
|------------|----------------|-------------|---------------|-----------------|
| **Alumni Contact & Demographic Data** | Veracross | Veracross Data Team Members | Exists in Veracross but inconsistencies across systems | Maintain Veracross as source of truth and ensure consistent flow to DonorPerfect through validation layer |
| **College Outcomes** | College Counseling | College Counseling Office | Exists in a separate system with limited integration | Establish structured input (e.g., connected sheet) maintained by a steward and integrated through BigQuery |
| **Athletics Participation** | Veracross | Athletics Department | Exists in Veracross but manually re-entered into DonorPerfect | Integrate directly from Veracross to eliminate duplicate entry and improve consistency |
| **Student Activities / Club Involvement** | Not centrally captured | Club Leaders / Others TBD | Informally tracked or not consistently captured | Evaluate inclusion in Veracross or implement structured collection with defined ownership |
