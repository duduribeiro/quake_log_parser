module QuakeLogParser
  module Models
    class Game
      attr_accessor :hostname, :round

      def initialize
        @players = { }
      end

      def add_player(player_id)
        @players[player_id] = Player.new
      end

      def change_player_name(player_id, player_name)
        player = @players[player_id]
        raise PlayerNotFoundError.new unless player
        player.change_name(player_name)
      end

      def finalized?
       !!@finalized
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
