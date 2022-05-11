#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require "quake_log_parser"

puts "-- Quake Log Parser"

filename = ARGV.first
QuakeLogParser::Parser.new(filename).parse
