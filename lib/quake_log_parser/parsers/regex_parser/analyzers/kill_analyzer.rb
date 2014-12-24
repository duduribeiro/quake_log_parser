module QuakeLogParser
  module Parsers
    module Analyzers
      class KillAnalyzer < RegexBaseAnalyzer
        def initialize
          super(/Kill:\s*(\d*)\s*(\d*)\s*(\d*)/)
        end

        def process(line, game)
          capture       = @regex.match(line).captures
          player_killer = capture.first.to_i
          player_dead   = capture[1].to_i
          mod_killed    = capture.last.to_i
          game.kill player_killer, player_dead, mod_killed
        end
      end
    end
  end
end
