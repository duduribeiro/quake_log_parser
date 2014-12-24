module QuakeLogParser
  module Parsers
    module Analyzers
      class ClientConnectAnalyzer < RegexBaseAnalyzer
        def initialize
          super(/ClientConnect:\s*(\d*)/)
        end

        def process(line, game)
          player_id = @regex.match(line).captures.first.to_i
          game.add_player(player_id)
        end
      end
    end
  end
end
