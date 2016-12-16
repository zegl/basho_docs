---
title: "PBC Data Type Set Store"
description: ""
project: "sandbox"
project_version: "2.1.4"
menu:
  sandbox-2.1.4:
    name: "Data Type Set Store"
    identifier: "pbc_dt_set_store"
    weight: 118
    parent: "apis_pbc"
toc: true
aliases:
  - /riak/2.1.4/dev/references/protocol-buffers/dt-set-store
  - /riak/kv/2.1.4/dev/references/protocol-buffers/dt-set-store
---

An operation to update a set, either on its own (at the bucket/key
level) or [inside of a map](/riak/kv/2.1.4/developing/api/protocol-buffers/dt-map-store).

## Request

```protobuf
message SetOp {
    repeated bytes adds    = 1;
    repeated bytes removes = 2;
}
```

Set members are binary values that can only be added (`adds`) or removed
(`removes`) from a set. You can add and/or remove as many members of a
set in a single message as you would like.
