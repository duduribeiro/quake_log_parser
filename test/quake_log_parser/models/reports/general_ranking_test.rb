require "test_helper"
require "json"

class QuakeLogParser::Models::Reports::GeneralRankingTest < Minitest::Test
  def test_it_generates_the_correct_report
    game = QuakeLogParser::Models::Game.new(1)
    game.add_player(10)
    game.add_player(20)
    game.add_player(30)

    QuakeLogParser::Commands::ClientUserInfoChanged.process(game, 10, "batman")
    QuakeLogParser::Commands::ClientUserInfoChanged.process(game, 20, "robin")
    QuakeLogParser::Commands::ClientUserInfoChanged.process(game, 30, "joker")

    game.kill(10, 20, 22)
    game.kill(10, 30, 22)
    game.kill(10, 30, 22)
    game.kill(20, 30, 22)
    game.kill(QuakeLogParser::Models::World.new.player_id, 30, 22)

    second_game = QuakeLogParser::Models::Game.new(2)
    second_game.add_player(10)
    second_game.add_player(20)
    QuakeLogParser::Commands::ClientUserInfoChanged.process(second_game, 10, "batman")
    QuakeLogParser::Commands::ClientUserInfoChanged.process(second_game, 20, "robin")
    second_game.kill(10, 20, 22)
    second_game.kill(10, 20, 22)

    report_json = JSON.parse(QuakeLogParser::Models::Reports::GeneralRanking.new([game, second_game]).generate.as_json.to_json)

    assert_equal 5, report_json["general_ranking"]["batman"]
    assert_equal 1, report_json["general_ranking"]["robin"]
    assert_equal(-1, report_json["general_ranking"]["joker"])
  end
end
