module QuakeLogParser
  module Parsers
    module Analyzers
      class ShutdownGameAnalyzer < RegexBaseAnalyzer
        def initialize()
          super(//)
        end

        def process(line, game)
          game.shutdown if game.started?
        end
      end
    end
  end
end
