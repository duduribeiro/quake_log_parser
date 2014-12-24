module QuakeLogParser
  module Parsers
    module Analyzers
      class CommandAnalyzer < RegexBaseAnalyzer
        def initialize()
          super(/^.*?:\d*\s*(.*?):/)
        end

        def process(line)
          if @regex.match(line)
            @regex.match(line).captures.first
          else
            ""
          end
        end
      end
    end
  end
end
