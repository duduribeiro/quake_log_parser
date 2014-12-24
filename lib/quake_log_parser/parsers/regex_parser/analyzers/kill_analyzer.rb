module QuakeLogParser
  module Parsers
    module Analyzers
      class KillAnalyzer < RegexBaseAnalyzer
        def initialize
          super(/.*sv_hostname\\(.*?)\\/)
        end

        def process(line, game)
        end
      end
    end
  end
end
