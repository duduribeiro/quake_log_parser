require 'spec_helper'

RSpec.describe QuakeLogParser::Parsers::Analyzers::KillAnalyzer do
  let(:game) { double("game") }
  let(:analyzer) { described_class.new }
  describe "#process" do
    it "will register the kill" do
      line = '20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT'
      expect(game).to receive(:kill).with(1022, 2, 22)
      analyzer.process(line, game)
    end
  end
end
