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
    let(:init_command) { double("init") }
    before :each do
      regex_parser.instance_variable_set(:@command_analyzer, command_analyzer)
      regex_parser.instance_variable_set(:@analyzers_by_command, {
        "init" => init_command
      })
      allow(command_analyzer).to receive(:process).with("init").and_return("init")
    end
    it "call the process based on line" do
      expect(init_command).to receive(:process).with("init")
      regex_parser.process_from_command("init")
    end
  end
end
