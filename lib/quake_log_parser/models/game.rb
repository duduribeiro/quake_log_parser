require "quake_log_parser/models/player"
require "quake_log_parser/models/world"

module QuakeLogParser::Models
  class Game
    attr_accessor :hostname
    attr_reader :players, :kills_by_player, :round

    def initialize(round = 0)
      @players = {}
      world = World.new
      @players[world.player_id] = world
      @kills_by_player = Hash.new(0)
      @round = round
    end

    def add_player(player_id)
      id = player_id.to_i
      @players[id] = Player.new(id) unless @players[id]
    end

    def kill(killer_id, ghost_id, _mean_of_death_id)
      player = @players[killer_id.to_i]
      if player.world?
        @kills_by_player[ghost_id.to_i] -= 1
      else
        @kills_by_player[killer_id.to_i] += 1
      end
    end

    def start
      @started = true
    end

    def started?
      !!@started
    end

    def finalized?
      !!@finalized
    end

    def shutdown
      @finalized = true if started?
    end
  end
end
