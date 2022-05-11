require "test_helper"

class QuakeLogParser::Commands::InitGameTest < Minitest::Test
  def test_sets_the_proper_hostname_for_game
    game = QuakeLogParser::Models::Game.new

    QuakeLogParser::Commands::InitGame.process(game, "myserver")

    assert_equal "myserver", game.hostname
  end
end
