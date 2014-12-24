require 'spec_helper'

RSpec.describe QuakeLogParser::Models::Player do
  let(:player) { described_class.new }

  it { is_expected.to respond_to(:name, :kills_count) }

  describe "#change_name" do
    it "changes the player name" do
      player.change_name("test")
      expect(player.name).to eq("test")
    end
  end

  describe "#decrease_kills" do
    it "decrease the player kills count" do
      player.instance_variable_set(:@kills_count, 10)
      player.decrease_kills
      expect(player.kills_count).to eq(9)
    end
  end

  describe "#increase_kills" do
    it "increase the player kills count" do
      player.instance_variable_set(:@kills_count, 10)
      player.increase_kills
      expect(player.kills_count).to eq(11)
    end
  end

  describe ".is_world?" do
    context "with a player that is not a world" do
      it "returns false" do
        expect(described_class.is_world?(2)).to be_falsey
      end
    end

    context "with a player that is a world" do
      it "returns true" do
        expect(described_class.is_world?(described_class::WORLD_ID))
          .to be_truthy
      end
    end
  end

end
