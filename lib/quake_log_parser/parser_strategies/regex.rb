require "quake_log_parser/commands/init_game"
require "quake_log_parser/commands/client_connect"
require "quake_log_parser/commands/client_user_info_changed"
require "quake_log_parser/commands/kill"
require "quake_log_parser/commands/shutdown_game"

module QuakeLogParser::ParserStrategies
  # This class is responsible to return the command and args as analyzed by the line processed via Regex.
  class Regex
    COMMANDS = {
      InitGame: {command: QuakeLogParser::Commands::InitGame, args_regex: /sv_hostname\\(.+?)\\/},
      ClientConnect: {command: QuakeLogParser::Commands::ClientConnect, args_regex: /ClientConnect:\s*(\d+)/},
      ClientUserinfoChanged: {command: QuakeLogParser::Commands::ClientUserInfoChanged, args_regex: /ClientUserinfoChanged:\s*(\d*).*n\\(.*?)\\/},
      Kill: {command: QuakeLogParser::Commands::Kill, args_regex: /Kill:\s+(\d*)\s*(\d*)\s*(\d*)/},
      ShutdownGame: {command: QuakeLogParser::Commands::ShutdownGame, args_regex: //}
    }

    COMMAND_REGEX = %r{
      \d?\d:\d\d                        # The start of the content that contains the time. eg: 20:37
      \s                                # A whitespace char
      (#{COMMANDS.keys.join('|')}):     # Captures all implemented commands until the colon. eg: `Kill:` will capture `Kill`. This is the same as (InitGame|Kill|..) but reusing the COMMANDS keys for it.
    }x

    # Process the log line and return the proper command with the extra arguments found on the line.
    #
    # @param [String] line - The line of the log that will be parsed via regex
    # @return [Array<String, Array>] result_array - Returns an array containing a Command as the first arg and the extra arguments found
    #                           on the line as an array on the second position.
    #
    # @example Process the Kill line from the log
    #   cmd, args = QuakeLogParser::ParserStrategies::Regex.new.get_command_and_args("20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT")
    #   cmd => an instance of QuakeLogParser::Commands::Kill
    #   args => ["1022", "2", "22"]
    #
    def get_command_and_args(line)
      match = COMMAND_REGEX.match(line)
      return unless match

      result = COMMANDS[match.captures.first.to_sym]
      [result[:command], result[:args_regex].match(line).captures]
    end
  end
end
