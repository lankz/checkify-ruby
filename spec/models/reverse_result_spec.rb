require "spec_helper"
require "json"
require "date"

describe Checkify::ReverseResult do
  let(:attributes) do
    {
      address_id: "addr-9",
      address_full: "1 Example St, Sydney NSW 2000",
      unit: nil,
      street_number: "1",
      street: "Example St",
      city: "Sydney",
      postcode: "2000",
      state: "NSW",
      latitude: -33.8688,
      longitude: 151.2093,
      distance_metres: 42.5
    }
  end

  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has address_id" do
      expect(instance.address_id).to eq("addr-9")
    end

    it "has address_full" do
      expect(instance.address_full).to eq("1 Example St, Sydney NSW 2000")
    end

    it "has unit" do
      expect(instance.unit).to be_nil
    end

    it "has street_number" do
      expect(instance.street_number).to eq("1")
    end

    it "has street" do
      expect(instance.street).to eq("Example St")
    end

    it "has city" do
      expect(instance.city).to eq("Sydney")
    end

    it "has postcode" do
      expect(instance.postcode).to eq("2000")
    end

    it "has state" do
      expect(instance.state).to eq("NSW")
    end

    it "has latitude" do
      expect(instance.latitude).to eq(-33.8688)
    end

    it "has longitude" do
      expect(instance.longitude).to eq(151.2093)
    end

    it "has distance_metres" do
      expect(instance.distance_metres).to eq(42.5)
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "addressId" => "addr-9",
        "addressFull" => "1 Example St, Sydney NSW 2000",
        "unit" => nil,
        "streetNumber" => "1",
        "street" => "Example St",
        "city" => "Sydney",
        "postcode" => "2000",
        "state" => "NSW",
        "latitude" => -33.8688,
        "longitude" => 151.2093,
        "distanceMetres" => 42.5
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.address_id).to eq("addr-9")
      expect(obj.address_full).to eq("1 Example St, Sydney NSW 2000")
      expect(obj.unit).to be_nil
      expect(obj.street_number).to eq("1")
      expect(obj.street).to eq("Example St")
      expect(obj.city).to eq("Sydney")
      expect(obj.postcode).to eq("2000")
      expect(obj.state).to eq("NSW")
      expect(obj.latitude).to eq(-33.8688)
      expect(obj.longitude).to eq(151.2093)
      expect(obj.distance_metres).to eq(42.5)
    end
  end
end
