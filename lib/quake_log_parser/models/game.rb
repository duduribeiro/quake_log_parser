module QuakeLogParser
  module Models
    class Game
      attr_reader   :kills, :players, :kills_by_means
      attr_accessor :hostname, :round

      def initialize
        @players        = { }
        @kills          = 0
        @kills_by_means = Hash.new(0)
      end

      def add_player(player_id)
        @players[player_id] = Player.new unless @players[player_id]
      end

      def change_player_name(player_id, player_name)
        player = @players[player_id]
        raise PlayerNotFoundError.new unless player
        player.change_name(player_name)
      end

      def finalized?
       !!@finalized
      end

      def kill(player_killer_id, player_dead_id, mod_kill)
        @kills += 1
        player_killer = @players[player_killer_id]
        player_dead   = @players[player_dead_id]
        if Player.is_world?(player_killer_id)
          player_dead.decrease_kills
        else
          @kills_by_means[MeanOfDeath.get_by_value(mod_kill)]+= 1
          player_killer.increase_kills
        end
      end

      def start_game
        @started = true
      end

      def started?
        !!@started
      end

      def shutdown
        @finalized = true
      end
    end
    class PlayerNotFoundError < StandardError; end
  end
end
