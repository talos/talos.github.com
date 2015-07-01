---
layout: post
title: New NYC buildings less efficient
date: 2013-07-05
excerpt: Large buildings constructed in New York City since 1935 are by today's standards less energy efficient.
thumbnail: /images/efficiency.png
comments: true
---

Large buildings constructed in New York City since 1935 are by today's
standards less energy efficient.

<script type="text/javascript"
src="//ajax.googleapis.com/ajax/static/modules/gviz/1.0/chart.js">
{"dataSourceUrl":"//docs.google.com/spreadsheet/tq?key=0ApIF6WU115ROdDk4bVpDUW90UDFPQ3QtV1I1SVYtU1E&transpose=0&headers=1&range=A1%3AB23&gid=5&pub=1","options":{"titleTextStyle":{"bold":true,"color":"#000","fontSize":16},"vAxes":[{"useFormatFromData":true,"title":"Score","minValue":40,"viewWindowMode":"explicit","logScale":false,"viewWindow":{"min":40,"max":80},"maxValue":80},{"title":"#
of
buildings","useFormatFromData":false,"formatOptions":{"source":"inline"},"minValue":0,"viewWindowMode":"explicit","format":"0.##","gridlines":{"color":"none"},"logScale":false,"viewWindow":{"min":0,"max":300},"maxValue":300}],"series":{"0":{"color":"#ff0000"},"1":{"errorBars":{"errorType":"none"}},"2":{"color":"none"}},"fontName":"Courier
New","title":"Median \"Energy Star\" over year built,
NYC","curveType":"function","booleanRole":"certainty","animation":{"duration":0},"legend":"top","lineWidth":2,"useFirstColumnAsDomain":true,"hAxis":{"useFormatFromData":true,"title":"Year
Built (5-year
blocks)","minValue":null,"viewWindow":{"min":null,"max":null},"maxValue":null},"width":600,"height":229},"state":{},"view":{},"isDefaultVisualization":true,"chartType":"LineChart","chartName":"Chart
1"} </script>

Reading [this article][] from Metropolis Mag on what's wrong with green
architecture, and [LEED][] certification in particular, I noticed references to
New York City measuring energy efficiency for some famous buildings: the
Chrysler Building, the new 7 World Trade Center, and the Seagram Building,
amongst others.  Drawing from a [Times article][], they observed that the newer
buildings, even LEED certified ones, performed worse:

  [this article]: http://www.archdaily.com/396263/why-green-architecture-hardly-ever-deserves-the-name/
  [LEED]: http://www.usgbc.org/leed
  [Times article]: http://www.nytimes.com/2012/12/25/science/earth/new-york-citys-effort-to-track-energy-efficiency-yields-some-surprises.html

> Among other reasons for this failing, the Times pointed to the widespread
> use of expansive curtain-wall glass assemblies and large, “deep-plan” designs
> that put most usable space far from exterior walls, forcing greater reliance on
> artificial light and ventilation systems.

> <i><small>from [archdaily.com](http://www.archdaily.com/396263/why-green-architecture-hardly-ever-deserves-the-name/)</small></i>

The Times and Metropolis mag stuck to anecdotal evidence, not looking beyond
a few buildings.  Fortunately, the city put all the scores [online][].

  [online]: http://www.nyc.gov/html/gbee/html/plan/ll84_scores.shtml

So it's easy to test: are buildings constructed since the advent of mid-century
modern building techniques less energy efficient?

Of 4000 reports, about 1600 recorded an actual "Energy Star Score",

> ENERGY STAR Score: A 1-to-100 percentile ranking for specified building
> types, as calculated by Portfolio Manager, with 100 being the best score and 50
> the median. It compares the energy performance of a building against the
> Commercial Buildings Energy Consumption Survey (CBECS), a national database,
> and independent industry surveys for that building type.  This rating is
> normalized for weather and building attributes in order to obtain a measure of
> efficiency.

> <i><small>from [nyc.gov](http://www.nyc.gov/html/dof/downloads/pdf/12pdf/2012_data_disclosure.pdf)</small></i>

1600 ain't a bad sample size.  And what buildings are on the sheet?

> ...all privately-owned properties with individual buildings over 50,000 square
> feet or with multiple buildings with a combined square footage over 100,000
> square feet...

> <i><small>from [nyc.gov](http://www.nyc.gov/html/gbee/html/plan/ll84_scores.shtml)</small></i>

Big office buildings.

The essential context, "When was this building built?" was missing.  But there
were [BBL][]s, the NYC property identification number.  Since the [Department
of Finance][] makes available BBL-indexed [tax roll data][] with when buildings
were built, all's that had to be done was to download the tax roll, [convert
it][] from MS Access format (fun!) and join it to the environmental ratings.

  [BBL]: http://nycprop.nyc.gov/nycproperty/nynav/jsp/selectbbl.jsp
  [Department of Finance]: http://www.nyc.gov/html/dof/
  [tax roll data]: http://www.nyc.gov/html/dof/html/property/assessment.shtml
  [convert it]: https://github.com/brianb/mdbtools

Keeping the sample size respectable by looking in five-year-increments, the
pattern is clear: large buildings constructed prior to 1935 do much
better by today's energy efficiency standards than those constructed after.

I'm making the [environmental data joined to year built][] available as a CSV
for anyone to play with.  Below is a chart including sample sizes, for the
statistically curious.

  [environmental data joined to year built]: https://docs.google.com/file/d/0B5IF6WU115ROY1lJZzJ6bWRraE0/edit?usp=sharing

<script type="text/javascript"
src="//ajax.googleapis.com/ajax/static/modules/gviz/1.0/chart.js">
{"dataSourceUrl":"//docs.google.com/spreadsheet/tq?key=0ApIF6WU115ROdDk4bVpDUW90UDFPQ3QtV1I1SVYtU1E&transpose=0&headers=1&range=A1%3AC23&gid=0&pub=1","options":{"vAxes":[{"useFormatFromData":true,"title":"Score","minValue":40,"viewWindowMode":"explicit","logScale":false,"viewWindow":{"min":40,"max":80},"maxValue":80},{"title":"#
of
buildings","useFormatFromData":false,"formatOptions":{"source":"none"},"minValue":0,"viewWindowMode":"pretty","gridlines":{"color":"none"},"logScale":false,"viewWindow":{"min":0,"max":300},"maxValue":300}],"titleTextStyle":{"bold":true,"color":"#000","fontSize":16},"series":{"0":{"color":"#cccccc","targetAxisIndex":1},"1":{"errorBars":{"errorType":"none"}},"2":{"color":"none"}},"fontName":"Courier
New","booleanRole":"certainty","title":"Median \"Energy Star\" over year built,
NYC","animation":{"duration":500},"legend":"top","useFirstColumnAsDomain":true,"hAxis":{"useFormatFromData":true,"title":"Year
Built (5-year
blocks)","minValue":null,"viewWindowMode":null,"viewWindow":null,"maxValue":null},"tooltip":{},"isStacked":false,"width":600,"height":229},"state":{},"view":{"columns":[{"calc":"stringify","type":"string","sourceColumn":0},1,2]},"isDefaultVisualization":true,"chartType":"ColumnChart","chartName":"Chart
1"} </script>

