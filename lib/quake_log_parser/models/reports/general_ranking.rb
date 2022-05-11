module QuakeLogParser::Models::Reports
  class GeneralRanking
    def initialize(games)
      @games = games
      @general_ranking = Hash.new(0)
    end

    def generate
      @games.each do |game|
        game.kills_by_player.each do |player, kills_on_the_game|
          @general_ranking[player.name] += kills_on_the_game unless player.world?
        end
      end

      self
    end

    def as_json
      {
        "general_ranking" => @general_ranking
      }
    end
  end
end
