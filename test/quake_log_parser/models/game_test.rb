require "test_helper"

class QuakeLogParser::Models::GameTest < Minitest::Test
  def setup
    @game = QuakeLogParser::Models::Game.new
  end

  def test_add_player_adds_the_player_to_the_list
    @game.add_player(42)

    refute_nil @game.players[42]
  end

  def test_rename_player_renames_the_player
    @game.add_player(42)

    @game.rename_player(42, "batman")

    assert_equal "batman", @game.players[42].name
  end

  def test_kill_saves_the_total_count_of_kills_for_the_game
    @game.add_player(42)
    @game.add_player(10)
    @game.add_player(50)

    @game.kill(42, 10, 22)
    @game.kill(50, 42, 22)
    @game.kill(10, 50, 22)

    assert_equal 3, @game.total_kills
  end

  def test_players_without_world_returns_all_players_excluding_world_from_the_list
    @game.add_player(42)
    @game.add_player(10)
    @game.add_player(50)

    assert_equal [42, 10, 50], @game.players_without_world.keys
  end

  def test_kill_register_a_proper_kill_for_the_killer
    @game.add_player(42)
    @game.add_player(10)
    @game.kill(42, 10, 22)

    assert_equal 1, @game.kills_for(42)
  end

  def test_kill_decrease_ghost_kills_when_world_kills_it
    @game.add_player(42)
    @game.add_player(10)
    @game.kill(42, 10, 22)
    @game.kill(QuakeLogParser::Models::World.new.player_id, 42, 22)

    assert_equal 0, @game.kills_for(42)
  end

  def test_kill_counts_the_righ_mean_of_death
    @game.add_player(42)
    @game.add_player(10)
    @game.kill(42, 10, 22)
    @game.kill(42, 10, 22)
    @game.kill(42, 10, 6)

    assert_equal 2, @game.kills_by_mean[QuakeLogParser::Models::MeanOfDeath.get_by_value(22)]
    assert_equal 1, @game.kills_by_mean[QuakeLogParser::Models::MeanOfDeath.get_by_value(6)]
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
