module QuakeLogParser
  module Parsers
    module Analyzers
      class InitGameAnalyzer < RegexBaseAnalyzer
        def initialize
          super(/.*sv_hostname\\(.*?)\\/)
        end

        def process(line, game)
          game.start_game
          game.hostname = @regex.match(line).captures.first
        end
      end
    end
  end
end
