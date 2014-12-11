#!/usr/bin/env ruby
require_relative 'quake_log_parser'

if ARGV.empty?
  puts "You need to pass the log file as an argument"
  exit
end

