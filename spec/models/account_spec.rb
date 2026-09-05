require "spec_helper"
require "json"
require "date"

describe Checkify::Account do
  let(:period_start) { Date.new(2026, 4, 1) }
  let(:period_end) { Date.new(2026, 4, 30) }
  let(:cancels_at) { nil }
  let(:attributes) do
    {
      plan: "business",
      plan_name: "Business",
      status: "active",
      cancels_at: cancels_at,
      units_used: 42,
      units_limit: 1000,
      units_remaining: 958,
      period_start: period_start,
      period_end: period_end,
      usage: { "validate_address" => 10, "lookup_abn" => 32 }
    }
  end
  let(:instance) { described_class.new(attributes) }

  describe "instantiation" do
    it "creates an instance" do
      expect(instance).to be_a(described_class)
    end
  end

  describe "attributes" do
    it "has plan" do
      expect(instance.plan).to eq("business")
    end

    it "has plan_name" do
      expect(instance.plan_name).to eq("Business")
    end

    it "has status" do
      expect(instance.status).to eq("active")
    end

    it "has cancels_at" do
      expect(instance.cancels_at).to eq(cancels_at)
    end

    it "has units_used" do
      expect(instance.units_used).to eq(42)
    end

    it "has units_limit" do
      expect(instance.units_limit).to eq(1000)
    end

    it "has units_remaining" do
      expect(instance.units_remaining).to eq(958)
    end

    it "has period_start" do
      expect(instance.period_start).to eq(period_start)
    end

    it "has period_end" do
      expect(instance.period_end).to eq(period_end)
    end

    it "has usage" do
      expect(instance.usage).to eq({ "validate_address" => 10, "lookup_abn" => 32 })
    end
  end

  describe ".build_from_hash" do
    let(:api_hash) do
      {
        "plan" => "business",
        "plan_name" => "Business",
        "status" => "active",
        "cancels_at" => nil,
        "units_used" => 42,
        "units_limit" => 1000,
        "units_remaining" => 958,
        "period_start" => "2026-04-01",
        "period_end" => "2026-04-30",
        "usage" => { "validate_address" => 10, "lookup_abn" => 32 }
      }
    end

    it "builds from JSON-key hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(obj).to be_a(described_class)
      expect(obj.plan).to eq("business")
      expect(obj.plan_name).to eq("Business")
      expect(obj.status).to eq("active")
      expect(obj.cancels_at).to be_nil
      expect(obj.units_used).to eq(42)
      expect(obj.units_limit).to eq(1000)
      expect(obj.units_remaining).to eq(958)
      expect(obj.period_start).to eq(Date.new(2026, 4, 1))
      expect(obj.period_end).to eq(Date.new(2026, 4, 30))
      expect(obj.usage).to eq({ "validate_address" => 10, "lookup_abn" => 32 })
    end

    it "round-trips through to_hash" do
      obj = described_class.build_from_hash(api_hash)
      expect(round_trip_api_model(described_class, api_hash)).to eq(obj)
    end
  end
end
