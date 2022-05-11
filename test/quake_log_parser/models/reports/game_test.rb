require "test_helper"
require "json"

class QuakeLogParser::Models::Reports::GameTest < Minitest::Test
  def test_it_generates_the_correct_report
    game = QuakeLogParser::Models::Game.new(1)
    game.add_player(10)
    game.add_player(20)
    game.add_player(30)

    QuakeLogParser::Commands::ClientUserInfoChanged.process(game, 10, "batman")
    QuakeLogParser::Commands::ClientUserInfoChanged.process(game, 20, "robin")
    QuakeLogParser::Commands::ClientUserInfoChanged.process(game, 30, "joker")

    game.kill(10, 20, 22)
    game.kill(10, 30, 19)
    game.kill(10, 30, 19)
    game.kill(20, 30, 22)
    game.kill(QuakeLogParser::Models::World.new.player_id, 30, 22)

    report_json = JSON.parse(QuakeLogParser::Models::Reports::Game.new(game).generate.as_json.to_json)

    assert_equal 5, report_json["game_1"]["total_kills"]

    assert_equal "batman", report_json["game_1"]["players"]["10"]
    assert_equal "robin", report_json["game_1"]["players"]["20"]
    assert_equal "joker", report_json["game_1"]["players"]["30"]

    assert_equal 3, report_json["game_1"]["kills"]["batman"]
    assert_equal 1, report_json["game_1"]["kills"]["robin"]
    assert_equal(-1, report_json["game_1"]["kills"]["joker"])

    assert_equal 3, report_json["game_1"]["kills_by_means"]["MOD_TRIGGER_HURT"]
    assert_equal 2, report_json["game_1"]["kills_by_means"]["MOD_FALLING"]
  end
end
