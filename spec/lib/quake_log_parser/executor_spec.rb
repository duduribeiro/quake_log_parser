require 'spec_helper'

RSpec.describe QuakeLogParser::Executor do
  describe ".run" do
    context "without parameters" do
      it "will call puts because it hasn't arguments" do
        expect($stdout).to receive(:puts).with("You need to pass the log file as an argument")
        expect { described_class.run [] }.to raise_error SystemExit
      end
    end

    context "with parameters" do
      it "will call Parser.parse_from_file" do
        expect(QuakeLogParser::Parser).to receive(:parse_from_file)
        described_class.run ["games.log"]
      end
    end
  end
end
