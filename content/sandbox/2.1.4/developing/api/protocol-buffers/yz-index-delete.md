---
title: "PBC Yokozuna Index Delete"
description: ""
project: "sandbox"
project_version: "2.1.4"
menu:
  sandbox-2.1.4:
    name: "Yokozuna Index Delete"
    identifier: "pbc_yz_index_delete"
    weight: 122
    parent: "apis_pbc"
toc: true
aliases:
  - /riak/2.1.4/dev/references/protocol-buffers/yz-index-delete
  - /riak/kv/2.1.4/dev/references/protocol-buffers/yz-index-delete
---

Delete a search index.

## Request

The `name` parameter is the name of the index to delete, as a binary.

```protobuf
message RpbYokozunaIndexDeleteReq {
    required bytes name  =  1;
}
```
