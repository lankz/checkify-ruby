require "spec_helper"
require "json"
require "date"

describe Checkify::BusinessActivityResponse do
  let(:activities) do
    [
      Checkify::BusinessActivity.new(
        code: "4511",
        industry_code: "4511",
        full_name: "Retail"
      )
    ]
  end
  let(:attributes) do
    {
      status: "ok",
      count: 1,
      activities: activities
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has status" do
      expect(instance.status).to eq("ok")
    end

    it "has count" do
      expect(instance.count).to eq(1)
    end

    it "has activities" do
      expect(instance.activities).to eq(activities)
      expect(instance.activities.first).to be_a(Checkify::BusinessActivity)
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "status" => "ok",
        "count" => 1,
        "activities" => [
          {
            "code" => "4511",
            "industryCode" => "4511",
            "fullName" => "Retail"
          }
        ]
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.status).to eq("ok")
      expect(obj.count).to eq(1)
      expect(obj.activities.size).to eq(1)
      expect(obj.activities.first).to be_a(Checkify::BusinessActivity)
      expect(obj.activities.first.code).to eq("4511")
      expect(obj.activities.first.full_name).to eq("Retail")
    end

    it "round-trips through to_hash and build_from_hash" do
      obj = described_class.build_from_hash(
        "status" => "ok",
        "count" => 2,
        "activities" => [
          { "code" => "a", "industryCode" => "b", "fullName" => "c" }
        ]
      )
      again = described_class.build_from_hash(obj.to_hash)
      expect(again).to eq(obj)
    end
  end
end
