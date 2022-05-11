module QuakeLogParser::Commands
  class ClientUserInfoChanged
    def self.process(game, player_id, new_name)
      player = game.players[player_id]
      player&.name = new_name
    end
  end
end
