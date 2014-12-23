require 'spec_helper'

RSpec.describe QuakeLogParser::Models::Game do
  let(:game) { described_class.new }

  it { is_expected.to respond_to(:start_game, :hostname=) }

  describe "#start_game" do
    it "will change change the variable @started to true" do
      game.start_game
      expect(game.started?).to be_truthy
    end
  end

  describe "#started?" do
    context "with an unstarted game" do
      it "returns false" do
        expect(game.started?).to be_falsey
      end
    end
    context "with a started game" do
      it "returns true" do
        game.start_game
        expect(game.started?).to be_truthy
      end
    end
  end

  describe "#shutdown" do
    it "finalizes the game" do
      game.start_game
      game.shutdown
      expect(game.started?).to be_falsey
    end
  end
end
