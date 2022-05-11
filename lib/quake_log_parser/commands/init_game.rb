module QuakeLogParser::Commands
  class InitGame
    def self.process(game, hostname)
      game.hostname = hostname
    end
  end
end
