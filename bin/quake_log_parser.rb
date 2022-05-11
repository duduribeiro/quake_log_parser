#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require "quake_log_parser"
require "json"

puts "-- Quake Log Parser"

filename = ARGV.first
reports = QuakeLogParser::Parser.new(filename).parse_reports

reports.each do |report|
  puts JSON.pretty_generate(report.as_json)
end
