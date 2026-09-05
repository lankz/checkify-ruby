require "spec_helper"
require "json"
require "date"

describe Checkify::PostcodeResult do
  let(:attributes) do
    {
      locality_id: "loc-1",
      city: "Surry Hills",
      postcode: "2010",
      state: "NSW",
      state_full: "New South Wales",
      country: "AU",
      country_full: "Australia"
    }
  end

  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has locality_id" do
      expect(instance.locality_id).to eq("loc-1")
    end

    it "has city" do
      expect(instance.city).to eq("Surry Hills")
    end

    it "has postcode" do
      expect(instance.postcode).to eq("2010")
    end

    it "has state" do
      expect(instance.state).to eq("NSW")
    end

    it "has state_full" do
      expect(instance.state_full).to eq("New South Wales")
    end

    it "has country" do
      expect(instance.country).to eq("AU")
    end

    it "has country_full" do
      expect(instance.country_full).to eq("Australia")
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "localityId" => "loc-1",
        "city" => "Surry Hills",
        "postcode" => "2010",
        "state" => "NSW",
        "stateFull" => "New South Wales",
        "country" => "AU",
        "countryFull" => "Australia"
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.locality_id).to eq("loc-1")
      expect(obj.city).to eq("Surry Hills")
      expect(obj.postcode).to eq("2010")
      expect(obj.state).to eq("NSW")
      expect(obj.state_full).to eq("New South Wales")
      expect(obj.country).to eq("AU")
      expect(obj.country_full).to eq("Australia")
    end
  end
end
