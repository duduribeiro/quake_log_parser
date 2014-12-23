module QuakeLogParser
  module Parsers
    module Analyzers
      class CommandAnalyzer < RegexBaseAnalyzer
        def initialize()
          super(/^\s*\d*.\d*\s*(.*)?:/, nil)
        end

        def process(line)
          @regex.match(line).captures.first
        end
      end
    end
  end
end
