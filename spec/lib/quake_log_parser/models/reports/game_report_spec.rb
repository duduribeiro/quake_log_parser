require 'spec_helper'

RSpec.describe QuakeLogParser::Models::Reports::GameReport do

  describe ".generate" do
    let(:game) { QuakeLogParser::Models::Game.new }
    before :each do
      game.add_player(2)
      game.change_player_name(2, "Carlos")
      game.add_player(3)
      game.change_player_name(3, "Test")
      game.round = 1
      game.kill(2,3,1)
      game.kill(2,3,2)
      game.kill(3,2,1)
      game.kill(QuakeLogParser::Models::Player::WORLD_ID, 3, 1)
    end
    it "register the players name" do
      json = described_class.generate(game)
      expect(json["game_1"][:players]).to include("Carlos")
      expect(json["game_1"][:players]).to include("Test")
    end
    it "register the total kills in the game (including world kills)" do
      json = described_class.generate(game)
      expect(json["game_1"][:total_kills]).to eq 4
    end
    it "register the player score" do
      json = described_class.generate(game)
      expect(json["game_1"][:kills]["Carlos"]).to eq 2
    end
    it "decrease the score if world kills a player" do
      game.kill(QuakeLogParser::Models::Player::WORLD_ID, 2,1)
      json = described_class.generate(game)
      expect(json["game_1"][:kills]["Carlos"]).to eq 1
    end
  end

end
