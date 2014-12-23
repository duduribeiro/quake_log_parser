module QuakeLogParser
  module Models
    class Game
      attr_accessor :hostname
      def initialize
        @started = false
      end

      def start_game
        @started = true
      end
    end
  end
end
