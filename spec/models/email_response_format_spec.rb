require "spec_helper"
require "json"
require "date"

describe Checkify::EmailResponseFormat do
  let(:attributes) do
    {
      valid: true,
      account: "localpart",
      domain: "example.org"
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

    it "has account" do
      expect(instance.account).to eq("localpart")
    end

    it "has domain" do
      expect(instance.domain).to eq("example.org")
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "valid" => true,
        "account" => "localpart",
        "domain" => "example.org"
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.valid).to eq(true)
      expect(obj.account).to eq("localpart")
      expect(obj.domain).to eq("example.org")
    end
  end
end
