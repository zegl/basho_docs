---
title: "Riak KV 2.1.4 Release Notes"
description: ""
project: "sandbox"
project_version: "2.1.4"
menu:
  sandbox-2.1.4:
    name: "Release Notes"
    identifier: "index_release_notes"
    weight: 101
    parent: index
aliases:
  - /riak/2.1.4/community/release-notes
toc: true
---

# Riak KV 2.1.4 Release Notes

Released April 11, 2016.

This is a bugfix release providing patches for the [Riak init file](http://docs.basho.com/community/productadvisories/codeinjectioninitfiles/) Product Advisory and the [leveldb segfault](http://docs.basho.com/community/productadvisories/leveldbsegfault/) Product Advisory.

## Upgraded Components

* LevelDB has been updated to version 2.0.17
* node_package has been updated to version 3.0.0. [See the node_package release notes](https://github.com/basho/node_package/blob/develop/RELEASE-NOTES.md)

## Bugs Fixed

* [[Issue #796](https://github.com/basho/riak/issues/796)/[PR #798](https://github.com/basho/riak/pull/798)] riak-debug has been updated to be compatible with Solaris systems.
