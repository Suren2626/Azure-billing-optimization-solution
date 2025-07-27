# Azure Cost Optimization: Managing Billing Records

## Problem Summary

We need to optimize costs for storing billing records in a **read-heavy**, **serverless** architecture using **Azure Cosmos DB**. Records older than 3 months are rarely accessed, and access latency must remain low even for old data.

## Solution Overview

We propose a **tiered storage architecture**:
- **Hot Tier** (Azure Cosmos DB): Stores records for the past 3 months.
- **Cold Tier** (Azure Blob Storage with Azure Functions or Data Lake): Stores older records in compressed JSON or Avro format.

### Key Benefits

- ✅ No changes to existing API contracts.
- ✅ Seamless migration of old data (zero downtime).
- ✅ Reduced Cosmos DB RU/s and storage costs.

## Architecture Diagram

![Architecture](structure/architecture_diagram.png)

## How It Works

1. **Billing API** writes all records to Cosmos DB.
2. **Azure Function (Timer Trigger)** runs daily/weekly:
   - Moves records older than 3 months to Blob Storage.
   - Deletes archived records from Cosmos DB.
3. **API Gateway + Function Proxy** checks Cosmos DB first; if record not found, falls back to Blob Storage.
4. **Monitoring Dashboards** use Azure Monitor and Log Analytics to track access latency and query counts.

## Technologies Used

- Azure Cosmos DB (Serverless)
- Azure Blob Storage or Azure Data Lake Gen2
- Azure Functions (Timer and HTTP Triggers)
- Terraform for deployment
- Kusto Query Language (KQL) for monitoring
