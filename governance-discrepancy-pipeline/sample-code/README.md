# Sample Queries for Governance and Detection

## Detection code
Running one unified "Detection Job" is often much easier to manage (and cheaper on the BigQuery bill) than scheduling 50 tiny individual queries.

- Sample code for unified-detection:  It uses Common Table Expressions (CTEs) to isolate the logic for each rule, then "stacks" them using a UNION ALL to pipe everything into your persistent discrepancy table.
