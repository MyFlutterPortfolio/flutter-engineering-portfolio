# Dealio Agent Search Contract

Endpoint: `POST /api/ai/agent-search`

Status endpoint: `GET /api/ai/agent-search/status/{requestId}`

## Request

```json
{
  "schemaVersion": "dealio.agent_search.v1",
  "clientRequestId": "ags_<dedupe-hash>_<utc-microseconds>",
  "dedupeKey": "ags_<stable-query-hash>",
  "intent": "shopping_search",
  "query": {
    "text": "iPhone 15 under $900",
    "normalized": "iphone 15 under $900"
  },
  "locale": {
    "language": "en",
    "country": "US"
  },
  "context": {
    "conversation": "user: I need a compact phone...",
    "productId": "optional-product-id"
  },
  "controls": {
    "limit": 4,
    "priority": "interactive",
    "timeoutMs": 12000,
    "progressive": true
  },
  "cache": {
    "enabled": true,
    "ttlSeconds": 600,
    "dedupeWindowSeconds": 90
  },
  "capabilities": {
    "rankProducts": true,
    "verifyPrices": true,
    "returnSources": true,
    "priceAlertCandidate": true
  },
  "client": {
    "app": "dealio",
    "platform": "android"
  }
}
```

Headers:

- `Idempotency-Key`: same as `clientRequestId`
- `X-Dedupe-Key`: same as `dedupeKey`
- `X-Agent-Search-Schema`: `dealio.agent_search.v1`

## Response

```json
{
  "schemaVersion": "dealio.agent_search.v1",
  "status": "ready",
  "requestId": "server-request-id",
  "clientRequestId": "ags_<dedupe-hash>_<utc-microseconds>",
  "dedupeKey": "ags_<stable-query-hash>",
  "provider": "agent-orchestrator",
  "cache": {
    "status": "hit"
  },
  "queue": {
    "status": "completed",
    "position": 0,
    "nextPollMs": 0
  },
  "meta": {
    "resultStage": "stage3-ai-ranked",
    "query": "iPhone 15 under $900",
    "limit": 4,
    "searchStatus": "ready",
    "searchStage2Status": "ready",
    "searchStage3Status": "ready",
    "priceVerifiedAt": "2026-06-07T16:00:00.000Z",
    "aiRankedAt": "2026-06-07T16:00:02.000Z"
  },
  "result": {
    "summary": "AI-ranked best match: iPhone 15 128GB from Example Store.",
    "sources": ["https://store.example/product"],
    "products": [
      {
        "id": "product-id",
        "title": "iPhone 15 128GB",
        "store": "Example Store",
        "price": 799,
        "currency": "USD",
        "link": "https://store.example/product",
        "score": 92,
        "reason": "Strong price, trusted seller, good fit.",
        "imageUrl": "https://cdn.example/image.jpg",
        "offerCount": 4,
        "priceConfidence": 94,
        "priceVerifiedAt": "2026-06-07T16:00:00.000Z",
        "availability": true,
        "aiRanked": true
      }
    ]
  }
}
```

Queued response:

```json
{
  "schemaVersion": "dealio.agent_search.v1",
  "status": "queued",
  "requestId": "server-request-id",
  "clientRequestId": "ags_<dedupe-hash>_<utc-microseconds>",
  "dedupeKey": "ags_<stable-query-hash>",
  "queue": {
    "status": "queued",
    "position": 3,
    "nextPollMs": 900
  }
}
```

Client behavior:

- Reuses `dedupeKey` for cache/dedupe and `clientRequestId` for idempotency.
- Polls queued responses with `GET /api/ai/agent-search/status/{requestId}`.
- Treats `status: "processing"` with products as a preview while backend enriches stage2 live prices and stage3 AI ranking.
- Uses `meta.resultStage` to distinguish `stage1-preview`, `stage2-price-verified`, and `stage3-ai-ranked`.
- Falls back to existing `/search` contract in demo/dev or when the new agent endpoint is unavailable.
