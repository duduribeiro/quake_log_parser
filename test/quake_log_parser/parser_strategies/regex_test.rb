require "test_helper"

class QuakeLogParser::ParserStrategies::RegexTest < Minitest::Test
  def setup
    @regex_strategy = QuakeLogParser::ParserStrategies::Regex.new
  end

  def test_get_command_and_args_return_the_proper_result_for_init_game
    cmd, args = @regex_strategy.get_command_and_args('0:00 InitGame: \sv_floodProtect\1\sv_maxPing\0\sv_minPing\0\sv_maxRate\10000\sv_minRate\0\sv_hostname\Code Miner Server\g_gametype\0\sv_privateClients\2\sv_maxclients\16\sv_allowDownload\0\dmflags\0\fraglimit\20\timelimit\15\g_maxGameClients\0\capturelimit\8\version\ioq3 1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\q3dm17\gamename\baseq3\g_needpass\0')

    assert_equal QuakeLogParser::Commands::InitGame, cmd
    assert_equal ["Code Miner Server"], args
  end

  def test_get_command_and_args_return_the_proper_result_for_client_connect
    cmd, args = @regex_strategy.get_command_and_args("20:34 ClientConnect: 2")

    assert_equal QuakeLogParser::Commands::ClientConnect, cmd
    assert_equal ["2"], args
  end

  def test_get_command_and_args_return_the_proper_result_for_client_userinfo_changed
    cmd, args = @regex_strategy.get_command_and_args('20:37 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\uriel/zael\hmodel\uriel/zael\g_redteam\\g_blueteam\\c1\5\c2\5\hc\100\w\0\l\0\tt\0\tl\0')

    assert_equal QuakeLogParser::Commands::ClientUserInfoChanged, cmd
    assert_equal ["2", "Isgalamido"], args
  end

  def test_get_command_and_args_return_the_proper_result_for_kill
    cmd, args = @regex_strategy.get_command_and_args("20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT")

    assert_equal QuakeLogParser::Commands::Kill, cmd
    assert_equal ["1022", "2", "22"], args
  end

  def test_get_command_and_args_return_the_proper_result_for_shutdown
    cmd, args = @regex_strategy.get_command_and_args("1:47 ShutdownGame:")

    assert_equal QuakeLogParser::Commands::ShutdownGame, cmd
    assert_empty args
  end

  def test_get_command_and_args_return_empty_for_a_non_implemented_command
    cmd, args = @regex_strategy.get_command_and_args("15:00 Exit: Timelimit hit.")

    assert_nil cmd
    assert_nil args
  end
end
