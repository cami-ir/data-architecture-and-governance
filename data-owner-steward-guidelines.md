# Data Owner & Steward Guidelines

## 1. Roles and Responsibilities

To maintain the integrity of our "Control Tower" architecture, we define two distinct levels of human governance:

### **The Data Owner (Director)**
* **Accountability:** Ultimately responsible for the data within their specific functional area (e.g., Athletics, Veracross contact and demographic information, etc.).
* **Access Approval:** Determines who has the "Steward" rights to edit or export data from their primary systems.
* **Policy Setting:** Defines the business rules for their data (e.g., "What constitutes an active 'Club' member?").

### **The Data Steward (Daily Manager / Coordinator)**
* **Data Entry:** Ensures all records in systems are entered accurately and follow institutional naming conventions. Ownership in larger systems (e.g., Veracross can be distributed to multiple stewards at the domain level, e.g., outdoor trip rosters vs student demographic data)
* **Validation:** Performs regular audits of their source data to identify duplicates or missing fields.
* **Correction:** Acts as the primary point of contact when the BigQuery Validation Layer flags a discrepancy.

---

## 2. Operational Standards (The "Golden Rules")

### **Rule 1: Source Sovereignty**
The primary system (Veracross, LionLink, etc.) is the only "Source of Truth." 
* **Protocol:** Never request a "patch" in BigQuery or Metabase. All corrections must be made at the source to ensure the next automated sync is clean.

### **Rule 2: The Friday Finalization**
Our automated ingestion engines (Airbyte) run on a synchronized schedule.
* **Protocol:** All weekly data entry, event attendance, and gift processing must be finalized by **Friday at 4:00 PM**. This ensures Monday morning dashboards are 100% accurate.

### **Rule 3: Standardized Formatting**
To prevent "Discrepancy Flags" in the Control Tower, all stewards must use the following formats:
* **Dates:** MM/DD/YYYY
* **Phone Numbers:** +1 (###) ###-####
* **Addresses:** Follow USPS standard abbreviations (St, Ave, Blvd).

---

## 3. The Discrepancy Resolution Process

When data fails a validation check in BigQuery, the following "Healing Loop" is triggered:

1.  **Detection:** The system identifies a mismatch (e.g., an Alumnus in LionLink has a different email than in Veracross).
2.  **Notification:** The Philanthropy Analyst sends a **Discrepancy Report** to the relevant Data Steward.
3.  **Resolution:** The Steward investigates the source record, determines the correct value, and updates the primary system.
4.  **Verification:** The next BigQuery sync automatically clears the flag if the data now passes the validation rules.

---

## 4. Annual Data Audit
Once per year, Data Owners will meet with the Philanthropy Analyst to review:
* **System Health:** Are the automated pipes working?
* **Schema Review:** Do we need to track new fields (e.g., new social media handles or engagement types)?
* **Policy Updates:** Does our current logic for "Active Prospects" still align with our fundraising goals?


## System Roles and Authority

| System Tier | Functional Role | Authority Level |
|------------|-----------------|-----------------|
| **BigQuery / Google Cloud (Control and Governance Layer)** | Central validation and decision layer | Defines how data is evaluated, how discrepancies are resolved, and what is approved for write-back to core systems |
| **Veracross (Operational System)** | System of record for identity and relationships | Primary source of truth for biographical, demographic, and relationship data |
| **DonorPerfect (Operational System)** | System of record for fundraising activity | Primary source of truth for gifts, allocations, and advancement engagement |
| **Satellite Systems (LionLink, Stelter, etc.)** | Data collection environments | Not authoritative; data is treated as unverified until it is validated and approved through BigQuery |
| **Steward-Managed Data (College, Clubs, Athletics)** | Structured data maintained across the school | Owned and maintained by designated stewards; becomes authoritative only after validation through BigQuery |


## Priority Data Domains

| Data Domain | Primary Source | Stewardship | Current State | Target Approach |
|------------|----------------|-------------|---------------|-----------------|
| **Alumni Contact & Demographic Data** | Veracross | Registrar / Data Team | Exists in Veracross but inconsistencies across systems | Maintain Veracross as source of truth and ensure consistent flow to DonorPerfect through validation layer |
| **College Outcomes** | College Counseling | College Counseling Office | Exists in separate system with limited integration | Establish structured input (e.g., connected sheet) maintained by a designated steward and integrated through BigQuery |
| **Athletics Participation** | Veracross | Athletics Department | Exists in Veracross but manually re-entered into DonorPerfect from PDFs | Integrate directly from Veracross to eliminate duplicate entry and improve consistency |
| **Student Activities / Club Involvement** | Not centrally captured | Club Leaders / Activities Office | Informally tracked across spreadsheets or not captured | Evaluate inclusion in Veracross or implement structured collection (connected sheets) with defined ownership |
