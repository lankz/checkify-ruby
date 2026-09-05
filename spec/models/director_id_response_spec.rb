require "spec_helper"
require "json"
require "date"

describe Checkify::DirectorIdResponse do
  let(:attributes) do
    {
      director_id: "123456789",
      director_id_formatted: "123 456 789",
      valid: true,
      notice: "valid director ID"
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has director_id" do
      expect(instance.director_id).to eq("123456789")
    end

    it "has director_id_formatted" do
      expect(instance.director_id_formatted).to eq("123 456 789")
    end

    it "has valid" do
      expect(instance.valid).to eq(true)
    end

    it "has notice" do
      expect(instance.notice).to eq("valid director ID")
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "directorId" => "123456789",
        "directorIdFormatted" => "123 456 789",
        "valid" => true,
        "notice" => "valid director ID"
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.director_id).to eq("123456789")
      expect(obj.director_id_formatted).to eq("123 456 789")
      expect(obj.valid).to eq(true)
      expect(obj.notice).to eq("valid director ID")
    end

    it "round-trips through to_hash and build_from_hash" do
      obj = described_class.build_from_hash(
        "directorId" => "987654321",
        "directorIdFormatted" => "987 654 321",
        "valid" => false,
        "notice" => "invalid"
      )
      again = described_class.build_from_hash(obj.to_hash)
      expect(again).to eq(obj)
    end
  end
end
