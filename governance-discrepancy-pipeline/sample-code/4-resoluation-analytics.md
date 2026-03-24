# Layer 4. Resolution & Analytics
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
