require "spec_helper"
require "json"
require "date"

describe Checkify::BulkJob do
  let(:created_at) { Time.utc(2026, 4, 7, 12, 0, 0) }

  let(:attributes) do
    {
      id: 99,
      endpoint: "email",
      status: "completed",
      total_rows: 1000,
      created_at: created_at
    }
  end

  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has id" do
      expect(instance.id).to eq(99)
    end

    it "has endpoint" do
      expect(instance.endpoint).to eq("email")
    end

    it "has status" do
      expect(instance.status).to eq("completed")
    end

    it "has total_rows" do
      expect(instance.total_rows).to eq(1000)
    end

    it "has created_at" do
      expect(instance.created_at).to eq(created_at)
    end
  end

  describe ".build_from_hash" do
    it "builds from JSON-key hash" do
      hash = {
        "id" => 99,
        "endpoint" => "email",
        "status" => "processing",
        "total_rows" => 500,
        "created_at" => "2026-04-07T12:00:00Z"
      }
      obj = described_class.build_from_hash(hash)
      expect(obj).to be_a(described_class)
      expect(obj.id).to eq(99)
      expect(obj.endpoint).to eq("email")
      expect(obj.status).to eq("processing")
      expect(obj.total_rows).to eq(500)
      expect(obj.created_at).to eq(Time.parse("2026-04-07T12:00:00Z"))
    end
  end
end
