module QuakeLogParser
  module Parsers
    module Analyzers
      class InitGameAnalyzer < RegexBaseAnalyzer
        def initialize(game)
          super(/.*sv_hostname\\(.*?)\\/, game)
        end

        def process(line)
          @game.start_game
          @game.hostname = @regex.match(line).captures.first
        end
      end
    end
  end
end
