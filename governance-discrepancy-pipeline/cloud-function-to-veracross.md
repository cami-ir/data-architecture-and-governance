
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
```
## Create OAuth Applicaton in Veracross to enable API access add needed scopes
- households:read
- persons:read
- contact_info:update (required for the PATCH request)
  
## Cloud function main.py
This script follows the Client Credentials Flow to get a bearer token before looping through your BigQuery "Committed" queue.
```Python
import requests
import json
from google.cloud import bigquery

# Configuration (Best practice: Load these from Secret Manager)
SCHOOL_ROUTE = "your_school_slug"
CLIENT_ID = "your_client_id"
CLIENT_SECRET = "your_client_secret"
REVISION = "2023-01-01" # Replace with current Veracross API revision

def get_access_token():
    """Step 1: The Handshake"""
    auth_url = f"https://accounts.veracross.com/{SCHOOL_ROUTE}/oauth/token"
    data = {
        'grant_type': 'client_credentials',
        'scope': 'contact_info:update'
    }
    response = requests.post(auth_url, data=data, auth=(CLIENT_ID, CLIENT_SECRET))
    return response.json().get('access_token')

def nightly_batch_sync(event, context):
    token = get_access_token()
    client = bigquery.Client()
    
    # Fetch records approved by humans in Metabase
    query = "SELECT * FROM `governance.discrepancy_registry` WHERE status = 'COMMITTED'"
    rows = client.query(query).result()

    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json",
        "X-API-Revision": REVISION
    }

    for row in rows:
        # Step 2: Format the PATCH per Veracross V3 docs
        url = f"https://api.veracross.com/{SCHOOL_ROUTE}/v3/contact_info/{row.entity_id}"
        
        # We wrap the update in the "data" object as required
        payload = {
            "data": {
                row.field_name: row.expected_value
            }
        }

        try:
            res = requests.patch(url, headers=headers, json=payload)
            
            if res.status_code == 204: # Veracross returns 204 for successful PATCH
                status, msg = 'RESOLVED', None
            else:
                status, msg = 'ERROR', res.text[:200]
                
        except Exception as e:
            status, msg = 'ERROR', str(e)

        # Step 3: Write the result back to the Registry
        update_bq_status(row.discrepancy_id, status, msg)
```

