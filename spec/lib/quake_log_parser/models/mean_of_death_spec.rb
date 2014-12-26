require 'spec_helper'

RSpec.describe QuakeLogParser::Models::MeanOfDeath do

  describe ".get_by_value" do
    context "with an existent mod value" do
      it "returns the correct mod" do
        expect(described_class.get_by_value(19))
          .to eq "MOD_FALLING"
      end
    end
    context "with an inexistent mod value" do
      it "returns nil" do
        expect(described_class.get_by_value(100))
          .to_not be
      end
    end
  end

end
