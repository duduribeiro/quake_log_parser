module QuakeLogParser
  module Parsers
    module Analyzers
      class RegexBaseAnalyzer
        def initialize(regex)
          @regex = regex
        end

        def process(line, game)
          raise NotImplementedError
        end
      end
    end
  end
end
