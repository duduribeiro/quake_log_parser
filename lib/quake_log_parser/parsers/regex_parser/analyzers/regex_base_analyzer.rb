module QuakeLogParser
  module Parsers
    module Analyzers
      class RegexBaseAnalyzer
        def initialize(regex)
          @regex = regex
        end

        def process(line)
          raise NotImplementedError
        end
      end
    end
  end
end
