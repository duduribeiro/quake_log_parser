require 'spec_helper'

RSpec.describe QuakeLogParser::Models::Game do
  let(:game) { described_class.new }
  
  it { is_expected.to respond_to(:start_game, :hostname=) }
end
