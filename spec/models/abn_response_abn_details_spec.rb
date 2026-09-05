require "spec_helper"
require "json"
require "date"

describe Checkify::AbnResponseAbnDetails do
  let(:gst) { Date.new(2020, 7, 1) }
  let(:attributes) do
    {
      active: true,
      active_from: Date.new(2019, 3, 15),
      gst: gst
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
      expect(instance.active).to be true
    end

    it "has active_from" do
      expect(instance.active_from).to eq(Date.new(2019, 3, 15))
    end

    it "has gst" do
      expect(instance.gst).to eq(gst)
    end
  end

  describe ".build_from_hash" do
    let(:api_hash) do
      {
        "active" => true,
        "activeFrom" => "2019-03-15",
        "gst" => "2020-07-01"
      }
    end

    it "builds from JSON-key hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(obj).to be_a(described_class)
      expect(obj.active).to be true
      expect(obj.active_from).to eq(Date.new(2019, 3, 15))
      expect(obj.gst).to eq(Date.new(2020, 7, 1))
    end

    it "round-trips through to_hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(round_trip_api_model(described_class, api_hash)).to eq(obj)
    end
  end
end
