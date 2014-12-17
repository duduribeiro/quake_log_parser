module QuakeLogParser
  module Parsers
    module Analyzers
      class CommandAnalyzer < RegexBaseAnalyzer
        def initialize(game)
          super(/^\s*\d*.\d*\s*(.*)?:/)
        end

        def process(line)
          @regex.match(line).captures.first
        end
      end
    end
  end
end
