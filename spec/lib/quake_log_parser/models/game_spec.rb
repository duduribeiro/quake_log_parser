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

  describe "#kill" do
    context "when world kills a player" do
      before :each do
        game.add_player(2)
      end
      it "decrease the player kills" do
        player = game.instance_variable_get(:@players)[2]
        player.instance_variable_set(:@kills_count, 10)
        game.kill(QuakeLogParser::Models::Player::WORLD_ID, 2, 1)
        expect(player.kills_count).to eq 9
      end
      it "will increase the game kills count" do
        expect{
          game.kill(QuakeLogParser::Models::Player::WORLD_ID, 2, 1)
        }.to change(game, :kills).by(1)
      end
    end

    context "when a player kills another player" do
      before :each do
        game.add_player(2)
        game.add_player(3)
      end
      it "increase the killer kills count" do
        player_killer = game.instance_variable_get(:@players)[2]
        player_dead   = game.instance_variable_get(:@players)[3]
        expect{game.kill(2,3,1)}.to change(player_killer, :kills_count)
          .by(1)
      end

      it "increase the game kills count" do
        expect{game.kill(2,3,1)}.to change(game, :kills).by(1)
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
