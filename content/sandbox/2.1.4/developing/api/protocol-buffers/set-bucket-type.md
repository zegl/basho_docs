---
title: "PBC Set Bucket Type"
description: ""
project: "sandbox"
project_version: "2.1.4"
menu:
  sandbox-2.1.4:
    name: "Set Bucket Type"
    identifier: "pbc_set_bucket_type"
    weight: 113
    parent: "apis_pbc"
toc: true
aliases:
  - /riak/2.1.4/dev/references/protocol-buffers/set-bucket-type
  - /riak/kv/2.1.4/dev/references/protocol-buffers/set-bucket-type
---

Assigns a set of [bucket properties](/riak/kv/2.1.4/developing/api/protocol-buffers/set-bucket-props) to a
[bucket type](/riak/kv/2.1.4/developing/usage/bucket-types).

## Request

```protobuf
message RpbSetBucketTypeReq {
    required bytes type = 1;
    required RpbBucketProps props = 2;
}
```

The `type` field specifies the name of the bucket type as a binary. The
`props` field contains an [`RpbBucketProps`](/riak/kv/2.1.4/developing/api/protocol-buffers/get-bucket-props).
