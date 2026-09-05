require "spec_helper"
require "json"
require "date"

describe Checkify::SanctionsResponse do
  let(:sanctions_obj) do
    Checkify::SanctionsResultSanctions.new(
      targeted_financial_sanction: true,
      travel_ban: false,
      arms_embargo: false,
      maritime_restriction: false
    )
  end
  let(:results) do
    [
      Checkify::SanctionsResult.new(
        source: "ofac",
        reference: "REF-1",
        name: "Test Entity",
        type: "Entity",
        aliases: ["Alias One"],
        confidence: 0.85,
        sanctions: sanctions_obj,
        date_of_birth: nil,
        place_of_birth: nil,
        citizenship: nil,
        committees: nil,
        listing_information: nil,
        source_updated_at: "2024-01-15"
      )
    ]
  end
  let(:attributes) do
    {
      match: true,
      results: results
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has match" do
      expect(instance.match).to eq(true)
    end

    it "has results" do
      expect(instance.results).to eq(results)
      expect(instance.results.first).to be_a(Checkify::SanctionsResult)
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "match" => true,
        "results" => [
          {
            "source" => "ofac",
            "reference" => "REF-1",
            "name" => "Test Entity",
            "type" => "Entity",
            "aliases" => ["Alias One"],
            "confidence" => 0.85,
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
            "source_updated_at" => "2024-01-15"
          }
        ]
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.match).to eq(true)
      expect(obj.results.size).to eq(1)
      expect(obj.results.first.name).to eq("Test Entity")
      expect(obj.results.first.sanctions).to be_a(Checkify::SanctionsResultSanctions)
    end

    it "round-trips through to_hash and build_from_hash" do
      obj = described_class.build_from_hash(
        "match" => false,
        "results" => []
      )
      again = described_class.build_from_hash(obj.to_hash)
      expect(again).to eq(obj)
    end
  end
end
