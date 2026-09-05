require "spec_helper"
require "json"

describe Checkify::AccountApi do
  let(:api) { described_class.new }

  describe "#get_account", vcr: { cassette_name: "account/get_account" } do
    it "returns an Account object" do
      result = api.get_account
      expect(result).to be_a(Checkify::Account)
    end

    it "includes plan details" do
      result = api.get_account
      expect(result.plan).to be_a(String)
      expect(result.plan_name).to be_a(String)
      expect(result.status).to be_a(String)
    end

    it "includes unit usage" do
      result = api.get_account
      expect(result.units_used).to be_a(Integer)
      expect(result.units_limit).to be_a(Integer)
      expect(result.units_remaining).to be_a(Integer)
    end

    it "includes billing period dates" do
      result = api.get_account
      expect(result.period_start).not_to be_nil
      expect(result.period_end).not_to be_nil
    end

    it "includes per-endpoint usage breakdown" do
      result = api.get_account
      expect(result.usage).to be_a(Hash)
    end
  end

  describe "#get_account_with_http_info", vcr: { cassette_name: "account/get_account" } do
    it "returns data, status code, and headers" do
      data, status, headers = api.get_account_with_http_info
      expect(data).to be_a(Checkify::Account)
      expect(status).to eq(200)
      expect(headers).to respond_to(:[])
      expect(headers["Content-Type"]).to include("application/json")
    end
  end
end
