require "spec_helper"
require "json"
require "date"

describe Checkify::SuburbDetails do
  let(:attributes) do
    {
      city: "Surry Hills",
      postcode: "2010",
      state: "NSW",
      state_full: "New South Wales",
      region: nil,
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

    it "has region" do
      expect(instance.region).to be_nil
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
        "city" => "Surry Hills",
        "postcode" => "2010",
        "state" => "NSW",
        "stateFull" => "New South Wales",
        "region" => nil,
        "country" => "AU",
        "countryFull" => "Australia"
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.city).to eq("Surry Hills")
      expect(obj.postcode).to eq("2010")
      expect(obj.state).to eq("NSW")
      expect(obj.state_full).to eq("New South Wales")
      expect(obj.region).to be_nil
      expect(obj.country).to eq("AU")
      expect(obj.country_full).to eq("Australia")
    end
  end
end
