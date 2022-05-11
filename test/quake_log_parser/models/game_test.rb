require "test_helper"

class QuakeLogParser::Models::GameTest < Minitest::Test
  def test_add_player_adds_the_player_to_the_list
    game = QuakeLogParser::Models::Game.new

    game.add_player(42)

    refute_nil game.players[42]
  end
end
