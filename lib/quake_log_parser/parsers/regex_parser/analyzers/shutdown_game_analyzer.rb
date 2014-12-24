module QuakeLogParser
  module Parsers
    module Analyzers
      class ShutdownGameAnalyzer < RegexBaseAnalyzer
        def initialize(game)
          super(//,game)
        end

        def process(line)
          @game.shutdown
        end
      end
    end
  end
end
