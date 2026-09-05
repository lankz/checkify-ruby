require "spec_helper"
require "json"
require "date"

describe Checkify::AbnResponse do
  let(:abn_details) do
    Checkify::AbnResponseAbnDetails.new(
      active: true,
      active_from: Date.new(2020, 1, 1),
      gst: Date.new(2020, 2, 1)
    )
  end
  let(:addresses) do
    [
      Checkify::AbnAddress.new(
        type: "serviceAddress",
        state: "NSW",
        postcode: "2000",
        active_from: Date.new(2021, 6, 1)
      )
    ]
  end
  let(:attributes) do
    {
      abn: "12345678901",
      abn_formatted: "12 345 678 901",
      acn: "123456789",
      acn_formatted: "123 456 789",
      entity_name: "Example Pty Ltd",
      entity_type: "PRV",
      abn_details: abn_details,
      addresses: addresses,
      business_names: ["Trading Co", "Other Name"]
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has abn" do
      expect(instance.abn).to eq("12345678901")
    end

    it "has abn_formatted" do
      expect(instance.abn_formatted).to eq("12 345 678 901")
    end

    it "has acn" do
      expect(instance.acn).to eq("123456789")
    end

    it "has acn_formatted" do
      expect(instance.acn_formatted).to eq("123 456 789")
    end

    it "has entity_name" do
      expect(instance.entity_name).to eq("Example Pty Ltd")
    end

    it "has entity_type" do
      expect(instance.entity_type).to eq("PRV")
    end

    it "has abn_details" do
      expect(instance.abn_details).to eq(abn_details)
    end

    it "has addresses" do
      expect(instance.addresses).to eq(addresses)
    end

    it "has business_names" do
      expect(instance.business_names).to eq(["Trading Co", "Other Name"])
    end
  end

  describe ".build_from_hash" do
    let(:api_hash) do
      {
        "abn" => "12345678901",
        "abnFormatted" => "12 345 678 901",
        "acn" => "123456789",
        "acnFormatted" => "123 456 789",
        "entityName" => "Example Pty Ltd",
        "entityType" => "PRV",
        "abnDetails" => {
          "active" => true,
          "activeFrom" => "2020-01-01",
          "gst" => "2020-02-01"
        },
        "addresses" => [
          {
            "type" => "serviceAddress",
            "state" => "NSW",
            "postcode" => "2000",
            "activeFrom" => "2021-06-01"
          }
        ],
        "businessNames" => ["Trading Co", "Other Name"]
      }
    end

    it "builds from JSON-key hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(obj).to be_a(described_class)
      expect(obj.abn).to eq("12345678901")
      expect(obj.abn_formatted).to eq("12 345 678 901")
      expect(obj.acn).to eq("123456789")
      expect(obj.acn_formatted).to eq("123 456 789")
      expect(obj.entity_name).to eq("Example Pty Ltd")
      expect(obj.entity_type).to eq("PRV")
      expect(obj.abn_details).to be_a(Checkify::AbnResponseAbnDetails)
      expect(obj.abn_details.active).to be true
      expect(obj.abn_details.active_from).to eq(Date.new(2020, 1, 1))
      expect(obj.abn_details.gst).to eq(Date.new(2020, 2, 1))
      expect(obj.addresses.size).to eq(1)
      expect(obj.addresses.first).to be_a(Checkify::AbnAddress)
      expect(obj.addresses.first.type).to eq("serviceAddress")
      expect(obj.business_names).to eq(["Trading Co", "Other Name"])
    end

    it "round-trips through to_hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(round_trip_api_model(described_class, api_hash)).to eq(obj)
    end
  end
end
