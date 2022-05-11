require "test_helper"

class QuakeLogParser::Models::PlayerTest < Minitest::Test
  def test_can_change_the_player_name
    player = QuakeLogParser::Models::Player.new(42)

    player.name = "Batman"

    assert_equal "Batman", player.name
  end
end
