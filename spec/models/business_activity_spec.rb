require "spec_helper"
require "json"
require "date"

describe Checkify::BusinessActivity do
  let(:attributes) do
    {
      code: "4511",
      industry_code: "4511",
      full_name: "Supermarket and grocery stores"
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has code" do
      expect(instance.code).to eq("4511")
    end

    it "has industry_code" do
      expect(instance.industry_code).to eq("4511")
    end

    it "has full_name" do
      expect(instance.full_name).to eq("Supermarket and grocery stores")
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "code" => "4511",
        "industryCode" => "4511",
        "fullName" => "Supermarket and grocery stores"
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.code).to eq("4511")
      expect(obj.industry_code).to eq("4511")
      expect(obj.full_name).to eq("Supermarket and grocery stores")
    end

    it "round-trips through to_hash and build_from_hash" do
      obj = described_class.build_from_hash(
        "code" => "1234",
        "industryCode" => "5678",
        "fullName" => "Test activity"
      )
      again = described_class.build_from_hash(obj.to_hash)
      expect(again).to eq(obj)
    end
  end
end
