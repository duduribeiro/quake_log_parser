require "test_helper"

class QuakeLogParser::ParserTest < Minitest::Test
  def test_fail_to_initialize_without_filename
    assert_raises ArgumentError do
      QuakeLogParser::Parser.new(nil)
    end
  end
end
