require "spec_helper"
require "json"
require "date"

describe Checkify::AcnResponseAcnDetails do
  let(:active_to) { Date.new(2025, 12, 31) }
  let(:attributes) do
    {
      active: false,
      active_from: Date.new(2020, 1, 1),
      active_to: active_to
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has active" do
      expect(instance.active).to be false
    end

    it "has active_from" do
      expect(instance.active_from).to eq(Date.new(2020, 1, 1))
    end

    it "has active_to" do
      expect(instance.active_to).to eq(active_to)
    end
  end

  describe ".build_from_hash" do
    let(:api_hash) do
      {
        "active" => false,
        "activeFrom" => "2020-01-01",
        "activeTo" => "2025-12-31"
      }
    end

    it "builds from JSON-key hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(obj).to be_a(described_class)
      expect(obj.active).to be false
      expect(obj.active_from).to eq(Date.new(2020, 1, 1))
      expect(obj.active_to).to eq(Date.new(2025, 12, 31))
    end

    it "round-trips through to_hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(round_trip_api_model(described_class, api_hash)).to eq(obj)
    end
  end
end
