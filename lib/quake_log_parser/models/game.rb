module QuakeLogParser
  module Models
    class Game
      attr_accessor :hostname

      def start_game
        @started = true
      end

      def started?
        !!@started
      end

      def shutdown
        @started = false
      end
    end
  end
end
