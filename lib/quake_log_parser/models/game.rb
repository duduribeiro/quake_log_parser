require "quake_log_parser/models/player"

module QuakeLogParser::Models
  class Game
    attr_accessor :hostname
    attr_reader :players

    def initialize
      @players = {}
    end

    def add_player(player_id)
      @players[player_id] = Player.new(player_id) unless @players[player_id]
    end
  end
end
