---
layout: post
title: Play with over 40 years of NYC property data
date: 2014-05-10
thumbnail:
---

Once upon a time, you had to run a scraper for a few months to play with NYC's
property records database, ACRIS.

Thankfully, the whole database is now published in an open format on the
[city's open data portal][].

  [city's open data portal]: https://nycopendata.socrata.com/data?browseSearch=acris

Unfortunately, documentation for the databases is nearly nonexistent, and the
data portal doesn't make it particularly easy to download the dataset -- it's
several uncompressed multi-gigabyte CSVs.

As the CSVs originated in a relational database, you need to load them back
into one to make much use of it.  I put together a [Postgres schema][] for this
purpose, but unless you've got access to some pretty serious hardware, it'll
be slow going analyzing the database.

  [Postgres schema]: https://github.com/talos/acris-schema

Fortunately, Google recently [cut its rates][] for its cloud SQL analytics
tool, [BigQuery][].  While each query may cost a few pennies, it's possible to
do breakdowns of all the property records in New York in a few seconds instead
of dozens of minutes or hours.  You might even save some money on electricity,
all told.

  [cut its rates]: https://developers.google.com/bigquery/pricing
  [BigQuery]: https://cloud.google.com/products/bigquery/

So, in all its glory, help yourself to all of [NYC's property records][],
packaged and ready for analytics!

  [NYC's property records]: https://bigquery.cloud.google.com/table/acris-bigquery:acris.flat

### How to use it

First, you'll need to [sign up][] for API access to BigQuery.  You shouldn't
need to sign up for billing, as you have 100GB of data processing free per
month.  Be careful though, because it's easy to burn through!

  [sign up]: https://developers.google.com/bigquery/sign-up

Once you've done that, you should be able to browse the tables and run queries.
There are four tables imported from the data portal:

  * __legals__: Confusingly named in the source dataset, every row in this
    table is a single property (identified by a BBL, a tax lot identifier)
    involved in a real estate transaction. [16,455,977 rows]  If a property is
    involved in multiple transactions, each transaction will have a separate
    entry.

  * __master__: Every row in this table is a single transaction -- for
    example, the transfer of a single deed, the creation, transfer, or
    repayment of a mortgage, and so on.  All the other tables make reference to
    this table's document ID.  A single transaction can involve an arbitrary
    number of parties or properties. [25,327,414 rows]

  * __parties__: Every row in this table is a single legal entity, person or
    corporation, involved in a transaction.  These are not grouped.  This means
    that, for example, Bank of America has a separate entry here for every
    mortgage it makes. [33,992,844 rows]

  * __references__: Every row in this table links together two different
    entries in the __master__ table.  For example, if a mortgage were assigned
    from a lender to a third party, that would be recorded here.  This table is
    not complete, however, as many references are missing.  [4,182,587 rows]

You'll notice that there's a fifth table, __flat__.  This is a simple join of
all these tables across the __master__ table's document ID.  While this means
a lot of data is duplicated (it has 165,131,922 rows), it also allows us to run
breakdowns and groupings across the entire dataset without having to do a join
between several multi-million row tables.

For example:

Who has issued the most mortgages in each borough between 2000 and 2012?

    SELECT
      SUBSTR(Name, 0, 6) grp_name,
      NTH(1, Name) full_name,
      YEAR(Recorded_datetime) year,
      COUNT(DISTINCT Document_ID) count,
      COUNT(DISTINCT IF(borough = 1, Document_ID, NULL)) mnh,
      COUNT(DISTINCT IF(borough = 2, Document_ID, NULL)) brx,
      COUNT(DISTINCT IF(borough = 3, Document_ID, NULL)) brk,
      COUNT(DISTINCT IF(borough = 4, Document_ID, NULL)) qns
    FROM acris.flat
    WHERE YEAR(Recorded_datetime) BETWEEN 2000 and 2012
      AND Party_type = 2
      AND Doc_type = 'MTGE'
    GROUP EACH BY grp_name, year
    HAVING count > 2000
    ORDER BY year DESC, count DESC



What are the biggest real estate purchases since 2003 (when purchase amounts
begin to be recorded in the database)?

    SELECT * FROM acris.master  # Use acris.master since we're not grouping
    WHERE Doc_type IN ('DEED', 'DEEDO')  # These are the codes for a deed transfer
    ORDER BY Document_amt DESC LIMIT 100;  # Put the biggest transactions on top

This query takes a few seconds and processes ~2.4GB of data.


