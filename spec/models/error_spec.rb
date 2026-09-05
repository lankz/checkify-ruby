require "spec_helper"
require "json"
require "date"

describe Checkify::Error do
  let(:attributes) do
    {
      error: "bad request"
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has error" do
      expect(instance.error).to eq("bad request")
    end
  end

  describe ".build_from_hash" do
    it "preserves field-level validation errors without requiring an error string" do
      body = { "message" => "Invalid ABN", "errors" => { "abn" => ["Must be 11 digits"] } }
      obj = round_trip_api_model(described_class, body)
      expect(obj.message).to eq("Invalid ABN")
      expect(obj.errors).to eq("abn" => ["Must be 11 digits"])
      expect(obj.error).to be_nil
    end

    it "builds from JSON-key hash" do
      hash = {
        "error" => "not found"
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.error).to eq("not found")
    end

    it "round-trips through to_hash and build_from_hash" do
      obj = described_class.build_from_hash("error" => "server error")
      again = described_class.build_from_hash(obj.to_hash)
      expect(again).to eq(obj)
    end
  end
end
