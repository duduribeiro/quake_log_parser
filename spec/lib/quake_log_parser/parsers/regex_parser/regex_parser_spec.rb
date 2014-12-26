require 'spec_helper'

RSpec.describe QuakeLogParser::Parsers::RegexParser do
  let(:regex_parser) { described_class.new }

  describe "initialize" do
    it "will set the variables" do
      expect(regex_parser.instance_variable_get(:@analyzers_by_command)).to be
      expect(regex_parser.instance_variable_get(:@command_analyzer)).to be
    end
  end

  describe "#process_from_command" do
    let(:command_analyzer) { double("command") }
    let(:init_command)  { double("init") }
    let(:another_command) { double("another")  }
    before :each do
      regex_parser.instance_variable_set(:@command_analyzer, command_analyzer)
      regex_parser.instance_variable_set(:@analyzers_by_command, {
        "init"    => init_command,
        "another" => another_command
      })
      allow(command_analyzer).to receive(:process).with("init").and_return("init")
      allow(command_analyzer).to receive(:process).with("another").and_return("another")
    end
    it "call the process based on line" do
      expect(init_command).to receive(:process).with("init", anything).once
      expect(another_command).to receive(:process).with("another", anything).once
      regex_parser.process_from_command("init")
      regex_parser.process_from_command("another")
    end
    context "with a shutdown line" do
      it "will call save_game" do
        game = double("game", finalized?: true, players: [], round: 2, kills: 2, kills_by_means: {})
        allow(game).to receive(:round=)
        regex_parser.instance_variable_set(:@game, game)
        expect(regex_parser).to receive(:save_game).with(game).and_call_original
        allow(another_command).to receive(:process).with("another", anything).once
        regex_parser.process_from_command("another")
      end
    end
    context "without a shutdown line" do
      it "will not call save_game" do
        game = double("game", finalized?: false)
        allow(game).to receive(:round=)
        regex_parser.instance_variable_set(:@game, game)
        expect(regex_parser).to_not receive(:save_game).with(game).and_call_original
        allow(another_command).to receive(:process).with("another", anything).once
        regex_parser.process_from_command("another")
      end
    end
  end
  describe "#save_game" do
    let(:game) { double("game", "round=" => nil, players: [], round: 5, kills: 5, kills_by_means: {} ) }
    before :each do
      regex_parser.instance_variable_set(:@game, game)
      regex_parser.instance_variable_set(:@last_round, 2)
      regex_parser.send(:save_game, game)
    end
    it "will increment the last_round number" do
      expect(regex_parser.instance_variable_get(:@last_round)).to eq 3
    end
    it "will add the game in the games array" do
      expect(regex_parser.instance_variable_get(:@games).size).to eq 1
    end
  end
end
