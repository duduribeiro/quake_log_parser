module QuakeLogParser
  module Parsers
    class RegexParser
      def initialize
        @games = []
        @game = new_game
        @last_round = 0
        @analyzers_by_command = {
          "ClientConnect"         => QuakeLogParser::Parsers::Analyzers::ClientConnectAnalyzer.new,
          "ClientUserinfoChanged" => QuakeLogParser::Parsers::Analyzers::ClientChangeInfoAnalyzer.new,
          "InitGame"              => QuakeLogParser::Parsers::Analyzers::InitGameAnalyzer.new,
          "Kill"                  => QuakeLogParser::Parsers::Analyzers::KillAnalyzer.new,
          "ShutdownGame"          => QuakeLogParser::Parsers::Analyzers::ShutdownGameAnalyzer.new,
          "-------"               => QuakeLogParser::Parsers::Analyzers::ShutdownGameAnalyzer.new,
        }
        @command_analyzer = QuakeLogParser::Parsers::Analyzers::CommandAnalyzer.new
      end

      def process_from_command(line)
        command = @command_analyzer.process(line)
        @command = @analyzers_by_command[command]
        @command.process(line, @game) if @command
        save_game(@game) if @game.finalized?
      end

      def generate_general_report
        p "----------------------------------------"
        p QuakeLogParser::Models::Reports::GeneralReport.generate(@games)
      end

      private
      def save_game(game)
        game.round = @last_round+=1
        p QuakeLogParser::Models::Reports::GameReport.generate(game)
        @games << game
        new_game
      end

      def new_game
        @game = QuakeLogParser::Models::Game.new
      end
    end
  end
end
