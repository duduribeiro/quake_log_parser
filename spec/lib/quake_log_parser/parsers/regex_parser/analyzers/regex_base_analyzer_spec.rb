require 'spec_helper'

RSpec.describe QuakeLogParser::Parsers::Analyzers::RegexBaseAnalyzer do
  let(:regex) { double("regex") } 
  let(:analyzer) { described_class.new(regex) }
  describe "#initialize" do
    it "will set the regex variable" do
      expect(analyzer.instance_variable_get(:@regex)).to eq(regex)
    end
  end

  describe "#process" do
    it "will raise an NotImplementedError when process is direct called" do
      expect{analyzer.process(nil)}.to raise_error(NotImplementedError)
    end
  end
end
