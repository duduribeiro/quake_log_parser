require 'spec_helper'

RSpec.describe QuakeLogParser::Parser do
  let(:mocked_parser) { double("parser") }
  let(:parser) { described_class.new(mocked_parser)  }
  describe ".parse_from_file" do
    it "reads the file" do
      file = double(File)
      expect(file).to receive(:gets)
      parser.parse_from_file file
    end

    it "prints in console" do
      file = StringIO.new("parsing")
      expect($stdout).to receive(:puts).with("parsing")
      parser.parse_from_file file
    end
  end
end
