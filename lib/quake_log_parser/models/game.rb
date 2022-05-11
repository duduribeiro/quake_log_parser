require "quake_log_parser/models/player"
require "quake_log_parser/models/world"

module QuakeLogParser::Models
  class Game
    attr_accessor :hostname
    attr_reader :players, :kills_by_player

    def initialize
      @players = {}
      world = World.new
      @players[world.player_id] = world
      @kills_by_player = Hash.new(0)
    end

    def add_player(player_id)
      @players[player_id] = Player.new(player_id) unless @players[player_id]
    end

    def kill(killer_id, ghost_id, _mean_of_death_id)
      player = @players[killer_id]
      if player.world?
        @kills_by_player[ghost_id] -= 1
      else
        @kills_by_player[killer_id] += 1
      end
    end
  end
end
