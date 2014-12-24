require 'spec_helper'

RSpec.describe QuakeLogParser::Models::Player do
  let(:player) { described_class.new }

  it { is_expected.to respond_to(:name) }

  describe "#change_name" do
    it "changes the player name" do
      player.change_name("test")
      expect(player.name).to eq("test")
    end
  end

end
