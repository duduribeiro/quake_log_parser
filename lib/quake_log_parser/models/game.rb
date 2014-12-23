module QuakeLogParser
  module Models
    class Game
      attr_accessor :hostname, :round

      def start_game
        @started = true
      end

      def started?
        !!@started
      end

      def shutdown
        @finalized = true
      end

      def finalized?
       !!@finalized
      end
    end
  end
end
