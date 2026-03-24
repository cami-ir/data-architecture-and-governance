
# Cloud Function to PATCH to Veracross

```mermaid
graph TD
    subgraph Metabase [Step 1: Approval]
        A[User clicks 'Commit'] -->|Update| B[(Registry: COMMITTED)]
    end

    subgraph Auth [Step 2: Authentication]
        C[Cloud Function] -->|Client Credentials| D[Veracross OAuth]
        D -->|Bearer Token| C
    end

    subgraph Execution [Step 3: The Patch]
        B --> C
        C -->|PATCH /v3/contact_info/| E[Veracross API]
        E -->|Status 204| F[Registry: RESOLVED]
        E -->|Status 4XX/5XX| G[Registry: ERROR]
    end

    style B fill:#fff3cd,stroke:#664d03
    style D fill:#d1e7dd,stroke:#0f5132
    style G fill:#f8d7da,stroke:#842029
```
## Deploying the Cloud Function
```mermaid
graph TD
    subgraph Setup [Step 1: Configuration]
        A[Function Name: nightly-veracross-sync]
        B[Trigger: HTTP]
        C[Authentication: Require HTTPS]
    end

    subgraph Code [Step 2: The Files]
        D[<b>main.py</b><br/>Paste the sync logic]
        E[<b>requirements.txt</b><br/>Paste the library list]
    end

    subgraph Entry [Step 3: The Target]
        F["<b>Entry Point:</b><br/>nightly_batch_sync"]
    end

    A & B & C --> D
    D & E --> F
    F --> G[Click Deploy]

    style F fill:#d1e7dd,stroke:#0f5132,stroke-width:2px
    style G fill:#007bff,color:#fff
