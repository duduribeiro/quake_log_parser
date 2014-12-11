#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'quake_log_parser'

QuakeLogParser::Executor.run(ARGV)
