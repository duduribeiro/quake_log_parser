require 'spec_helper'

RSpec.describe QuakeLogParser::Parser do
  describe ".parse_from_file" do
    it "reads the file" do
      file = double(File)
      expect(file).to receive(:gets)
      described_class.parse_from_file file
    end

    it "prints in console" do
      file = StringIO.new("parsing")
      expect($stdout).to receive(:puts).with("parsing")
      described_class.parse_from_file file
    end
  end
end
