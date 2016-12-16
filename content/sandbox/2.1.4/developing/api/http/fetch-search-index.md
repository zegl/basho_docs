---
title: "HTTP Fetch Search Index"
description: ""
project: "sandbox"
project_version: "2.1.4"
menu:
  sandbox-2.1.4:
    name: "Fetch Search Index"
    identifier: "http_fetch_search_index"
    weight: 115
    parent: "apis_http"
toc: true
aliases:
  - /riak/2.1.4/dev/references/http/fetch-search-index
  - /riak/kv/2.1.4/dev/references/http/fetch-search-index
---

Retrieves information about a Riak Search [index](/riak/kv/2.1.4/developing/usage/search/#simple-setup).

## Request

```
GET /search/index/<index_name>
```

## Normal Response Codes

* `200 OK`

## Typical Error Codes

* `404 Object Not Found` --- No Search index with that name is currently
    available
* `503 Service Unavailable` --- The request timed out internally

## Response

If the index is found, Riak will output a JSON object describing the
index, including its name, the [`n_val`](/riak/kv/2.1.4/developing/app-guide/replication-properties/#a-primer-on-n-r-and-w) associated with it, and the [search schema](/riak/kv/2.1.4/developing/usage/search-schemas) used by the index. Here is an example:

```json
{
  "name": "my_index",
  "n_val": 3,
  "schema": "_yz_default"
}
```
