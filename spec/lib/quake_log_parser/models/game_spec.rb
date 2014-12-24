require 'spec_helper'

RSpec.describe QuakeLogParser::Models::Game do
  let(:game) { described_class.new }

  it { is_expected.to respond_to(:start_game, :hostname=, :round, :round=,
                                 :started?, :shutdown, :finalized?) }

  describe "#add_player" do
    it "add the player in the array" do
      game.add_player(2)
      expect(game.instance_variable_get(:@players)[2]).to be
    end
  end

  describe "#change_player_name" do
    context "with a valid player" do
      it "calls the change_player in the player model" do
        game.add_player(2)
        expect(game.instance_variable_get(:@players)[2])
          .to receive(:change_name).with("test")
        game.change_player_name(2, "test")
      end
    end

    context "with an invalid player" do
      it "raise an error" do
        expect{game.change_player_name(2, "test")}
          .to raise_error(QuakeLogParser::Models::PlayerNotFoundError)
      end
    end
  end

  describe "#finalized?" do
    context "with an unstarted game" do
      it "returns false" do
        expect(game).to_not be_finalized
      end
    end
    context "with a game until shutdown" do
      it "returns false" do
        game.start_game
        expect(game).to_not be_finalized
      end
    end
    context "with a shutdown game" do
      it "returns true" do
        game.start_game
        game.shutdown
        expect(game).to be_finalized
      end
    end
  end

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
      expect(game).to be_finalized
    end
  end

end
