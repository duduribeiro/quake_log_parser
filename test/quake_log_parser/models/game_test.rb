require "test_helper"

class QuakeLogParser::Models::GameTest < Minitest::Test
  def setup
    @game = QuakeLogParser::Models::Game.new
  end

  def test_add_player_adds_the_player_to_the_list
    @game.add_player(42)

    refute_nil @game.players[42]
  end

  def test_kill_register_a_proper_kill_for_the_killer
    @game.add_player(42)
    @game.add_player(10)
    @game.kill(42, 10, 22)

    assert_equal 1, @game.kills_by_player[42]
  end

  def test_kill_decrease_ghost_kills_when_world_kills_it
    @game.add_player(42)
    @game.add_player(10)
    @game.kill(42, 10, 22)
    @game.kill(QuakeLogParser::Models::World.new.player_id, 42, 22)

    assert_equal 0, @game.kills_by_player[42]
  end

  def test_shutdown_finalizes_a_started_game
    refute @game.finalized?

    @game.start
    @game.shutdown

    assert @game.finalized?
  end

  def test_shutdown_does_not_finalizes_a_not_started_game
    refute @game.finalized?
    refute @game.started?

    @game.shutdown

    refute @game.finalized?
  end
end
