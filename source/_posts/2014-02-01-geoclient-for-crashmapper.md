---
layout: post
#title: Almost a fifth of NYC's officially published collision data is ambiguous or wrong
title: ⅕ of NYC collision data wrong
date: 2014-02-01
thumbnail: /images/neptune-and-brighton.png
comments: on
---

New York has really stepped up its open data game in the last year.  Data sets
like [ACRIS][] (the city property records) and [MapPLUTO][] (GIS) that used to
cost thousands of dollars are now free.  While it's in beta with limited
access, the city now makes available its official geocoder, too.  This openness
is drawing into harsh relief excctly how poor the quality of the city's
collision statistics are.

  [ACRIS]: https://data.cityofnewyork.us/data?browseSearch=acris
  [MapPLUTO]: https://data.cityofnewyork.us/City-Government/Primary-Land-Use-Tax-Lot-Output-Map-MapPLUTO-/f888-ni5f

The NYPD has been releasing intersection-level collision reports every month
since August 2011.  I've been collecting and processing these reports from an
obfuscated Excel (originally only PDF) format into [machine-readable
CSVs][crash band-aid].

  [crash band-aid]: http://nypd.openscrape.com/

These reports are the basis for [NYC Crashmapper][], an interactive map of
these collisions across the city.  Unfortunately, the actual releases do not
include geographical information; they include only the borough, police
precinct, and street intersection.  With some help from [Tom Swanson][], most
of these intersections were geocoded using ArcGIS, while new intersections
appearing on the monthly report were batched through Google's public geocoder.

  [NYC Crashmapper]: http://nyc.crashmapper.com/
  [Tom Swanson]: http://arcgis.com/apps/PublicGallery/index.html?appid=130c910362124107907482d762ff6a01&group=1ab97dd0518e47e59e47686f479e241d

This process yielded longitude and latitude for about 97% of the almost 44,000
intersections with collisions on record for the last several years.  However,
there were clearly problems with the data.  Sometimes Google would get it
wrong, placing an intersection well outside the boundaries of New York, or
simply place an intersection in the wrong police precinct.  Occasionally
I would do cleanings to filter these out, but at heart Google's geocoder is
something of a black box.  I knew some percentage of the intersections had the
wrong longitude/latitude, but it was impossible to know precisely how many, or
how wrong they were.

While NYC's [own geocoder][] has been floating around for a while, it was
originally a Windows-only executable.  I messed around with it, but booting up
a Virtualbox and clicking around in a GUI couldn't be easily integrated into
an automated workflow.

  [own geocoder]: http://www.nyc.gov/html/dcp/html/bytes/applbyte.shtml#geocoding_application

Now the same data is available, although it requires an app registration and
delay (several days, for me), as the [Geoclient API][].  Six REST endpoints
provide longitude and latitude, alongside a host of other info (city council
districts, police precincts, etc.) as JSON based off of address, intersection,
blockface, place name, BBL, or BIN input.  I wrapped the API in [Python
bindings][] to make it a bit easier to work with.

  [Geoclient API]: https://developer.cityofnewyork.us/api/geoclient-api-beta
  [Python bindings]: https://github.com/talos/nyc-geoclient

Upon receiving email confirmation from DoITT that my app had been approved to
use the API, I ran through the 44,000 intersections.  There doesn't appear to
be any kind of rate limiting, and the process went relatively quickly.  There's
no batch feature at the moment, so each request must be made individually.

<table>
  <tr><th></th>                                 <th># of intersections</th> <th>%</th></tr>
  <tr><th>Successfully geocoded</th>            <td>36058</td>              <td>82.37</td></tr>
  <tr><th><i>""" (precinct match)</i></th>      <td><i>33700</i></td>       <td><i>76.99</i></td></tr>
  <tr><th><i>""" (precinct mismatch)</i></th>   <td><i>2358</i></td>        <td><i>5.39</i></td></tr>
  <tr><th>Streets do not intersect</th>         <td>4139</td>               <td>9.46</td></tr>
  <tr><th>Streets intersect twice</th>          <td>2651</td>               <td>6.06</td></tr>
  <tr><th>Streets intersect more than twice</th><td>626</td>                <td>1.43</td></tr>
  <tr><th>Invalid street name</th>              <td>149</td>                <td>0.34</td></tr>
  <tr><th>Place name instead of street name, non-addressable</th><td>77</td><td>0.17</td></tr>
  <tr><th>Misspelled street name</th>           <td>32</td>                 <td>0.07</td></tr>
  <tr><th>One street name was 'UNKNOWN'</th>    <td>21</td>                 <td>0.05</td></tr>
  <tr><th>Place name instead of street name, addressable</th><td>19</td>    <td>0.04</td></tr>
  <tr><th>Other ("not part of")</th>            <td>2</td>                  <td>0.00</td></tr>
</table>

The success rate was much less than the combined ArcGIS/Google approach: almost
18% of the intersections could not be associated with lon/lats.  However, the
Geoclient's error messages are great.  Instead of pulling the wrong lon/lat or
nothing at all, it identifies exactly what's going wrong: in almost 1 in 10
intersections in the reports, the identified streets *don't even intersect*.

In many cases, this can be chalked up to a misspelling, generally a missed
prefix or switched up Avenue, Street, or Place -- for example, the intersection
of 32 Street and Flatbush Ave in Brooklyn.  Clearly East 32 Street must have
been intended.  In many other cases, the information must simply be wrong.  One
intersection, of Ocean Parkway and Seton Place in Brooklyn, is merely
impossible.

The "streets intersect twice" phenomenon is interesting, and even approximately
solvable.  This happens in cases like the [intersection of Brighton 3 Street
and Neptune Avenue][] in Brooklyn, where the cross street jogs
a short distance.  It's possible to ask the geocoder for the more northerly or
southerly intersection, however, the NYPD data is still ambiguous as to which
was closer.

  [intersection of Brighton 3 Street and Neptune Avenue]: https://www.google.com/maps/preview/place/Neptune+Ave+%26+Brighton+3rd+St,+Brooklyn,+NY+11235/@40.5807057,-73.9650921,17z/data=!4m2!3m1!1s0x89c24444753fe54d:0xc02ed3f455d9a605

<p class="center"><iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d3030.2287594726517!2d-73.9650921!3d40.5807057!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c24444753fe54d%3A0xc02ed3f455d9a605!2sNeptune+Ave+%26+Brighton+3rd+St%2C+Brooklyn%2C+NY+11235!5e0!3m2!1sen!2sus!4v1391291435007" width="400" height="300" frameborder="0" style="border:0"></iframe></p>

The last significant chunk of missed geocoding is because of intersections
"more than twice".  This can happen in intersections like [Avenue K and King's
Highway][] where the layout of one of the streets results in
multiple crossings.

  [Avenue K and King's Highway]: https://www.google.com/maps/preview/place/Kings+Hwy+%26+Avenue+K,+Brooklyn,+NY/@40.6257719,-73.9331992,18z/data=!4m2!3m1!1s0x89c24355b603e4cf:0xc31b80b14b1a7c1b

<p class="center"><iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1514.0931806910887!2d-73.9331992!3d40.6257719!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c24355b603e4cf%3A0xc31b80b14b1a7c1b!2sKings+Hwy+%26+Avenue+K%2C+Brooklyn%2C+NY!5e0!3m2!1sen!2sus!4v1391292147906" width="400" height="300" frameborder="0" style="border:0"></iframe></p>

There were an additional slightly more than 5% of intersections that were
geocoded, but whose police precincts did not match.  Since this is all
intersection-level data, this is to be expected in some cases: intersections
can skirt precinct boundaries, and in such cases it would be unclear which
precinct the "real" report would come from.  However, there were odd cases
where the NYPD filed an intersection under the wrong precinct, for example,
filing the [intersection of Avenue V and Ocean Parkway][] in
Brooklyn in the 60, instead of the 61 precinct where it actually is.

  [intersection of Avenue V and Ocean Parkway]: https://www.google.com/maps/preview/place/Ocean+Pkwy+%26+Avenue+V,+Brooklyn,+NY+11223/@40.5957238,-73.9650048,17z/data=!3m1!4b1!4m2!3m1!1s0x89c244f5dc18ba85:0xcae280f4057393a3

<p class="center"><iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d3029.5483480885487!2d-73.9650048!3d40.5957238!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c244f5dc18ba85%3A0xcae280f4057393a3!2sOcean+Pkwy+%26+Avenue+V%2C+Brooklyn%2C+NY+11223!5e0!3m2!1sen!2sus!4v1391272537346" width="400" height="300" frameborder="0" style="border:0"></iframe></p>

Even if the data quality on the existing reports were perfect, the information
would be hobbled by the identification by intersection.  The data is assembled
from the state's [MV-104][] forms, which do not have to specify a location more
precisely than an intersection.  Officers fill out these forms on-site, and any
mistakes or inaccuracies on the form will be entered into the database, without
any sort of further checking.

  [MV-104]: http://www.dmv.ny.gov/forms/mv104.pdf

Google was far more liberal dispensing coordinates.  Its geocoder was able to
provide coordinates for the vast majority of the intersections Geoclient
couldn't, however these coordinates are very suspect.

<table>
  <tr><th></th>                   <th># of intersections</th><th>%</th>
  <tr><th>Geocoded in both</th>   <td>36055</td>             <td>82.37%</td>
  <tr><th><i>""" (&gt; 0.01 lat/lon difference)</i></th><td><i>180</i></td><td><i>0.41%</i></td>
  <tr><th><i>""" (&lt; 0.01, &gt;0.0003 lat/lon difference)</i></th><td><i>378</i></td><td><i>0.86%</i></td>
  <tr><th>Google only</th>        <td>6490</td>              <td>14.83%</td>
  <tr><th>Geoclient only</th>     <td>3</td>                 <td>0.00%</td>
  <tr><th>Neither</th>            <td>1226</td>              <td>2.80%</td>
</table>

In cases where both geocoders captured a lon/lat but there was a significant
difference, the NYC geocoder was superior.  For example, it was able to capture
the [intersection of East 27 St and 1 Avenue][] in Manhattan.  Google was
unable to understand that East 27 St continues even though it is closed off to
cars, and erroneously identified the intersection of East 2 St and 1 Ave.

  [intersection of East 27 St and 1 Avenue]: https://www.google.com/maps/preview/place/NYU+Med+Center:+Hilz+Max+J+MD/@40.7394131,-73.9764686,18z/data=!4m7!1m4!3m3!1s0x89c2598378c717a7:0x266d24f6c67a6b6d!2s27+1st+Ave,+New+York,+NY+10003!3b1!3m1!1s0x0:0x649aab3e087f8735

<p class="center"><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1511.5139148409382!2d-73.97646857235236!3d40.73941314916777!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x649aab3e087f8735!2sNYU+Med+Center%3A+Hilz+Max+J+MD!5e0!3m2!1sen!2sus!4v1391294585211" width="400" height="300" frameborder="0" style="border:0"></iframe></p>

Even fairly minute differences in longitude or latitude signal problems with
the Google geocoding -- for example, a difference as small as 0.0003 degree
indicates that Google mixed up Beach Terrace and Oak Terrace on their
[intersection across Beekman Ave][] in the Bronx.

  [intersection across Beekman Ave]: https://www.google.com/maps/preview/place/%2B40%C2%B048'33.62%22,+-73%C2%B054'48.60%22/@40.80934,-73.9135,17z/data=!3m1!4b1!4m2!3m1!1s0x0:0x0

<p class="center"><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1509.9293108982622!2d-73.9134544024479!3d40.80910044385041!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zKzQwwrA0OCczMy42MiIsIC03M8KwNTQnNDguNjAi!5e0!3m2!1sen!2sus!4v1391296500495" width="400" height="300" frameborder="0" style="border:0"></iframe></p>

While the Geoclient geocoder is not able to make clear statements about many of
the intersections in the NYPD collision dataset, it does a far better job for
those it identifies.  Those it cannot, which Google does, are ambiguous in the
cases where the Geoclient's error was that there are multiple intersections
(about 7.5%), and generally indicate an NYPD data entry error in the cases
where Geoclient recognizes no intersection (almost 10%).

What can be done now that it's so clear how problematic these reports are?

1. The NYPD should be pressed to cooperate with DoITT to geocode intersections
   on the reports they file, and double check those that don't pass through the
   geocoder.  Even if the reports, being state mandated, can't be modified, the
   geocoder is the perfect tool to catch bad data at the time of entry.

2. If the Geoclient API identifies a problem, the officer who entered
   problematic information should be asked to clarify.  The correction or
   comment would be entered into the monthly release.

3. The NYPD could switch to a daily feed of MV-104 reports, and such
   a check could be worked directly into the filing process.
