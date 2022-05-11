require "quake_log_parser/parser_strategies/regex"
require "quake_log_parser/models/game"
require "quake_log_parser/models/reports/game"
require "quake_log_parser/models/reports/general_ranking"

module QuakeLogParser
  class Parser
    def initialize(filename)
      raise ArgumentError.new("Filename is required") unless filename

      @file = File.new(filename, "r")
      @parse_strategy = ParserStrategies::Regex.new # only implemented Regex Strategy but in future can have implementations with other parsers like Treetop, Citrus or Parslet.
      @games = []
    end

    def parse_and_generate_reports
      reports = []
      while (line = @file.gets)
        cmd, args = @parse_strategy.get_command_and_args(line)
        cmd&.process(current_game, *args)

        reports << save_and_generate_report_for_current_game if current_game.finalized?
      end
      reports << QuakeLogParser::Models::Reports::GeneralRanking.new(@games).generate
      reports
    end

    private

    def current_game
      @current_game || new_game
    end

    def new_game
      @current_game = QuakeLogParser::Models::Game.new(next_round)
    end

    def next_round
      @round = current_round + 1
    end

    def current_round
      @round ||= 0
    end

    def save_and_generate_report_for_current_game
      @games << current_game
      report = QuakeLogParser::Models::Reports::Game.new(current_game).generate
      new_game
      report
    end
  end
end
