module QuakeLogParser::Commands
  class ClientConnect
    def self.process(game, player_id)
      game.add_player(player_id)
    end
  end
end
