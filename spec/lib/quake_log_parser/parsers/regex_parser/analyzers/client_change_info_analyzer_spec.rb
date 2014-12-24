require 'spec_helper'

RSpec.describe QuakeLogParser::Parsers::Analyzers::ClientChangeInfoAnalyzer do
  let(:game) { double("game") }
  let(:analyzer) { described_class.new }
  describe "#process" do
    it "will change the player name" do
      line = '20:38 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\uriel/zael\hmodel\uriel/zael\g_redteam\\g_blueteam\\c1\5\c2\5\hc\100\w\0\l\0\tt\0\tl\0'
      expect(game).to receive(:change_player_name).with(2, "Isgalamido")
      analyzer.process(line, game)
    end
  end
end
