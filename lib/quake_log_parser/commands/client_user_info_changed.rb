module QuakeLogParser::Commands
  class ClientUserInfoChanged
    def self.process(game, player_id, new_name)
      game.rename_player(player_id, new_name)
    end
  end
end
