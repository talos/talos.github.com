---
layout: post
title: A YouTube CLI for Mac
date: 2013-07-29
thumbnail: /images/youtube-viewer.png
---

Out of laziness, I mostly listen to music off [YouTube][] these days.  As a
library it's pretty unbeatable, and I don't have to worry about plugging in an
external HDD with a big library.

  [YouTube]: http://youtube.com

Using the browser for selecting songs is a drag, but I've always used
visual interfaces (originally iTunes, then a combination of [VLC][] and
[Vox][]).  Also, Flash player munches on your battery pretty bad.  And
I generally try to avoid executing anything with Flash.

  [VLC]: https://videolan.org/vlc/
  [Vox]: http://download.cnet.com/Vox/3000-2139_4-145817.html#rateit

Turns out there's a CLI for YouTube, [youtube-viewer][] with vim-like
keybindings no less!  Since it requires a newer version of Perl than what's
bundled with OSX, you need to do a little work to get it running.

  [youtube-viewer]: https://github.com/trizen/youtube-viewer

### Perl 5.16.0

The Perl version bundled with OSX in `/usr/bin/perl` with Mac OSX 10.7.5, is
5.12.3.  Considering Apple's tendency to let the CLI tools bundled with OSX
rot, I doubt newer versions have a more up-to-date version.  It's entirely
possible that some system-level functionality depends on an old version of
Perl, so updating at the root level would be a Very Bad Idea.

Fortunately, there's a [good setup tool][] available on [learn.perl.org][]:

  [good setup tool]: http://learn.perl.org/installing/osx.html
  [learn.perl.org]: http://learn.perl.org

{% highlight bash %}
    $ curl -L http://xrl.us/installperlosx | bash
{% endhighlight %}

This will install 5.16.0 in `~/perl5/perlbrew` and add a line to your
`.bashrc`, updating your env Perl version.

### Mplayer

This one's easy.

{% highlight bash %}
    $ brew install mplayer
{% endhighlight %}

<br>

### youtube-viewer

Snag the source:

{% highlight bash %}
    $ git clone git@github.com:trizen/youtube-viewer.git
{% endhighlight %}

Follow the instructions, but drop the last `sudo` &mdash; provided you make
sure to execute `Build.PL` with your perlbrew (rather than system) Perl, then
it will be installed in a user-specific directory.

{% highlight bash %}
    $ perl Build.PL
    $ ./Build
    $ ./Build test
    $ ./Build install
{% endhighlight %}

<br>

# Usage

{% highlight bash %}
    $ youtube-viewer
    =>> Search for YouTube videos (:h for help)
{% endhighlight %}

Or, if you don't want an MPlayer window popping up outside your Terminal while
a video is playing:

{% highlight bash %}
    $ youtube-viewer -n
    =>> Search for YouTube videos (:h for help)
{% endhighlight %}

Enjoy!
