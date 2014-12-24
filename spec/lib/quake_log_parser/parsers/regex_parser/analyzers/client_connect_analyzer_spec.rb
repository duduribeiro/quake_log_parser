require 'spec_helper'

RSpec.describe QuakeLogParser::Parsers::Analyzers::ClientConnectAnalyzer do
  let(:game) { double("game") }
  let(:analyzer) { described_class.new }
  describe "#process" do
    it "will add the player in the game" do
      line = '20:38 ClientConnect: 2'
      expect(game).to receive(:add_player).with(2)
      analyzer.process(line, game)
    end
  end
end
