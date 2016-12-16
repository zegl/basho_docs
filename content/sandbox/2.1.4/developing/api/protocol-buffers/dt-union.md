---
title: "PBC Data Type Union"
description: ""
project: "sandbox"
project_version: "2.1.4"
menu:
  sandbox-2.1.4:
    name: "Data Type Union"
    identifier: "pbc_dt_union"
    weight: 115
    parent: "apis_pbc"
toc: true
aliases:
  - /riak/2.1.4/dev/references/protocol-buffers/dt-union
  - /riak/kv/2.1.4/dev/references/protocol-buffers/dt-union
---

A "union" type for update operations.

## Request

```protobuf
message DtOp {
    optional CounterOp counter_op = 1;
    optional SetOp     set_op     = 2;
    optional MapOp     map_op     = 3;
}
```

The included operation depends on the Data Type that is being updated.
`DtOp` messages are sent only as part of a [`DtUpdateReq`](/riak/kv/2.1.4/developing/api/protocol-buffers/dt-store) message.
