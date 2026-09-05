require "spec_helper"
require "json"
require "date"

describe Checkify::EmailResponseDns do
  let(:attributes) do
    {
      valid: true
    }
  end

  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has valid" do
      expect(instance.valid).to eq(true)
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "valid" => true
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.valid).to eq(true)
    end
  end
end
