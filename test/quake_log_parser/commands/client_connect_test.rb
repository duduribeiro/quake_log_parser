require "test_helper"

class QuakeLogParser::Commands::ClientConnectTest < Minitest::Test
  def test_adds_the_player_to_the_game
    game = QuakeLogParser::Models::Game.new

    QuakeLogParser::Commands::ClientConnect.process(game, 42)

    refute_nil game.players[42]
  end
end
