require "quake_log_parser/models/player"

module QuakeLogParser::Models
  class World < Player
    WORLD_ID = 1022

    def initialize
      super(WORLD_ID)
      self.name = "<world>"
    end

    def world?
      true
    end
  end
end
