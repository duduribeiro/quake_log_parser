require "test_helper"

class QuakeLogParser::Commands::ShutdownGameTest < Minitest::Test
  def test_shutdown_finalizes_the_game
    game = QuakeLogParser::Models::Game.new

    QuakeLogParser::Commands::ShutdownGame.process(game)

    assert game.finalized?
  end
end
