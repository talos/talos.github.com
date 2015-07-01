---
layout: post
#title: The NYPD's crash data has a booboo.  Here's a band-aid.
title: NYPD crash data band-aid
date: 2012-02-16
thumbnail: /images/bandaid.png
comments: true
---

Yesterday, [Streetsblog][] wrote about the previous day's New York
City Council hearing on traffic safety.  There have been several
particularly gruesome incidents in the past year where New York
drivers maimed and killed pedestrians and cyclists.  The New York City
Police Department has not only barely investigated the crime scenes,
but it has been incredibly callous towards the victims, their
families, and the press.

  [Streetsblog]: http://www.streetsblog.org/2012/02/15/nypds-lax-crash-investigations-may-violate-state-law

[This part][] stuck out to me:

  [This part]: http://www.streetsblog.org/2012/02/15/nypds-lax-crash-investigations-may-violate-state-law

> Council Member Jessica Lappin got into an animated discussion with
> Petito over traffic crash data. When Lappin asked why NYPD is
> releasing data in PDF form — and only after the council adopted
> legislation forcing the department to do so — Petito replied that the
> department is "concerned with the integrity of the data itself."
> Petito said NYPD believes data released on a spreadsheet could be
> manipulated by people who want "to make a point of some sort." An
> incredulous Lappin assured Petito that the public only wants to
> analyze the data to improve safety, not use it for "evil."

I already knew that they were finally releasing -- after the Council
forced them to -- crash data as [idiotically obfuscated PDFs][], but
reading that they justified this out of concern for "the integrity of
the data," was so galling that it goaded me into action. I would make the
data accessible as friendly, [parseable CSVs][].

  [idiotically obfuscated PDFs]: http://www.nyc.gov/html/nypd/html/traffic_reports/motor_vehicle_accident_data.shtml
  [parseable CSVs]: http://nypd.openscrape.com/

After all, isn't the purpose of data to "make a point of some sort"?

Since I am hosting copies of their data in a format (spreadsheets, oh
my!) amenable to the forces of evil on my server, I recommend that you
download the code to roll your own NYPD traffic crash CSVs:

    git clone https://github.com/talos/nypd-crash-data-bandaid.git

Once you've got it, run the shell script:

    cd nypd-crash-data-bandaid/
    ./download.sh

You'll need python, [xpdf][], and wget.  Full instructions are in the
readme on [Github][].

  [xpdf]: http://www.foolabs.com/xpdf/
  [Github]: http://www.github.com/talos/nypd-crash-data-bandaid

The NYPD replaces the previous month's files every month.  Thus I've
included a sample crontab, which checks the site for a new PDFs every
day.  Of course, they don't rename the files, which means that it's
necessary to download one and do the PDF conversion merely to
ascertain what month it applies to.  Incredible.

There's an extra script, rss.py, which makes it easy to generate RSS feeds for when the NYPD has updated their data.  You can see it in action [here][].

  [here]: http://nypd.openscrape.com/feed.xml

I'd like to thank David Turner for writing the [original][] NYPD crash
data PDF->text converter, which was only linked to in an article from
a [few months back][].  I had to modify the output to reflect the
multidimensionality of the vehicle types and accident categories in a
flat file, but the parser itself was golden.  I'd also like to thank
Matthew Kime, who came up with the band-aid idea for the name.

  [original]: http://novalis.org/programs/scrapeintersections.txt
  [few months back]: http://www.streetsblog.org/2011/10/14/nypd-goes-out-of-its-way-to-obscure-street-safety-data/

Now we just need someone to compare this to the NYS Department of
Transportation's crash data as visualized through Transportation
Alternatives' [CrashStat][], which only runs up 2009.

  [CrashStat]: http://crashstat.org/
