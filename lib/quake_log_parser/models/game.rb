require "quake_log_parser/models/player"
require "quake_log_parser/models/world"
require "quake_log_parser/models/mean_of_death"

module QuakeLogParser::Models
  class Game
    attr_accessor :hostname
    attr_reader :players, :kills_by_player, :round, :total_kills, :kills_by_mean

    def initialize(round = 0)
      @players = {}
      world = World.new
      @players[world.player_id] = world
      @total_kills = 0
      @kills_by_player = Hash.new(0)
      @kills_by_mean = Hash.new(0)
      @round = round
    end

    def add_player(player_id)
      id = player_id.to_i
      unless @players[id]
        player = Player.new(id)
        @players[id] = player
        @kills_by_player[player] = 0
      end
    end

    def rename_player(player_id, new_name)
      player = players[player_id.to_i]
      player&.name = new_name
    end

    def players_without_world
      @players.reject { |_, player| player.world? }
    end

    def kill(killer_id, ghost_id, mean_of_death_id)
      @total_kills += 1
      killer = @players[killer_id.to_i]
      ghost = @players[ghost_id.to_i]
      @kills_by_mean[MeanOfDeath.get_by_value(mean_of_death_id.to_i)] += 1

      if killer.world?
        @kills_by_player[ghost] -= 1
      else
        @kills_by_player[killer] += 1
      end
    end

    def kills_for(player_id)
      @kills_by_player[@players[player_id]]
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
