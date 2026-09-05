require "spec_helper"
require "json"
require "date"

describe Checkify::SanctionsResult do
  let(:sanctions) do
    Checkify::SanctionsResultSanctions.new(
      targeted_financial_sanction: true,
      travel_ban: true,
      arms_embargo: false,
      maritime_restriction: false
    )
  end
  let(:attributes) do
    {
      source: "dfat",
      reference: "DFAT-42",
      name: "Listed Person",
      type: "Individual",
      aliases: ["aka one", "aka two"],
      confidence: 0.72,
      sanctions: sanctions,
      date_of_birth: "1980-05-05",
      place_of_birth: "Sydney",
      citizenship: "AU",
      committees: "UNSC 1267",
      listing_information: "Listed 2020",
      source_updated_at: "2024-06-01"
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has source" do
      expect(instance.source).to eq("dfat")
    end

    it "has reference" do
      expect(instance.reference).to eq("DFAT-42")
    end

    it "has name" do
      expect(instance.name).to eq("Listed Person")
    end

    it "has type" do
      expect(instance.type).to eq("Individual")
    end

    it "has aliases" do
      expect(instance.aliases).to eq(["aka one", "aka two"])
    end

    it "has confidence" do
      expect(instance.confidence).to eq(0.72)
    end

    it "has sanctions" do
      expect(instance.sanctions).to eq(sanctions)
    end

    it "has date_of_birth" do
      expect(instance.date_of_birth).to eq("1980-05-05")
    end

    it "has place_of_birth" do
      expect(instance.place_of_birth).to eq("Sydney")
    end

    it "has citizenship" do
      expect(instance.citizenship).to eq("AU")
    end

    it "has committees" do
      expect(instance.committees).to eq("UNSC 1267")
    end

    it "has listing_information" do
      expect(instance.listing_information).to eq("Listed 2020")
    end

    it "has source_updated_at" do
      expect(instance.source_updated_at).to eq("2024-06-01")
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "source" => "eu",
        "reference" => "EU-9",
        "name" => "Vessel X",
        "type" => "Vessel",
        "aliases" => ["MV Test"],
        "confidence" => 0.5,
        "sanctions" => {
          "targeted_financial_sanction" => false,
          "travel_ban" => false,
          "arms_embargo" => true,
          "maritime_restriction" => true
        },
        "date_of_birth" => nil,
        "place_of_birth" => nil,
        "citizenship" => nil,
        "committees" => nil,
        "listing_information" => nil,
        "source_updated_at" => "2023-11-11"
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.source).to eq("eu")
      expect(obj.reference).to eq("EU-9")
      expect(obj.name).to eq("Vessel X")
      expect(obj.type).to eq("Vessel")
      expect(obj.aliases).to eq(["MV Test"])
      expect(obj.confidence).to eq(0.5)
      expect(obj.sanctions).to be_a(Checkify::SanctionsResultSanctions)
      expect(obj.date_of_birth).to be_nil
      expect(obj.place_of_birth).to be_nil
      expect(obj.citizenship).to be_nil
      expect(obj.committees).to be_nil
      expect(obj.listing_information).to be_nil
      expect(obj.source_updated_at).to eq("2023-11-11")
    end

    it "round-trips through to_hash and build_from_hash" do
      obj = described_class.build_from_hash(
        "source" => "uk",
        "reference" => "UK-1",
        "name" => "Round Trip Co",
        "type" => "Entity",
        "aliases" => [],
        "confidence" => 0.25,
        "sanctions" => {
          "targeted_financial_sanction" => true,
          "travel_ban" => false,
          "arms_embargo" => false,
          "maritime_restriction" => false
        },
        "date_of_birth" => nil,
        "place_of_birth" => nil,
        "citizenship" => nil,
        "committees" => nil,
        "listing_information" => nil,
        "source_updated_at" => "2024-01-01"
      )
      again = described_class.build_from_hash(obj.to_hash)
      expect(again).to eq(obj)
    end
  end
end
