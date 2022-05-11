require "test_helper"
require "quake_log_parser/models/world"

class QuakeLogParser::Commands::InitGameTest < Minitest::Test
  def test_register_the_proper_kill
    game = QuakeLogParser::Models::Game.new
    game.add_player(42)
    game.add_player(10)

    QuakeLogParser::Commands::Kill.process(game, 42, 10, 22)

    assert_equal 1, game.kills_for(42)
  end

  def test_decrease_the_dead_player_total_of_kills_when_killer_is_world
    game = QuakeLogParser::Models::Game.new
    game.add_player(42)
    game.add_player(10)

    QuakeLogParser::Commands::Kill.process(game, 42, 10, 22)
    QuakeLogParser::Commands::Kill.process(game, 42, 10, 22)
    QuakeLogParser::Commands::Kill.process(game, QuakeLogParser::Models::World.new.player_id, 42, 22)

    assert_equal 1, game.kills_for(42)
  end
end
