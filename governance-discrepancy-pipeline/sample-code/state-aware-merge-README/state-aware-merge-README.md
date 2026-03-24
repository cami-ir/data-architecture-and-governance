# State-Aware MERGE Pattern
This sample SQL ensures that if Rule 001 finds an error on "Customer A" today, and it found that same error yesterday, you don't get two rows. You just update the "Last Seen" timestamp on the existing row.

## Layer 4: State Management Flow (Portrait)
This diagram shows how the MERGE act as a gatekeeper to keep your resolution dashboard clean.
```mermaid
graph TD
    subgraph NewDetection [Layer 3 Output]
        S[Freshly Detected<br/>Discrepancies]
    end

    subgraph Logic [The MERGE Gatekeeper]
        S --> Match{Already in<br/>Discrepancy Table?}
        
        Match -- "Yes (Status: OPEN)" --> Update[<b>UPDATE</b><br/>Bump 'Last Seen' date<br/>Keep single row]
        
        Match -- "No" --> New[<b>INSERT</b><br/>Set Status to 'OPEN'<br/>Create new record]
        
        Match -- "Yes (Status: RESOLVED)" --> New2[<b>INSERT</b><br/>Re-open as new issue]
    end

    subgraph State [Layer 4: Persistent State]
        Update --> Table[(Final Discrepancy Table)]
        New --> Table
        New2 --> Table
    end

    subgraph UserAction [Human/System Feedback]
        Table --> Dashboard[Governance Dashboard]
        Dashboard --> Resolve[Manual Fix / Override]
        Resolve -- "UPDATE status='RESOLVED'" --> Table
    end

    style Table fill:#dfd,stroke:#333,stroke-width:2px
    style Logic fill:#f9f9f9,stroke:#666,stroke-dasharray: 5 5

## Why this is "Governance" and not just "Reporting":
- Deduplication: Your analysts don't wake up to 5,000 alerts for the same 10 broken rows. They see 10 rows with an occurrence_count of 5,000.
- Audit Trail: You can track the "Life of a Discrepancy"—exactly when it first appeared and the last time the system verified it was still broken.
- Human-in-the-loop: Because the table is persistent, a human can go into your "Resolution Table," change a status to DISMISSED or RESOLVED, and the MERGE logic will respect that state.
