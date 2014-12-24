require 'spec_helper'

RSpec.describe QuakeLogParser::Parsers::Analyzers::CommandAnalyzer do
  let(:game) { double("game") }
  let(:command) { described_class.new }
  describe "#initialize" do
    it "set the regex of the base_analyzer" do 
      expect_any_instance_of(QuakeLogParser::Parsers::Analyzers::RegexBaseAnalyzer).to receive(:initialize).with(/^.*?:\d*\s*((.*):|-------)/).and_call_original
      command
    end
  end

  describe "#process" do
    context "with a line with command" do
      it "will returns the command" do
        line = '  0:00 InitGame: \sv_floodProtect\1\sv_maxPing\0\sv_minPing\0\sv_maxRate\10000\sv_minRate\0\sv_hostname\Code Miner Server\g_gametype\0\sv_privateClients\2\sv_maxclients\16\sv_allowDownload\0\dmflags\0\fraglimit\20\timelimit\15\g_maxGameClients\0\capturelimit\8\version\ioq3 1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\q3dm17\gamename\baseq3\g_needpass\0'
        expect(command.process(line)).to eq "InitGame"
      end
    end

    context "without a command in the line" do
      it "will returns a blank string" do
        line = '  0:00 xxxxxx'
        expect(command.process(line)).to eq ""
      end
    end
  end
end
