module QuakeLogParser
  module Parsers
    module Analyzers
      class RegexBaseAnalyzer
        def initialize(regex, game)
          @regex = regex
          @game  = game
        end

        def process(line)
          raise NotImplementedError
        end
      end
    end
  end
end
