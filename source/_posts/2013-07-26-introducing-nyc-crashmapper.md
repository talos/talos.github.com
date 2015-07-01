---
layout: post
title: Introducing NYC Crashmapper
date: 2013-07-26
thumbnail: /images/nyc-crashmapper.jpg
comments: true
---

For over a year, I've been archiving and processing the New York City Police
Department's collision data on the [Crash Data Band-Aid][].

  [Crash Data Band-Aid]: http://nypd.openscrape.com/

With some help from [generous people][], all valid intersections have been
geocoded in the past several months.  So now all the collision data, in addition
to being free for download above, can be visualized and analyzed in your
browser using [Crashmapper][]!

  [generous people]: https://github.com/talos/nypd-crash-data-bandaid#credit
  [Crashmapper]: http://nyc.crashmapper.com

[![NYC Crashmapper](/images/nyc-crashmapper.jpg)](http://nyc.crashmapper.com)

The project is free and open source, you can browse the code [on Github][]
(it's in the `map` directory).

  [on Github]: https://github.com/talos/nypd-crash-data-bandaid/

Building the map's been fun.  There's no server-side app &mdash; it's just
a static site on [S3][] &mdash; and all data points for some 30K intersections
over more than 24 months are loaded into your browser for fast analysis.  The
base layers are from [OSM][], and the mapping library is [Leaflet][].  I'm
using a slightly optimized [fork][] of the awesome [Leaflet.markercluster][]
plugin.  The "heatmap" is really a bunch of CSS drop shadows around marker
clusters.  The real deep-link custom URLs are possible by setting the error
page on S3 to `index.html`, so that all links are served up through the app's
[Backbone][] router.

  [S3]: https://aws.amazon.com/s3/
  [OSM]: http://openstreetmap.org/
  [Leaflet]: http://leafletjs.com/
  [fork]: https://github.com/talos/Leaflet.markercluster/tree/nonlocking-addlayers
  [Leaflet.markercluster]: https://github.com/Leaflet/Leaflet.markercluster
  [Backbone]: http://backbonejs.org/

Crashmapper could be adapted to your town.  Contact me on the left if you're
interested!
