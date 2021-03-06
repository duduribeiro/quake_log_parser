require 'pry'
module QuakeLogParser
  class Parser
    def initialize(parser)
      @parser = parser
    end
    def parse_from_file(file)
      while (line = file.gets)
        @parser.process_from_command(line)
      end
      @parser.generate_general_report
    end
  end
end
