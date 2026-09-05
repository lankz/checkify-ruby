require "spec_helper"
require "json"
require "date"

describe Checkify::PhoneResponse do
  let(:attributes) do
    {
      phone: "+61400111222",
      phone_national: "0400 111 222",
      phone_international: "+61 400 111 222",
      valid: true,
      country: "AU",
      type: "mobile",
      carrier: "Telstra",
      location: "NSW"
    }
  end

  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has phone" do
      expect(instance.phone).to eq("+61400111222")
    end

    it "has phone_national" do
      expect(instance.phone_national).to eq("0400 111 222")
    end

    it "has phone_international" do
      expect(instance.phone_international).to eq("+61 400 111 222")
    end

    it "has valid" do
      expect(instance.valid).to eq(true)
    end

    it "has country" do
      expect(instance.country).to eq("AU")
    end

    it "has type" do
      expect(instance.type).to eq("mobile")
    end

    it "has carrier" do
      expect(instance.carrier).to eq("Telstra")
    end

    it "has location" do
      expect(instance.location).to eq("NSW")
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "phone" => "+61400111222",
        "phoneNational" => "0400 111 222",
        "phoneInternational" => "+61 400 111 222",
        "valid" => true,
        "country" => "AU",
        "type" => "mobile",
        "carrier" => "Telstra",
        "location" => "NSW"
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.phone).to eq("+61400111222")
      expect(obj.phone_national).to eq("0400 111 222")
      expect(obj.phone_international).to eq("+61 400 111 222")
      expect(obj.valid).to eq(true)
      expect(obj.country).to eq("AU")
      expect(obj.type).to eq("mobile")
      expect(obj.carrier).to eq("Telstra")
      expect(obj.location).to eq("NSW")
    end
  end
end
