require "spec_helper"
require "json"
require "date"

describe Checkify::NameAvailability do
  let(:objections) { ["too similar to existing name"] }
  let(:attributes) do
    {
      name: "EXAMPLE CO",
      availability: "Unavailable",
      short_description: "Taken",
      objections: objections,
      existing_business_name: true
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has name" do
      expect(instance.name).to eq("EXAMPLE CO")
    end

    it "has availability" do
      expect(instance.availability).to eq("Unavailable")
    end

    it "has short_description" do
      expect(instance.short_description).to eq("Taken")
    end

    it "has objections" do
      expect(instance.objections).to eq(objections)
    end

    it "has existing_business_name" do
      expect(instance.existing_business_name).to eq(true)
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "name" => "EXAMPLE CO",
        "availability" => "Unavailable",
        "shortDescription" => "Taken",
        "objections" => ["too similar to existing name"],
        "existingBusinessName" => true
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.name).to eq("EXAMPLE CO")
      expect(obj.availability).to eq("Unavailable")
      expect(obj.short_description).to eq("Taken")
      expect(obj.objections).to eq(["too similar to existing name"])
      expect(obj.existing_business_name).to eq(true)
    end

    it "round-trips through to_hash and build_from_hash" do
      obj = described_class.build_from_hash(
        "name" => "FOO",
        "availability" => "Available",
        "shortDescription" => "OK",
        "objections" => [],
        "existingBusinessName" => false
      )
      again = described_class.build_from_hash(obj.to_hash)
      expect(again).to eq(obj)
    end
  end
end
