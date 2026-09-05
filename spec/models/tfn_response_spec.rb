require "spec_helper"
require "json"
require "date"

describe Checkify::TfnResponse do
  let(:attributes) do
    {
      tfn: "123456782",
      tfn_formatted: "123 456 782",
      valid: true,
      notice: "valid TFN"
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has tfn" do
      expect(instance.tfn).to eq("123456782")
    end

    it "has tfn_formatted" do
      expect(instance.tfn_formatted).to eq("123 456 782")
    end

    it "has valid" do
      expect(instance.valid).to eq(true)
    end

    it "has notice" do
      expect(instance.notice).to eq("valid TFN")
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "tfn" => "123456782",
        "tfnFormatted" => "123 456 782",
        "valid" => true,
        "notice" => "valid TFN"
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.tfn).to eq("123456782")
      expect(obj.tfn_formatted).to eq("123 456 782")
      expect(obj.valid).to eq(true)
      expect(obj.notice).to eq("valid TFN")
    end

    it "round-trips through to_hash and build_from_hash" do
      obj = described_class.build_from_hash(
        "tfn" => "111111111",
        "tfnFormatted" => "111 111 111",
        "valid" => false,
        "notice" => "checksum failed"
      )
      again = described_class.build_from_hash(obj.to_hash)
      expect(again).to eq(obj)
    end
  end
end
