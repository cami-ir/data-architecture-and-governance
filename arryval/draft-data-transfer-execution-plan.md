# Two-Week Execution Plan: Arryval → Veracross (Summer Readiness)

## Goal
Establish a simple, repeatable process to:
- extract Arryval data
- identify new vs existing households
- create or link records in Veracross

---

# Week 1: Understand + Set Up the Foundation

## Day 1–2: Define Your Data Inputs

Arryval
- Identify available exports:
  - applicants
  - parents/guardians
  - households (if separate)
- Confirm:
  - export format (CSV, Excel)
  - frequency (manual is fine for now)

Veracross
- Pull exports for:
  - households (with IDs)
  - people (with emails)
  - students/applicants

Output
- You have 2 datasets:
  - Arryval export
  - Veracross export

---

## Day 3: Load into Working Environment

Use:
- BigQuery (preferred) OR
- Google Sheets (acceptable for V1)

Create tables/sheets:
- arryval_applicants
- arryval_parents
- veracross_households
- veracross_people

Output
- All data is visible and queryable in one place

---

## Day 4–5: Build Basic Matching Logic

Start simple:

Rule 1 (Primary)
- Parent email match → existing household

Rule 2
- No email match → new household

Create a working table:
- applicant_name
- parent_email
- match_status (existing / new / review)
- veracross_household_id (if matched)
- action (create / link / review)

Output
- First pass classification of all Arryval records

---

# Week 2: Operationalize + Test the Process

## Day 6–7: Separate Into Action Files

Create two outputs:

### 1. New Records File
- new households
- new parents
- new applicants

### 2. Existing Household File
- applicants linked to existing households
- matched parent references

Output
- Clean, structured CSVs ready for import

---

## Day 8: Define Import Templates

Work with Veracross import structure:

- Household import fields
- Person import fields
- Applicant import fields

Decide:
- required fields
- field mappings from Arryval → Veracross

Output
- Draft import templates ready

---

## Day 9: Run Small Test Import

Use a small batch (5–10 families):

- test new household creation
- test linking to existing household
- verify:
  - relationships
  - no duplicates
  - correct structure

Output
- Validated import approach

---

## Day 10: Adjust + Document Process

Refine based on test:

- fix formatting issues
- adjust matching rules if needed
- clarify edge cases

Document:

### Simple Runbook
1. Export Arryval data  
2. Load into working table  
3. Run matching  
4. Review flagged records  
5. Generate import files  
6. Upload to Veracross  
7. Spot check results  

Output
- Repeatable, documented workflow

---

# Ongoing Summer Process (After Week 2)

Run this cycle regularly:

- Export → Match → Review → Import → Validate

Cadence:
- Weekly (or more frequent during peak admissions)

---

# Guardrails (Critical)

- Match on email only for auto-linking  
- If unsure → review, do not auto-match  
- Prioritize correct households over speed  
- Always spot check after import

---

# Success Criteria

By the end of Week 2:

- You can reliably:
  - identify new vs existing households
  - create clean records in Veracross
- You have:
  - a working matching process
  - import templates
  - a repeatable workflow

---

# What You Are NOT Doing Yet

- No API integration  
- No automation  
- No advanced matching logic  
- No full governance layer  

Those come later.

---

# Bottom Line

This plan gets you:

- operational for summer
- accurate enough to trust
- simple enough to execute consistently

And it sets you up for your larger architecture later.
