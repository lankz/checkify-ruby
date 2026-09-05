require "spec_helper"
require "json"
require "date"

describe Checkify::AsicDocumentContentsInner do
  let(:attributes) do
    {
      sub_code: "CHG1",
      title: "Change of registered office"
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has sub_code" do
      expect(instance.sub_code).to eq("CHG1")
    end

    it "has title" do
      expect(instance.title).to eq("Change of registered office")
    end
  end

  describe ".build_from_hash" do
    let(:api_hash) do
      {
        "subCode" => "CHG1",
        "title" => "Change of registered office"
      }
    end

    it "builds from JSON-key hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(obj).to be_a(described_class)
      expect(obj.sub_code).to eq("CHG1")
      expect(obj.title).to eq("Change of registered office")
    end

    it "round-trips through to_hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(round_trip_api_model(described_class, api_hash)).to eq(obj)
    end
  end
end
