require "spec_helper"
require "json"
require "date"

describe Checkify::AcnAddress do
  let(:attributes) do
    {
      type: "principalPlaceOfBusiness",
      suburb: "Melbourne",
      state: "VIC",
      postcode: "3000"
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has type" do
      expect(instance.type).to eq("principalPlaceOfBusiness")
    end

    it "has suburb" do
      expect(instance.suburb).to eq("Melbourne")
    end

    it "has state" do
      expect(instance.state).to eq("VIC")
    end

    it "has postcode" do
      expect(instance.postcode).to eq("3000")
    end
  end

  describe ".build_from_hash" do
    let(:api_hash) do
      {
        "type" => "principalPlaceOfBusiness",
        "suburb" => "Melbourne",
        "state" => "VIC",
        "postcode" => "3000"
      }
    end

    it "builds from JSON-key hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(obj).to be_a(described_class)
      expect(obj.type).to eq("principalPlaceOfBusiness")
      expect(obj.suburb).to eq("Melbourne")
      expect(obj.state).to eq("VIC")
      expect(obj.postcode).to eq("3000")
    end

    it "round-trips through to_hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(round_trip_api_model(described_class, api_hash)).to eq(obj)
    end
  end
end
