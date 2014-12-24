module QuakeLogParser
  module Models
    module Reports
      class GameReport
        def self.generate(game)
          players = []
          kills_by_players = {} 
          game.players.each do |id, player|
            players << player.name
            kills_by_players[player.name] = player.kills_count
          end
          json = {
            "game_#{game.round}" => {
              total_kills: game.kills,
              players: game.players.map{|id, player| player.name},
              kills: kills_by_players
            }
          }
        end
      end
    end
  end
end
