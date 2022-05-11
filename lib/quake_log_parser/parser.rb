require "quake_log_parser/parser_strategies/regex"
module QuakeLogParser
  class Parser
    def initialize(filename)
      raise ArgumentError.new("Filename is required") unless filename

      @file = File.new(filename, "r")
      @parse_strategy = ParserStrategies::Regex.new # only implemented Regex Strategy but in future can have implementations with other parsers like Treetop, Citrus or Parslet.
    end

    def parse
      while (line = @file.gets)
        cmd, args = @parse_strategy.get_command_and_args(line)
        next unless cmd

        p cmd
      end
    end
  end
end
