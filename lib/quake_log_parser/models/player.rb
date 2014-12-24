module QuakeLogParser
  module Models
    class Player
      WORLD_ID = 1022
      attr_reader :name, :kills_count

      def initialize
        @kills_count = 0
      end

      def change_name(name)
        @name = name
      end

      def decrease_kills
        @kills_count -= 1
      end

      def increase_kills
        @kills_count += 1
      end
      def self.is_world?(player_id)
        player_id == WORLD_ID
      end
    end
  end
end
