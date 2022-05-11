module QuakeLogParser::Commands
  class ShutdownGame
    def self.process(game)
      game.shutdown
    end
  end
end
