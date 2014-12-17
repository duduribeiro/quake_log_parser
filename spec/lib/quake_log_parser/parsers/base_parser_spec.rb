require 'spec_helper'

RSpec.describe QuakeLogParser::Parsers::BaseParser do
  let(:base_parser) { described_class.new }
  describe "#initialize" do
    it "will create the analyzers variable" do
      expect(base_parser.instance_variable_get(:@analyzers)).to eq([])
    end
  end

  describe "#register_analyzer" do
    context "with a single parameter" do
      it "will add one analyzer to the array" do
        base_parser.register_analyzer(double("analyzer"))
        expect(base_parser.instance_variable_get(:@analyzers).size).to eq(1)
      end
    end

    context "with multiple parameters" do
      it "will add all the analyzers to the array" do
        analyzers = [ double("analyzer1"), 
                      double("analyzer2"), double("analyzer3") ]
        base_parser.register_analyzer(analyzers)
        expect(base_parser.instance_variable_get(:@analyzers).size).to eq(3)
      end
    end
  end
end
