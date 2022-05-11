require "test_helper"

class QuakeLogParser::Commands::ShutdownGameTest < Minitest::Test
  def test_shutdown_finalizes_a_started_game
    game = QuakeLogParser::Models::Game.new
    game.start

    QuakeLogParser::Commands::ShutdownGame.process(game)

    assert game.finalized?
  end
end
