module QuakeLogParser
  module Parsers
    class RegexParser
      def initialize
        @analyzers_by_command = {
          "InitGame" => QuakeLogParser::Parsers::Analyzers::InitGameAnalyzer.new(nil),
        }
        @command_analyzer = QuakeLogParser::Parsers::Analyzers::CommandAnalyzer.new
      end

      def process_from_command(line)
        command = @command_analyzer.process(line)
        @command = @analyzers_by_command[command]
        @command.process(line) if @command
      end
    end
  end
end
