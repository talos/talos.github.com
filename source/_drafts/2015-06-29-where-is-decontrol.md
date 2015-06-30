---
layout: post
title: Where is decontrol
date: 2015-06-28
thumbnail: /images/decontrol.png
comments: on
---

The rent stabilization law that keep apartments affordable for millions of New
Yorkers was just renewed, warts and all.

The fight in Albany between tenant advocates and politicians centered around
closing loopholes in the law.  The most egregious allows stabilized apartments
to exit the program when they reach $2,500 in rent per month, resulting in the
loss of thousands of affordable apartments every year -- far exceeding new
construction of affordable units.

But if you ask the state agency in charge of the program, Homes and Community
Renewal, which buildings are losing units, and how many, they won't tell you.
In fact, they turn down any Freedom of Information Law requests for data
regarding the stabilization program, even when there is no clear privacy
concern.

The only information they'll release is a list of buildings that have units in
the program.  The list doesn't indicate whether the building is fully
stabilized, or only has 1 unit left.

The secrecy blanketing the stabilization program makes it very difficult to
understand how loopholes in the program affect affordability in different
neighborhoods over time.  Not only does this impede advocacy, but it provides
cover for landlords who fail to voluntarily register their units, which could
be an indication that they are in violation of the law.

Remarkably, the percentage of stabilized units per building over time is hidden
in plain sight, in every building's tax bills.  With help from a few civic
hackers, I built [taxbills.nyc](http://taxbills.nyc), a repository of every tax
bill going back to 2008 for every building that could be stabilized in New
York.

Using this data, I've put together [a
map](https://docker4data.cartodb.com/viz/766a0f32-1ea1-11e5-b267-0e49835281d6/public_map)
that shows precisely where stabilized units are disappearing, holding steady,
or being constructed.

The underlying data is available in several CSV tables on
[taxbills.nyc](http://taxbills.nyc).  The underlying scrapers, which download
the bills, and parsers, which turn the HTML pages and PDFs downloaded into
tabular data, can be found [on
GitHub](http://github.com/talos/nyc-stabilization-unit-counts).

* A [crosstab table with stabilized unit count
  changes](http://taxbills.nyc/joined.csv) for every possibly stabilized
  building in New York.  There could  be stabilized buildings not on the list,
  but it is unlikely.  Any building with 6 or more units as well as any building
  that was ever on HCR's own list of stabilized buildings was scraped.  Buildings
  are aggregated by BBL.
  - __borough__: Borough of this lot.
  - __ucbbl__: The BBL.
  - __2007uc__: The unit count in 2007.  This is based off of the rent
    stabilization surcharge dated "4/1/2007", which appears in tax bills
    starting 2008.  The parser sums these counts when a single tax bill
    includes multiple buildings, but is careful not to double-count if previous
    years' surcharges reappear.
  - __2007est__: Whether or not this is an estimated unit count.  As
    registration is voluntary, it is common for a building to miss a year, or
    even several.  In such cases, an estimate is made using the previous year's
    count *if* a Disability Rent Increase Exemption (DRIE) or Senior Citizen
    Rent Increase Excemption (SCRIE) appears on the tax bill, *or* if the same
    abatements (for example, a 421a abatement) are collected as the prior year,
    *or* if the building appeared on HCR's rent stabilized buildings list that
    year.
  - __2007dhcr__: Whether the building appeared on DHCR's list that year.
    Blank if DHCR did not publish a list for that year.
  - __2007abat__: A list of all abatements and exemptions claimed on that
    year's tax bill.  This includes 421a, J51, 420C (LIHTC), SCRIE, DRIE, and
    several others.
  - *These columns repeat for every year up to and including 2014*
  - __cd__: The community district, from PLUTO.  All remaining columns are from
    PLUTO.
  - __ct2010__: Census tract in 2010 census.
  - __cb2010__: Census block in 2010 census.
  - __council__: The city council district.
  - __zipcode__: The zip code.
  - __address__: An address for the lot, although it could have several.
  - __ownername__: The name of the lot's owner.  Oftentimes just an LLC.
  - __numbldgs__: The number of buildings on the lot.
  - __numfloors__: The approximate number of floors on the lot's buildings.
  - __unitsres__: An approximate number of residential units in the lot's
    buildings.
  - __unitstotal__: An approximate number of residential & commercial units in
    the lot's buildings.
  - __yearbuilt__: An approximate year built, not particularly accurate.
    Especially poor quality in older buildings.
  - __condono__: The condo number, which links together different lots into a
    single condo development.
  - __lon__: The lot's centerpoint longitude.
  - __lat__: The lot's centerpoint latitude.

* The same table as above [but not a crosstab](http://taxbills.nyc/joined-nocrosstab.csv),
  which means that there is a separate row for every year of a lot's unit
  counts, instead of many columns.

* A [summary of building changes](http://taxbills.nyc/joined-nocrosstab.csv)
  over the seven-year span.  This is the table that underlies the map.
  - __ucbbl__: The BBL.
  - __diff__: The number of stabilized units gained or lost between 2007 and
    2014.
  - __percentchange__: The percentage increase or loss.  The denominator for
    this calculation is the greatest of `unitsres`, `unitstotal`, or the
    greatest number of stabilized units reported on a tax bill.
  - __j51__: Start and end year of any J51 abatement.  Earliest start possible
    is 2009.
  - __j51__: Start and end year of any 421-a abatement.  Earliest start possible
    is 2009.
  - __j51__: Start and end year of any SCRIE abatement.  Earliest start possible
    is 2009.
  - __j51__: Start and end year of any DRIE abatement.  Earliest start possible
    is 2009.
  - __j51__: Start and end year of any 420C abatement.  Earliest start possible
    is 2009.
  - *All remaining columns are from PLUTO as above.*

* The [raw data](http://taxbills.nyc/rawdata.csv): big kahuna.  1.7GB,
  including every detail that can be extracted from a tax bill.  The schema is
  described [on GitHub](https://github.com/talos/nyc-stabilization-unit-counts#to-parse-the-raw-data-into-a-csv), too.  All the above data are [transformations](https://github.com/talos/nyc-stabilization-unit-counts/blob/master/cross-tab-rs-counts.sql) of this dataset.
  - __bbl__: Lot identifier.
  - __activityThrough__: Date of the tax bill.
  - __section__: The section of the bill in which the charge appeared.  For
    example, `Previous Balance`, `Tax Year Charges Remaining`, `Current Charges`,
    etc.
  - __key__: The type of data on this line.  For example, `Owner name`,
    `Housing-Rent stabilization`, `Health-Extermination`, etc.
  - __dueDate__: If this is a charge, when it is due.  Not very accurate except
    for the rent stabilization lines.
  - __activityDate__: If this is a payment, when it was made.  Not very accurate.
  - __value__: The value of the line.  If the `key` was `Owner name` this would
    be their actual name; if it was `Health-Extermination` it would be the charge
    for the extermination, etc.
  - __meta__: Additional metadata recorded on the line.  For rent stabilization,
    this is the registration number.  For some payments it is the bank that
    actually made the payment.
  - __apts__: Only for rent stabiliztion lines, this is the stabilized unit
    count.
  - __bbl__: Lot identifier.
  - __activityThrough__: Date of the tax bill.
  - __section__: The section of the bill in which the charge appeared.  For
    example, `Previous Balance`, `Tax Year Charges Remaining`, `Current Charges`,
    etc.
  - __key__: The type of data on this line.  For example, `Owner name`,
    `Housing-Rent stabilization`, `Health-Extermination`, etc.
  - __dueDate__: If this is a charge, when it is due.  Not very accurate except
    for the rent stabilization lines.
  - __activityDate__: If this is a payment, when it was made.  Not very accurate.
  - __value__: The value of the line.  If the `key` was `Owner name` this would
    be their actual name; if it was `Health-Extermination` it would be the charge
    for the extermination, etc.
  - __meta__: Additional metadata recorded on the line.  For rent stabilization,
    this is the registration number.  For some payments it is the bank that
    actually made the payment.
  - __apts__: Only for rent stabiliztion lines, this is the stabilized unit
    count.
