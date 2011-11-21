force_bitrate
=============

A quick-n-dirty utility to force higher bitrates on AAC and MP3 files. iTunes
Match refuses to "match" files encoded below 96kbps. Over half my library is
encoded at 64kbps mono, a remnant from my days of 32GB hard drives, so I'm
using this to "force" iTunes to match them. This is probably stupid. But it works.

Dependencies
------------

You'll need ffmpeg. I recommend installing through homebrew. You have to use GCC to compile (as of November 2011) because LLVM explodes.

    brew install ffmpeg --use-gcc

Steps
-----

1. The first step is to convert all your low bitrate AAC and MP3 files in-place to higher bitrates. Yes, this is dumb, but because iTunes Match refuses to even look at low-bitrate files, this is our only option. The upside is that files that are successfully matched (rather than just uploaded) will be available for 256kbps re-download.

        ./force_bitrate.rb /Users/tyson/Music/iTunes/iTunes\ Media/Music

2. Create a smart playlist in iTunes that contains all of these new files:

    ![Ineligible iTunes Tracks Playlist](http://github.com/tysontate/bitrate_forcer/raw/master/readme_images/ineligible_playlist.png)

3. iTunes will still think these files are low-bitrate until you refresh its cache of file information. The only way I know of doing this is to "Get Info" on the first song in the new "iCloud Ineligible" playlist and hold Command + Right Arrow to go through every song in the playlist.

4. Select all files in the "iCloud Ineligible" playlist, right click on them, and select "Add to iCloud". Let iCloud work its magic, matching and uploading as necessary.

5. Once all files have been matched / uploaded, create another new Smart Playlist:

    ![Downloadable iTunes Tracks Playlist](http://github.com/tysontate/bitrate_forcer/raw/master/readme_images/downloadable_playlist.png)

6. Select all songs in the playlist, option-delete, and delete the files locally (don't delete them from iCloud!)

7. Select all songs in the playlist again, right click, and choose "Download".

8. Enjoy.
