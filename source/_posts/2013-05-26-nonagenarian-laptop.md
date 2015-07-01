---
layout: post
title: Preparing a Mac laptop for your Grandma
date: 2013-05-26
thumbnail: /images/prefs.png
comments: true
---

My grandma got a new laptop for Mother's Day.  She's in her nineties, and first
started using a computer a few years ago.  Email, watching music on
YouTube, and playing bridge online are now essential parts of her life.
Her first computer was an old iBook, which still works fine, but the services
she uses have rendered it unusable:

### The pace of obsolecence on the Internet is unacceptable.

A huge number of websites use JavaScript for questionable bells and whistles,
under the assumption everyone has a really fast JS interpreter.  A PowerPC
running OSX 10.4 simply can't run it fast enough, and these sites don't degrade
gracefully -- they freeze up.

Flash doesn't make this better.  Adobe simply gave up on this at a certain
point, and [Ten Four Fox](http://www.floodgap.com/software/tenfourfox/), which
was her only option after a certain point, didn't really properly support Flash
either.  Losing YouTube was harsh for her, and I can't imagine why it was
really necessary -- when she first got the computer, it worked fine.

The computer was fine, but the internet dropped support for her.  And in the
most frustrating way: everything ran slower, broke in random and unexpected
ways, and it was very hard to explain to her what was going on, why, or what to
do about it.  Sadly, the only option was to get her a new computer.

### Setting up a new Mac for an old person is an epic pain in the ass

It's probably not better on Windows or Linux distributions, and since she'd
learned on a Mac, that was the only practical option.  Fortunately the
interface didn't change too drastically between 10.4 and 10.8, but the factory
setup of the OS is piss poor for an old person.  Because either the guest
account was active by default, or she (or someone else) accidentally activated
it, I had the pleasure of setting her computer up to make it accessible to her
several times.  So the steps got stuck in my head:

* __Disable the guest account.__  Go to System Preferences, unlock
  your prefs, click on "Guest User", and uncheck "Allow Guests to log on to
  this computer".  Otherwise, it's possible to log on, set things up, save
  files, and set up bookmarks on Safari -- and lose everything as soon as you
  log out.

* __Auto log in the correct account.__ In "Security and Privacy", uncheck
  "Require password for sleep and screen saver".  Uncheck "Disable automatic
  login".  Select the proper user in "Automatically log in as", enter their
  password, and press "OK".  For bonus points, you could set up a separate
  non-admin account for them, although I didn't do this.

* __Allow apps only from the app store.__ I didn't do this, but I probably
  should have -- she doesn't use any applications that aren't in-browser, so
  anything else is probably a security risk.

* __Make the cursor bigger.__ She could barely see the cursor on the new
  computer, partly because the screen resolution was much higher.  Go to
  "Universal Access", then "Mouse and Trackpad", and make the cursor bigger for
  comfort.

* __Make everything bigger.__ Her new laptop has the same size screen, but much
  higher resolution.  LCDs don't look great below their natural resolution, but
  for someone without great eyes, the slight blurriness is not noticeable at
  all -- and it's the best way to make sure everything is bigger.  I cut her
  resolution from 1440 by 900 to 1024 by 640.  Go to "Displays", then
  "Display", and reduce the resolution.

* __Always make the screen as bright as possible.__  Still in "Displays",
  increase the brightness to maximum.  Uncheck "Automatically adjust
  brightness".  Then, go to "Energy Saver", then "Battery" and disable
  "Slightly dim the display when using this power source".

* __Increase general contrast.__  Go to "Universal Access", then "Seeing", and
  raise the "Enhance contrast" setting a bit underneath "Display" -- a little
  bit goes a long way.

* __Make the cursor slower.__ By default, the cursor is pretty jumpy if you
  don't have very sure fingers -- go to "Trackpad" and lower the tracking
  speed.

* __Turn off two-finger scrolling.__  In "Trackpad", uncheck everything under
  "Scroll & Zoom".

* __Turn off trackpad actions, especially fancy multi-touch actions.__  In
  "Trackpad", uncheck everything under "Point & Click" and "More Gestures".

* __Maximize and always show the Dock.__ Go to "Dock".  Drag the "Size" slider
  to make it big as possible.  Uncheck "Automatically hide and show the Dock".

* __Turn off Hot Corners, Exposé, and all the other shit that unexpectedly
  changes screen layout.__  This is a big one, and can be extremely hard to
  explain over the phone when something goes wrong.  Go to "Mission Control",
  and set all the "Keyboard and Mouse Shortcuts" to "-".  Then click "Hot
  Corners..." and set all of them to "-", too.

* __Remove unnecessary crap from the Dock.__  The only app my grandma uses is
  Safari, really.  Sometimes on the phone it's helpful to have her go to System
  Preferences.  I removed everything from the dock excepting those two things,
  which also made the Dock bigger, and easier for to click on Safari.

* __Remove unnecessary crap from the menu bar.__  By default, Bluetooth and
  Time Machine are in the menu bar, and are useless and possibly confusing.
  Since she doesn't store any files on the computer, Time Machine is entirely
  unnecessary.  Go to their respective preference panes and remove them.

* __Always show scroll bars.__  Personally, I hate Apple's move towards hiding
  scrollbars unless you maneuver the mouse to that tiny space on the edge of
  a window you need to scroll.  And it sucks really, really hard for someone
  has trouble with slight trackpad movements.  Go to "General" in "System
  Preferences", and select "Always" under "Show scroll bars".  While you're
  there, you may as well change sidebar icon size to "Large".

* __Make fonts bigger in Safari.__  I set her up with Safari just because it's
  bundled with the OS and is the most straightforward, although surely Firefox
  and Chrome have similar options.  Go to "Preferences", then "Advanced", then
  check off "Never use font sizes smaller than".  I set hers to 16, although
  this would be a little risky for someone who browses more random sites (her
  repertoire is pretty set.) Some sites are nigh-on unusable when you futz with
  their formatting that much.  Probably 12 is safe.

* __Make the Safari homepage something useful.__  Go to "Preferences" in
  Safari, then set both "New windows open with" and "New tabs open with" to
  "Homepage".  Then set the homepage to Google, or something else that's not
  apple.com.

* __Log into all the services.  Make sure they stay logged in.__  I logged her
  into Gmail, and checked off the option to keep her logged in.

* __Remove stupid bookmarks.__  By default, Safari is loaded with a bunch of
  bookmarks she didn't need.  She doesn't use Facebook or Twitter.  She doesn't
  use iCloud.  I have no idea who uses the "News" or "Popular" folders.  I got
  rid of them all.

### Some stuff just sucks and you can't fix it

The Adobe Flash updater is really confusing, requires multiple clicks just to
upgrade, it doesn't explain what it does or why it needs to run.  It's
extremely difficult to explain to someone without a pretty solid comfort with
computers what the hell is going on when it keeps popping dialog boxes in front
of them.  But keeping Flash up to date is important, and necessary for yotube
Hopefully Flash will die soon and this can finally be done away with.

The Notification Center menu item, and App Store stuff in general, is new
and unnecessary for her in 10.8.  Apple's doesn't let you remove it.  That
sucks, but it's something that hopefully won't cause any problems.

iCloud is a pain in the ass in a similar way.  I wasn't sure exactly how it was
happening, but my Grandma kept asking me questions about iCloud that make me
think it randomly pops up stuff asking her to set it up.  Since it didn't
happen when I was there though, I couldn't be sure how to make it shut up.

### In conclusion

It's nuts that to make a new laptop relatively unthreatening and accessible for
an enthusiastic 90-something requires going across a dozen System Preferences
panes and sub-panes, and simply having to accept certain things as inevitably
confusing.  I don't know what the solution is, and it may not be possible to
make the set up something that my grandma itself could do, but the steps above
took nearly an hour to figure out (and a good 20 minutes to reproduce.)

Furthermore, most of the internet is a usability nightmare for the elderly.
Tasks like clicking on a form field to fill it out, seeing that a white menu
drop down on a white menu is, in fact, a drop-down, or navigating to a "Log in"
button can become idiotically arduous tasks.  The fad for hiding controls when
you're not using them (looking at you, scroll bars) is particularly
frustrating.  Controls themselves are often tiny, with no clear way to make
them bigger -- YouTube is particularly bad with this.

Setting up this laptop several times, and seeing her struggle through the
usability nightmare that is most of the internet, made me think about how
little account I take of usability in my own designs.  It's hard -- without
seeing someone actually work through these problems, the choke points aren't
obvious.  In all honesty, I don't think it's practical for web designers to do
so: the expense is too great and the impact is small.  The makers of OSs and
browsers are in a far better position to make using the internet more
manageable for the elderly.
