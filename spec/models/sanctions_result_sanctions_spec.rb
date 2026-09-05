require "spec_helper"
require "json"
require "date"

describe Checkify::SanctionsResultSanctions do
  let(:attributes) do
    {
      targeted_financial_sanction: true,
      travel_ban: false,
      arms_embargo: true,
      maritime_restriction: false
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has targeted_financial_sanction" do
      expect(instance.targeted_financial_sanction).to eq(true)
    end

    it "has travel_ban" do
      expect(instance.travel_ban).to eq(false)
    end

    it "has arms_embargo" do
      expect(instance.arms_embargo).to eq(true)
    end

    it "has maritime_restriction" do
      expect(instance.maritime_restriction).to eq(false)
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "targeted_financial_sanction" => false,
        "travel_ban" => true,
        "arms_embargo" => false,
        "maritime_restriction" => true
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.targeted_financial_sanction).to eq(false)
      expect(obj.travel_ban).to eq(true)
      expect(obj.arms_embargo).to eq(false)
      expect(obj.maritime_restriction).to eq(true)
    end

    it "round-trips through to_hash and build_from_hash" do
      obj = described_class.build_from_hash(
        "targeted_financial_sanction" => true,
        "travel_ban" => true,
        "arms_embargo" => false,
        "maritime_restriction" => false
      )
      again = described_class.build_from_hash(obj.to_hash)
      expect(again).to eq(obj)
    end
  end
end
