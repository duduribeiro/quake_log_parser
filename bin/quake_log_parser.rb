#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'quake_log_parser'

if ARGV.empty?
  puts "You need to pass the log file as an argument"
  exit
end
QuakeLogParser::Parser.parse_from_file(File.new(ARGV.first, "r"))
