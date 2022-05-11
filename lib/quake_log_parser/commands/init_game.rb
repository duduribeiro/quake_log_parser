module QuakeLogParser::Commands
  class InitGame
    def self.process(game, hostname)
      game.hostname = hostname
      game.start
    end
  end
end
