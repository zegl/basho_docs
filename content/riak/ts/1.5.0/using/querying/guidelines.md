---
title: "Guidelines for Querying in Riak TS"
description: "Limitations and rules for querying in Riak TS"
menu:
  riak_ts-1.5.0:
    name: "Querying Guidelines"
    identifier: "querying_guidelines_riakts"
    weight: 500
    parent: "querying_data_riakts"
project: "riak_ts"
project_version: "1.5.0"
toc: true
aliases:
    - /riakts/1.5.0/using/querying/basic-querying
    - /riakts/1.5.0/using/querying/guidelines
canonical_link: "https://docs.basho.com/riak/ts/latest/using/querying/guidelines"
---

[table arch]: ../../../learn-about/tablearchitecture/#data-modeling
[activating]: ../../creating-activating/
[writing]: ../../writingdata/
[planning]: ../../planning#column-definitions
[iso8601]: ../../../timerepresentations/
[SELECT]: /riak/ts/1.5.0/using/querying/SELECT#iso_8601


Riak TS supports several kinds of queries of your TS data. To create the most successful queries possible, there are some guidelines and limitations you should know. 

This document will cover the basic rules of querying in Riak TS, general guidelines to help you create the best queries possible, and all current limitations impacting queries in TS.


## The Basic Rules of Querying

You query data via columns. There are three categories of column, each with a different set of rules for valid queries. Query columns are based on rows in your TS table.

```
CREATE TABLE tab2(
a SINT64 NOT NULL,
b TIMESTAMP NOT NULL,
c BOOLEAN NOT NULL,
PRIMARY KEY  ((a, QUANTUM(b, 1, 's'))<-Partition Key, a,b,c)<-Local Key)
```


### Partition Key

```
PRIMARY KEY  ((a,<-Unquantized QUANTUM(b, 1, 's')<-Quantized)...
```

All queries must cover the partition key fields and must use greater than and less than (>, >=, <, <=).

All unquantized fields in your partition key must be included in the query as exact matches.

Any quantized field in your partition key must be included in the query as a bounded range.

* Valid: `time > 1449864277000 and time < 1449864290000`
* Invalid: `time > 1449864277000`
* Invalid: `time > 1449864277000 or time < 1449864290000`

{{% note title="A Note About `SELECT`" %}}
It is possible to use ISO 8601-compliant date/time strings rather than integer timestamps in SELECT statements. Please see [SELECT](/riak/ts/1.5.0/using/querying/select/#iso-8601) for an example or [Time Representations](/riak/ts/1.5.0/using/timerepresentations/) for more information.
{{% /note %}}


### Local Key

For any field in the local key that is not in the partition key, your
query can include any operator supported for that field's type. Bounded ranges are not required.

```
PRIMARY KEY ((a,b),a,b,c)
```

Here 'c' is in the local key only so does not have to be in the query.

Column names from the local key must be compared using strict equality against literal values. No ranges are permitted, `!=` must not be used, and `or` will not work.

* Valid: `country_code = 'uk'`
* Invalid: `(country_code = 'uk' or country_code = 'de')`
* Invalid: `country_code != 'se'`
* Invalid: `temperature < 85.0`


### Column Definitions

[Column definitions][planning] may be queried with unbounded ranges, `!=`, and `or` comparisons.


### General Guidelines

Before you begin querying, there are some guidelines to keep in mind.

* Columns may not be compared against other columns in the query.
* When using `or`, you must surround the expression with parentheses or your query will return an error.

Basic queries return the full range of values between two given times for an instance within a class or type of data. In the example table, `state` is an instance within the `region`:

```sql
CREATE TABLE GeoCheckin
(
   region       VARCHAR   NOT NULL,
   state        VARCHAR   NOT NULL,
   time         TIMESTAMP NOT NULL,
   weather      VARCHAR NOT NULL,
   temperature  DOUBLE,
   PRIMARY KEY (
     (region, state, QUANTUM(time, 15, 'm')),
     region, state, time
   )
)
```

Your query must include all components of the partition key. If any part of the partition key is missing, you will get an error.

## SQL Support

A small subset of SQL is supported. All columns are of the format:

```sql
Field    Operator   Constant
```

The following operators are supported for each data type:

|           |=  |!= |>  |<  |<= |>=|
|-----------|---|---|---|---|---|---|
| varchar   | X | X |   |   |   |   |
| blob      | X | X |   |   |   |   |
| boolean   | X | X |   |   |   |   |
| sint64    | X | X | X | X | X | X |
| double    | X | X | X | X | X | X |
| timestamp | X | X | X | X | X | X |


## Limitations

* Column to column comparisons are not currently supported.
* Secondary indexing (2i) will not work with Riak TS.
* Riak Search will not work with Riak TS.
* Queries are limited by the number of quanta they can span when specifying the time limits.

#### Blob data in queries and primary keys

Blob data should be queried using integers in base 16 (hex) notation, preceded by `0x` using riak shell or by providing any block of data (e.g. binary, text or JSON) through a Riak client library.

However, we do not recommend using blob columns in primary keys yet, due to limitations in the Riak TS 1.5 `list_keys` API.

#### Quanta query range

A query covering more than a certain number of quanta (5 by default) will generate the error `too_many_subqueries` and the query system will refuse to run it. Assuming a default quantum of 15 minutes, the maximum query time range is 75 minutes.

In the below example we set a quantum of 15s:

```sql
CREATE TABLE GeoCheckin
 (geohash VARCHAR NOT NULL,
  location VARCHAR NOT NULL,
  user VARCHAR NOT NULL,
  time TIMESTAMP NOT NULL,
  weather VARCHAR NOT NULL,
  temperature VARCHAR,
    PRIMARY KEY((location, user, QUANTUM(time, 15, 's')),
                location, user, time))
```

The maximum time range we can query is 60s, anything beyond will fail.

See the Data Modeling section in [Table Architecture][table arch] for more information.
