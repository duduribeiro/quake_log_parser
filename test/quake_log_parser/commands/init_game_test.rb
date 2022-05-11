require "test_helper"

class QuakeLogParser::Commands::InitGameTest < Minitest::Test
  def setup
    @game = QuakeLogParser::Models::Game.new
  end

  def test_sets_the_proper_hostname_for_game
    QuakeLogParser::Commands::InitGame.process(@game, "myserver")

    assert_equal "myserver", @game.hostname
  end

  def test_it_starts_the_game
    refute @game.started?

    QuakeLogParser::Commands::InitGame.process(@game, "myserver")

    assert @game.started?
  end
end
