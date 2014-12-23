module QuakeLogParser
  module Parsers
    class RegexParser
      def initialize
        @games = []
        @game = new_game
        @last_round = 0
        @analyzers_by_command = {
          "InitGame" => QuakeLogParser::Parsers::Analyzers::InitGameAnalyzer.new,
          "ShutdownGame" => QuakeLogParser::Parsers::Analyzers::ShutdownGameAnalyzer.new
        }
        @command_analyzer = QuakeLogParser::Parsers::Analyzers::CommandAnalyzer.new
      end

      def process_from_command(line)
        command = @command_analyzer.process(line)
        @command = @analyzers_by_command[command]
        @command.process(line, @game) if @command
        save_game(@game) if @game.finalized?
      end

      private
      def save_game(game)
        game.round = @last_round+=1
        @games << game
        new_game
      end

      def new_game
        @game = QuakeLogParser::Models::Game.new
      end
    end
  end
end
