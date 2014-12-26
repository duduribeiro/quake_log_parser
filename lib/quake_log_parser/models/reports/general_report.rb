module QuakeLogParser
  module Models
    module Reports
      class GeneralReport
        def self.generate(games)
          general_ranking = Hash.new(0)
          games.each{|game| game.players.each{|id, player| general_ranking[player.name]+= player.kills_count   } }
          json = {
            "general_ranking" => general_ranking
          }
        end
      end
    end
  end
end
