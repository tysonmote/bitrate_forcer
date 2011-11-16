#!/usr/bin/env ruby

require "fileutils"

class BitrateFixer
  class << self
    AAC_EXTENSION = /\.m4a$/i
    MP3_EXTENSION = /\.mp3$/i

    # MP3/AAC files below this bitrate will be upconverted to `BITRATE`.
    THRESHOLD = 100 # kb/s
    BITRATE = 112

    def convert( path )
      return if path =~ /^\./
      if File.file?( path )
        filename = File.basename( path )
        unless filename =~ /^\./
          if filename =~ AAC_EXTENSION
            convert_m4a( path )
          elsif filename =~ MP3_EXTENSION
            convert_mp3( path )
          end
        end
      elsif File.directory?( path )
        Dir.foreach( path ) do |subpath|
          next if subpath =~ /^\./
          convert( File.join( path, subpath ) )
        end
      end
    end 

    def bitrate( path )
      rate = THRESHOLD
      `ffmpeg -i "#{path}" -f crc 2>&1`.scan( /bitrate: (\d+)/ ) do |kbps, x|
        rate = kbps.to_i
      end
      rate
    end
    
    def convert_mp3( path )
      if bitrate( path ) >= THRESHOLD
        puts "Skipping: #{path}"
        return
      end
      tmp_path = temporary_path( path )
      `ffmpeg -i "#{path}" -acodec libmp3lame -ab #{BITRATE}k "#{tmp_path}"`
      finalize( path, tmp_path )
    end
    
    def convert_m4a( path )
      if bitrate( path ) >= THRESHOLD
        puts "Skipping: #{path}"
        return
      end
      tmp_path = temporary_path( path )
      `ffmpeg -i "#{path}" -strict experimental -acodec aac -ab #{BITRATE}k "#{tmp_path}"`
      finalize( path, tmp_path )
    end

    protected

    def temporary_path( path )
      path = File.join( File.dirname( path ), "TEMP_#{File.basename( path )}")
      FileUtils.rm( path ) rescue nil
      path
    end

    def finalize( path, tmp_path )
      if File.file?( tmp_path )
        FileUtils.mv( tmp_path, path )
        puts "SUCCESS: #{path}"
      else
        puts "ERROR: #{path}"
      end
    end
  end
end

ARGV.each do |path|
  BitrateFixer.convert( path )
end

