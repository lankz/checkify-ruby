require "spec_helper"
require "json"
require "date"

describe Checkify::BulkCreateRequest do
  let(:attributes) do
    {
      endpoint: "email",
      items: []
    }
  end

  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has endpoint" do
      expect(instance.endpoint).to eq("email")
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "endpoint" => "reverse",
        "items" => []
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.endpoint).to eq("reverse")
    end
  end
end
