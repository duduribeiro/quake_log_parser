require 'spec_helper'

RSpec.describe QuakeLogParser::Parsers::Analyzers::ShutdownGameAnalyzer do
  let(:game) { double("game", shutdown:true) }
  let(:analyzer) { described_class.new }
  describe "#process" do
    context "with the shutdown command" do
      let(:line) { '20:37 ShutdownGame:' }
      context "with a started game" do
        it "will finalize the game" do
          allow(game).to receive(:started?).and_return(true)
          expect(game).to receive(:shutdown)
          analyzer.process(line, game)
        end
      end
      context "withe an unstarted game" do
        it "will not finalize the game" do
          allow(game).to receive(:started?).and_return(false)
          expect(game).to_not receive(:shutdown)
          analyzer.process(line, game)
        end
      end
    end
    context "with the dot line command" do
      let(:line) { '14:11 ------------------------------------------------------------' }
      context "with a started game" do
        it "will finalize the game" do
          allow(game).to receive(:started?).and_return(true)
          expect(game).to receive(:shutdown)
          analyzer.process(line, game)
        end
      end
      context "withe an unstarted game" do
        it "will not finalize the game" do
          allow(game).to receive(:started?).and_return(false)
          expect(game).to_not receive(:shutdown)
          analyzer.process(line, game)
        end
      end
    end
  end
end
