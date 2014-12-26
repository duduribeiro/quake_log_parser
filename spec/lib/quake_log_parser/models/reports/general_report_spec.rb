require 'spec_helper'

RSpec.describe QuakeLogParser::Models::Reports::GeneralReport do

  describe ".generate" do
    let(:game1) { QuakeLogParser::Models::Game.new }
    let(:game2) { QuakeLogParser::Models::Game.new }
    let(:games) { [game1, game2]  }
    before :each do
      game1.add_player(2)
      game1.change_player_name(2, "Carlos")
      game1.add_player(3)
      game1.change_player_name(3, "Test")
      game1.round = 1
      game1.kill(2,3,1)
      game1.kill(2,3,2)
      game1.kill(3,2,1)
      game1.kill(QuakeLogParser::Models::Player::WORLD_ID, 3, 1)

      game2.add_player(2)
      game2.change_player_name(2, "Carlos")
      game2.add_player(3)
      game2.change_player_name(3, "Test")
      game2.round = 2
      game2.kill(3,2,2)
      game2.kill(3,2,1)
      game2.kill(2,3,3)
      game2.kill(3,2,3)
    end
    it "generates the full ranking" do
      expect(described_class.generate(games)["general_ranking"]["Carlos"])
        .to eq 3
      expect(described_class.generate(games)["general_ranking"]["Test"])
        .to eq 3
    end
  end

end
