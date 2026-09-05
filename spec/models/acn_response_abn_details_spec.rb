require "spec_helper"
require "json"
require "date"

describe Checkify::AcnResponseAbnDetails do
  let(:attributes) do
    {
      active_from: Date.new(2016, 11, 20)
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has active_from" do
      expect(instance.active_from).to eq(Date.new(2016, 11, 20))
    end
  end

  describe ".build_from_hash" do
    let(:api_hash) do
      {
        "activeFrom" => "2016-11-20"
      }
    end

    it "builds from JSON-key hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(obj).to be_a(described_class)
      expect(obj.active_from).to eq(Date.new(2016, 11, 20))
    end

    it "round-trips through to_hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(round_trip_api_model(described_class, api_hash)).to eq(obj)
    end
  end
end
