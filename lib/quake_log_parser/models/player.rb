module QuakeLogParser::Models
  class Player
    attr_reader :player_id
    attr_accessor :name

    def initialize(player_id)
      @player_id = player_id
      @name = ""
    end
  end
end
