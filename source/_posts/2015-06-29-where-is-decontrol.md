---
layout: post
title: Where is decontrol
date: 2015-06-28
thumbnail: /images/stabilization-thumb.jpg
comments: on
---

The rent stabilization law that keep apartments affordable for millions of New
Yorkers was just renewed, warts and all.

The fight in Albany between tenant advocates and politicians centered around
closing loopholes in the law.  The worst allows stabilized apartments
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

<!--
![Changes in stabilized unit counts 2007-2014](/images/stabilization.jpg)[1]

  [1]: https://docker4data.cartodb.com/viz/766a0f32-1ea1-11e5-b267-0e49835281d6/public_map
-->

<iframe width='100%' height='520' frameborder='0'
src='https://docker4data.cartodb.com/viz/766a0f32-1ea1-11e5-b267-0e49835281d6/embed_map'
allowfullscreen webkitallowfullscreen mozallowfullscreen oallowfullscreen
msallowfullscreen></iframe>

The map is meant to enable quick comparisons between four classes of buildings.

1. __Major Losses__, in red, buildings where 50% or more of the units in the
   buildingi have left stabilization between 2007 and 2014.  These buildings
   are densest in the Upper East Side of Manhattan, where the high-rent vacancy
   loophole has allowed very large numbers of units to exit the program.
   However, Bushwick is also a hotspot for this class, which would suggest that
   landlords there are failing to register the stabilized units in their
   buildings.
2. __Decreases__, in yellow through orange, buildings where up to 50% of the
   units in the building have left stabilization.  The Upper East Side again
   leads the way in losses here, but there are significant patches of loss along
   the high-density stabilized corridor from Prospect Park to the ocean in
   Brooklyn along Ocean Ave, and along Queens Boulevard in Forest Hills.
3. __Steady__, in blue, buildings where the number of stabilized units has
   remained the same or very slightly increased.  In Manhattan, Chinatown and
   Washington Heights have held their units relatively well; much of the Bronx
   along the Grand Concourse has, too.  Those landlords who are registering in
   Bushwick, Brooklyn often are registering the same number of units 2014 as 2007.
   Many buildings on Ocean ave in Brooklyn have held steady, too.
4. __Increases__, in cyan through green, buildings where the number of
   stabilized units has increased 10% or more.  These are often new
   developments with affordable housing.

By using the map and its underlying data, advocates should be able to identify
buildings that are just starting to lose significant numbers of units, or may
not be properly registered by their owners.

It also should be possible to aggregate along arbitrary political boundaries,
so electeds can understand how loopholes are affecting rental affordability
for their constituents.

The underlying data is available in several CSV tables on
[taxbills.nyc](http://taxbills.nyc).  The underlying scrapers, which download
the bills, and parsers, which turn the HTML pages and PDFs downloaded into
tabular data, can be found [on
GitHub](http://github.com/talos/nyc-stabilization-unit-counts).

The guide to using the data on
[GitHub](https://github.com/talos/nyc-stabilization-unit-counts#data-usage).
