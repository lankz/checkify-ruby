require "spec_helper"
require "json"
require "date"

describe Checkify::FormerName do
  let(:active_from) { Date.new(2020, 1, 15) }
  let(:active_to) { Date.new(2021, 6, 30) }
  let(:attributes) do
    {
      name: "ACME Pty Ltd",
      active_from: active_from,
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
    it "has name" do
      expect(instance.name).to eq("ACME Pty Ltd")
    end

    it "has active_from" do
      expect(instance.active_from).to eq(active_from)
    end

    it "has active_to" do
      expect(instance.active_to).to eq(active_to)
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "name" => "ACME Pty Ltd",
        "activeFrom" => "2020-01-15",
        "activeTo" => "2021-06-30"
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.name).to eq("ACME Pty Ltd")
      expect(obj.active_from).to eq(Date.new(2020, 1, 15))
      expect(obj.active_to).to eq(Date.new(2021, 6, 30))
    end

    it "round-trips through to_hash and build_from_hash" do
      obj = described_class.build_from_hash(
        "name" => "Beta Co",
        "activeFrom" => "2019-03-01",
        "activeTo" => "2022-12-31"
      )
      # to_hash keeps Date instances; wire format uses ISO strings
      wire = obj.to_hash.transform_values { |v| v.is_a?(Date) ? v.iso8601 : v }
      again = described_class.build_from_hash(wire)
      expect(again).to eq(obj)
    end
  end
end
