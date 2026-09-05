require "spec_helper"
require "json"
require "date"

describe Checkify::AddressDetails do
  let(:attributes) do
    {
      unit: "5",
      level: "3",
      unit_level: "Unit 5 Level 3",
      street_number: "100",
      street_name: "George",
      street_type: "ST",
      street: "100 George ST",
      city: "Sydney",
      postcode: "2000",
      state: "NSW",
      state_full: "New South Wales",
      region: nil,
      country: "AU",
      country_full: "Australia",
      latitude: -33.8688,
      longitude: 151.2093,
      mesh_block_code: "MB001",
      building_name: "Regency Tower"
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has unit" do
      expect(instance.unit).to eq("5")
    end

    it "has level" do
      expect(instance.level).to eq("3")
    end

    it "has unit_level" do
      expect(instance.unit_level).to eq("Unit 5 Level 3")
    end

    it "has street_number" do
      expect(instance.street_number).to eq("100")
    end

    it "has street_name" do
      expect(instance.street_name).to eq("George")
    end

    it "has street_type" do
      expect(instance.street_type).to eq("ST")
    end

    it "has street" do
      expect(instance.street).to eq("100 George ST")
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

    it "has latitude" do
      expect(instance.latitude).to eq(-33.8688)
    end

    it "has longitude" do
      expect(instance.longitude).to eq(151.2093)
    end

    it "has mesh_block_code" do
      expect(instance.mesh_block_code).to eq("MB001")
    end

    it "has building_name" do
      expect(instance.building_name).to eq("Regency Tower")
    end
  end

  describe ".build_from_hash" do
    let(:api_hash) do
      {
        "unit" => "5",
        "level" => "3",
        "unitLevel" => "Unit 5 Level 3",
        "streetNumber" => "100",
        "streetName" => "George",
        "streetType" => "ST",
        "street" => "100 George ST",
        "city" => "Sydney",
        "postcode" => "2000",
        "state" => "NSW",
        "stateFull" => "New South Wales",
        "region" => nil,
        "country" => "AU",
        "countryFull" => "Australia",
        "latitude" => -33.8688,
        "longitude" => 151.2093,
        "meshBlockCode" => "MB001",
        "buildingName" => "Regency Tower"
      }
    end

    it "builds from JSON-key hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(obj).to be_a(described_class)
      expect(obj.unit).to eq("5")
      expect(obj.level).to eq("3")
      expect(obj.unit_level).to eq("Unit 5 Level 3")
      expect(obj.street_number).to eq("100")
      expect(obj.street_name).to eq("George")
      expect(obj.street_type).to eq("ST")
      expect(obj.street).to eq("100 George ST")
      expect(obj.city).to eq("Sydney")
      expect(obj.postcode).to eq("2000")
      expect(obj.state).to eq("NSW")
      expect(obj.state_full).to eq("New South Wales")
      expect(obj.region).to be_nil
      expect(obj.country).to eq("AU")
      expect(obj.country_full).to eq("Australia")
      expect(obj.latitude).to eq(-33.8688)
      expect(obj.longitude).to eq(151.2093)
      expect(obj.mesh_block_code).to eq("MB001")
      expect(obj.building_name).to eq("Regency Tower")
    end

    it "round-trips through to_hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(round_trip_api_model(described_class, api_hash)).to eq(obj)
    end
  end
end
