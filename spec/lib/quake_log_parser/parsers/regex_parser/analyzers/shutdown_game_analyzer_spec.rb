require 'spec_helper'

RSpec.describe QuakeLogParser::Parsers::Analyzers::ShutdownGameAnalyzer do
  let(:game) { double("game", shutdown:true) }
  let(:analyzer) { described_class.new(game) }
  describe "#process" do
    it "will finalize the game" do
      line = '20:37 ShutdownGame:'
      expect(game).to receive(:shutdown)
      analyzer.process(line)
    end
  end
end
