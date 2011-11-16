force_bitrate
=============

A quick-n-dirty utility to force higher bitrates on AAC and MP3 files. iTunes
Match refuses to "match" files encoded below 96kbps. Over half my library is
encoded at 64kbps mono, a remnant from my days of 32GB hard drives, so I'm
using this to "force" iTunes to match them. This is probably stupid.

This does the conversion in-place. After converting files, select them in iTunes
(they'll be the "not eligible" files), right-click, and select "Add to iCloud".

Usage
-----

    ./force_bitrate.rb /Users/tyson/Music/iTunes/iTunes\ Media/Music

