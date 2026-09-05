require "spec_helper"
require "json"

describe Checkify::BusinessApi do
  let(:api) { described_class.new }

  describe "#abn_lookup", vcr: { cassette_name: "business/abn_lookup" } do
    it "returns an AbnResponse for Bunnings's ABN" do
      result = api.abn_lookup("26 008 672 179")
      expect(result).to be_a(Checkify::AbnResponse)
      expect(result.abn).to eq("26008672179")
      expect(result.entity_name).to match(/BUNNINGS GROUP/i)
      expect(result.entity_type).to be_a(String)
    end

    it "includes ABN status details" do
      result = api.abn_lookup("26 008 672 179")
      expect(result.abn_details).to be_a(Checkify::AbnResponseAbnDetails)
      expect(result.abn_details.active).to be(true)
      expect(result.abn_details.active_from).not_to be_nil
    end

    it "includes formatted ABN and ACN" do
      result = api.abn_lookup("26 008 672 179")
      expect(result.abn_formatted).to eq("26 008 672 179")
      expect(result.acn).to eq("008672179")
      expect(result.acn_formatted).to eq("008 672 179")
    end

    it "raises when abn is nil" do
      expect { api.abn_lookup(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end
  end

  describe "#acn_lookup", vcr: { cassette_name: "business/acn_lookup" } do
    it "returns an AcnResponse for Bunnings's ACN" do
      result = api.acn_lookup("008 672 179")
      expect(result).to be_a(Checkify::AcnResponse)
      expect(result.acn).to eq("008672179")
      expect(result.entity_name).to match(/BUNNINGS GROUP/i)
    end

    it "includes ACN registration details" do
      result = api.acn_lookup("008 672 179")
      expect(result.acn_details).to be_a(Checkify::AcnResponseAcnDetails)
      expect(result.acn_details.active).to be(true)
      expect(result.acn_details.active_from).not_to be_nil
    end

    it "includes addresses" do
      result = api.acn_lookup("008 672 179")
      expect(result.addresses).to be_an(Array)
      expect(result.addresses.size).to be > 0
      expect(result.addresses.first).to be_a(Checkify::AcnAddress)
    end

    it "raises when acn is nil" do
      expect { api.acn_lookup(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end
  end

  describe "#business_activity", vcr: { cassette_name: "business/business_activity" } do
    it "returns matching activities" do
      result = api.business_activity("accounting")
      expect(result).to be_a(Checkify::BusinessActivityResponse)
      expect(result.status).to eq("success")
      expect(result.count).to be > 0
      expect(result.activities).to be_an(Array)

      activity = result.activities.first
      expect(activity).to be_a(Checkify::BusinessActivity)
      expect(activity.code).to be_a(String)
      expect(activity.industry_code).to be_a(String)
      expect(activity.full_name).to be_a(String)
    end

    it "respects limit parameter" do
      result = api.business_activity("accounting", limit: 3)
      expect(result.activities.size).to be <= 3
    end

    it "raises when search is too short" do
      expect { api.business_activity("ab") }.to raise_error(ArgumentError, /character length/)
    end

    it "raises when search is nil" do
      expect { api.business_activity(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end
  end

  describe "#business_name_check", vcr: { cassette_name: "business/business_name_check" } do
    it "returns a NameAvailability result" do
      result = api.business_name_check("Bunnings")
      expect(result).to be_a(Checkify::NameAvailability)
      expect(result.name).to be_a(String)
      expect(result.availability).to be_a(String)
      expect(result.short_description).to be_a(String)
      expect(result.objections).to be_an(Array)
      expect(result).to respond_to(:existing_business_name)
    end

    it "raises when name is nil" do
      expect { api.business_name_check(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end
  end

  describe "#company_name_check", vcr: { cassette_name: "business/company_name_check" } do
    it "returns a NameAvailability result" do
      result = api.company_name_check("Bunnings Group Limited")
      expect(result).to be_a(Checkify::NameAvailability)
      expect(result.name).to be_a(String)
      expect(result.availability).to be_a(String)
      expect(result.short_description).to be_a(String)
    end

    it "raises when name is nil" do
      expect { api.company_name_check(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end
  end
end
