require "spec_helper"
require "json"
require "date"

describe Checkify::AcnResponse do
  let(:acn_details) do
    Checkify::AcnResponseAcnDetails.new(
      active: true,
      active_from: Date.new(2018, 5, 1),
      active_to: nil
    )
  end
  let(:addresses) do
    [
      Checkify::AcnAddress.new(
        type: "registeredOffice",
        suburb: "Sydney",
        state: "NSW",
        postcode: "2000"
      )
    ]
  end
  let(:former_names) do
    [
      Checkify::FormerName.new(
        name: "Old Co Pty Ltd",
        active_from: Date.new(2015, 1, 1),
        active_to: Date.new(2017, 12, 31)
      )
    ]
  end
  let(:documents) do
    [
      Checkify::AsicDocument.new(
        number: "201",
        date: Date.new(2023, 3, 1),
        code: "CHG",
        title: "Change of details",
        pages: 2,
        contents: [
          Checkify::AsicDocumentContentsInner.new(sub_code: "A", title: "Director")
        ]
      )
    ]
  end
  let(:attributes) do
    {
      abn: nil,
      abn_formatted: nil,
      acn: "123456789",
      acn_formatted: "123 456 789",
      entity_name: "Holdings Pty Ltd",
      entity_type: "APTY",
      abn_details: nil,
      acn_details: acn_details,
      addresses: addresses,
      former_names: former_names,
      documents: documents
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
      expect(instance.abn).to be_nil
    end

    it "has abn_formatted" do
      expect(instance.abn_formatted).to be_nil
    end

    it "has acn" do
      expect(instance.acn).to eq("123456789")
    end

    it "has acn_formatted" do
      expect(instance.acn_formatted).to eq("123 456 789")
    end

    it "has entity_name" do
      expect(instance.entity_name).to eq("Holdings Pty Ltd")
    end

    it "has entity_type" do
      expect(instance.entity_type).to eq("APTY")
    end

    it "has abn_details" do
      expect(instance.abn_details).to be_nil
    end

    it "has acn_details" do
      expect(instance.acn_details).to eq(acn_details)
    end

    it "has addresses" do
      expect(instance.addresses).to eq(addresses)
    end

    it "has former_names" do
      expect(instance.former_names).to eq(former_names)
    end

    it "has documents" do
      expect(instance.documents).to eq(documents)
    end
  end

  describe ".build_from_hash" do
    let(:api_hash) do
      {
        "abn" => nil,
        "abnFormatted" => nil,
        "acn" => "123456789",
        "acnFormatted" => "123 456 789",
        "entityName" => "Holdings Pty Ltd",
        "entityType" => "APTY",
        "abnDetails" => nil,
        "acnDetails" => {
          "active" => true,
          "activeFrom" => "2018-05-01",
          "activeTo" => nil
        },
        "addresses" => [
          {
            "type" => "registeredOffice",
            "suburb" => "Sydney",
            "state" => "NSW",
            "postcode" => "2000"
          }
        ],
        "formerNames" => [
          {
            "name" => "Old Co Pty Ltd",
            "activeFrom" => "2015-01-01",
            "activeTo" => "2017-12-31"
          }
        ],
        "documents" => [
          {
            "number" => "201",
            "date" => "2023-03-01",
            "code" => "CHG",
            "title" => "Change of details",
            "pages" => 2,
            "contents" => [
              { "subCode" => "A", "title" => "Director" }
            ]
          }
        ]
      }
    end

    it "builds from JSON-key hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(obj).to be_a(described_class)
      expect(obj.abn).to be_nil
      expect(obj.abn_formatted).to be_nil
      expect(obj.acn).to eq("123456789")
      expect(obj.acn_formatted).to eq("123 456 789")
      expect(obj.entity_name).to eq("Holdings Pty Ltd")
      expect(obj.entity_type).to eq("APTY")
      expect(obj.abn_details).to be_nil
      expect(obj.acn_details).to be_a(Checkify::AcnResponseAcnDetails)
      expect(obj.acn_details.active).to be true
      expect(obj.acn_details.active_from).to eq(Date.new(2018, 5, 1))
      expect(obj.acn_details.active_to).to be_nil
      expect(obj.addresses.first).to be_a(Checkify::AcnAddress)
      expect(obj.former_names.first).to be_a(Checkify::FormerName)
      expect(obj.documents.first).to be_a(Checkify::AsicDocument)
      expect(obj.documents.first.contents.first).to be_a(Checkify::AsicDocumentContentsInner)
    end

    it "round-trips through to_hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(round_trip_api_model(described_class, api_hash)).to eq(obj)
    end
  end
end
