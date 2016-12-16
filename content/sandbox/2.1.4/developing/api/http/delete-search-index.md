---
title: "HTTP Delete Search Index"
description: ""
project: "sandbox"
project_version: "2.1.4"
menu:
  sandbox-2.1.4:
    name: "Delete Search Index"
    identifier: "http_delete_search_index"
    weight: 116
    parent: "apis_http"
toc: true
aliases:
  - /riak/2.1.4/dev/references/http/delete-search-index
  - /riak/kv/2.1.4/dev/references/http/delete-search-index
---

Deletes a Riak Search index.

## Request

```
DELETE /search/index/<index_name>
```

## Normal Response Codes

* `204 No Content` --- The index was successfully deleted (also returned
    if the index did not exist to begin with)

## Typical Error Codes

* `503 Service Unavailable` --- The request timed out internally
