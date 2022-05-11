require "test_helper"

class QuakeLogParser::Commands::ClientUserInfoChangedTest < Minitest::Test
  def test_sets_the_proper_name_for_the_player
    game = QuakeLogParser::Models::Game.new
    game.add_player(42)

    QuakeLogParser::Commands::ClientUserInfoChanged.process(game, 42, "batman")

    assert_equal "batman", game.players[42].name
  end
end
