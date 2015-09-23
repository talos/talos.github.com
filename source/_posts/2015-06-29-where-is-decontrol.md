---
layout: post
title: Whither Rent Regulation
date: 2015-07-01
thumbnail: /images/stabilization-thumb.jpg
comments: on
---

The rent stabilization law that keep apartments affordable for millions of New
Yorkers was just renewed, [warts and all](http://gothamist.com/2015/06/23/cuomo_rent_albany_samo.php).

The fight in Albany between tenant advocates and politicians centered around
closing loopholes in the law.  The worst allows stabilized apartments to exit
the program when their rent gets high enough, resulting in the loss of
thousands of affordable apartments every year -- far exceeding new construction
of affordable apartments.

### Secrecy

But if you ask [the agency in charge of rent stabilization][1] which buildings
are losing stabilized apartments, they won't tell you.  In fact, they reject
any Freedom of Information Law requests for data regarding the number of
apartments in the stabilization program by building, citing unclear privacy
concerns.

  [1]: http://www.nyshcr.org/

The only information they'll release is a [list of buildings][2] that have
apartments in the program.  The list doesn't indicate whether every apartment in
a building is stabilized, or if only some are.  **Buildings that are 100%
stabilized look the same on this list as buildings with just one apartment left in
the program.**

  [2]: https://github.com/clhenrick/dhcr-rent-stabilized-data

The secrecy blanketing the stabilization program makes it very difficult to
understand how loopholes in the program affect affordability in different
neighborhoods over time.  Not only does this make life hard for tenant
advocates, but it provides cover for landlords who fail to tell the state
(register) their stabilized apartments.  Registration is voluntary -- another
loophole in the law -- and failure to do so could be an indication that they
are overcharging their tenants.

If a landlord doesn't like charging the legal rent, they can simply "forget" to
register.  It's up to the tenant to take them to court to comply.

### Hidden in plain sight

Remarkably, the number of stabilized apartments in each building over the last
seven years is hidden in plain sight, in property tax bills.  With help from
a few civic hackers, I built [taxbills.nyc](http://taxbills.nyc), a collection
of every tax bill going back to 2008 for every building that might be
stabilized in New York City.

Putting together this site required downloading hundreds of thousands of tax
bills PDFs over several months because New York City's [Department of
Finance][3] (DoF) wanted $50,000 to mail me files that could already be found
free online.  More on that in the next post.

  [3]: http://www1.nyc.gov/site/finance/index.page

> ...approximately 1,000 hours at a cost to you of $50.36 per hour is needed to
> fulfill your request... <cite>[DoF Records Access Office][4]</cite>

  [4]: https://www.muckrock.com/foi/new-york-city-17/all-property-tax-documents-on-nycproperty-17246/#comm-146539

Using this data, I've put together [a
map](https://docker4data.cartodb.com/viz/766a0f32-1ea1-11e5-b267-0e49835281d6/embed_map)
that shows precisely where stabilized apartments have disappeared, remained,
or been constructed between 2007 and 2014.

<noscript>![Changes in stabilized apartment counts 2007-2014](/images/stabilization.jpg)[5]</noscript>

  [5]: https://docker4data.cartodb.com/viz/766a0f32-1ea1-11e5-b267-0e49835281d6/embed_map

<iframe width='100%' height='520' frameborder='0'
src='https://docker4data.cartodb.com/viz/766a0f32-1ea1-11e5-b267-0e49835281d6/embed_map'
allowfullscreen webkitallowfullscreen mozallowfullscreen oallowfullscreen
msallowfullscreen></iframe>

The map is meant to enable quick comparisons between four classes of buildings.

1. <span style="color:red;">__Major Losses__</span>, in red, buildings where
   *50% or more* of the apartments in the building have left stabilization between
   2007 and 2014.  These buildings are densest in the Upper East Side of
   Manhattan, where the high-rent vacancy loophole has allowed very large numbers
   of apartments to exit the program.  However, Bushwick is also a hotspot for this
   class, which would suggest that landlords there are failing to register the
   stabilized apartments in their buildings.

2. <span style="color:#cc0;">__Decreases__</span>, in yellow through
   orange, buildings where *up to 50%* of the
   apartments in the building have left stabilization.  The Upper East Side again
   leads the way in losses here, but there are significant patches of loss along
   the high-density stabilized corridor from Prospect Park to the ocean in
   Brooklyn along Ocean Ave, and along Queens Boulevard in Forest Hills.

3. <span style="color:blue;">__Steady__</span>, in blue, buildings where the
   number of stabilized apartments has *remained the same* or very slightly
   increased.  In Manhattan, Chinatown and
   Washington Heights have held their apartments relatively well; much of the Bronx
   along the Grand Concourse has, too.  Those landlords who are registering in
   Bushwick, Brooklyn often are registering the same number of apartments 2014 as 2007.
   Many buildings on Ocean ave in Brooklyn have held steady, too.

4. <span style="color:green;">__Increases__</span>, in cyan through green,
   buildings where the number of stabilized apartments has *increased 10% or more*.
   These are often new developments with affordable housing.

Buildings with more apartments have larger diameter circles, and precise unit
counts, subsidies, and addresses  are available by hovering or clicking on
their circle.

Color is based off of the percentage change in stabilized apartments over the
total number of apartments in the building.  So a building with 20 apartments
total that had 10 stabilized in 2007, and 5 stabilized in 2014, would be a 25%
loss.  Its circle would be orange.

### Uses

By using the map and its underlying data, advocates should be able to identify
buildings:

* just starting to lose significant numbers of stabilized apartments

* whose landlords have stopped registering with the state, and thus may contain
  tenants at risk of overcharge

It is also possible to break down losses and gains by any political boundary,
so electeds can understand how loopholes are affecting rental affordability
for their constituents.

### Get the data!

The underlying data is available in several CSV tables on
[taxbills.nyc](http://taxbills.nyc).  The underlying scrapers, which download
the bills, and parsers, which turn the HTML pages and PDFs downloaded into
tabular data, can be found [on
GitHub](http://github.com/talos/nyc-stabilization-unit-counts).

The guide to using the data is on
[GitHub](https://github.com/talos/nyc-stabilization-unit-counts#data-usage).
