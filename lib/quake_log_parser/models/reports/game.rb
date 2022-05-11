module QuakeLogParser::Models::Reports
  class Game
    def initialize(game)
      @game = game
      @players = []
    end

    def generate
      @players = @game.players_without_world

      self
    end

    def as_json
      {
        "game_#{@game.round}" => {
          total_kills: @game.total_kills,
          players: @players,
          kills: @game.kills_by_player
        }
      }
    end
  end
end
