module QuakeLogParser
  module Parsers
    module Analyzers
      class ClientChangeInfoAnalyzer < RegexBaseAnalyzer
        def initialize
          super(/ClientUserinfoChanged:\s*(\d*).*n\\(.*?)\\/)
        end

        def process(line, game)
          match       = @regex.match(line)
          player_id   = match.captures.first.to_i
          player_name = match.captures.last
          game.change_player_name(player_id, player_name)
        end
      end
    end
  end
end
