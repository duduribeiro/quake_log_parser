require "test_helper"
require "quake_log_parser/models/mean_of_death"

class QuakeLogParser::Models::MeanOfDeathTest < Minitest::Test
  def test_get_by_value_returns_the_correct_mod
    assert_equal "MOD_FALLING", QuakeLogParser::Models::MeanOfDeath.get_by_value(19)
  end

  def test_get_by_value_returns_nil_if_mod_does_not_exist
    assert_nil QuakeLogParser::Models::MeanOfDeath.get_by_value(999)
  end
end
