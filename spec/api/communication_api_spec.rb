require "spec_helper"
require "json"

describe Checkify::CommunicationApi do
  let(:api) { described_class.new }

  describe "#email_validation", vcr: { cassette_name: "communication/email_validation" } do
    it "returns an EmailResponse with validity and format details" do
      result = api.email_validation("person@example.com")
      expect(result).to be_a(Checkify::EmailResponse)
      expect(result.email).to eq("person@example.com")
      expect(result.valid).to be(true)
      expect(result.format.valid).to be(true)
      expect(result.format.account).to eq("person")
      expect(result.format.domain).to eq("example.com")
    end

    it "includes DNS check" do
      result = api.email_validation("person@example.com")
      expect(result.dns.valid).to be(true)
    end

    it "includes deliverability and quality score" do
      result = api.email_validation("person@example.com")
      expect(result.score).to be_a(Numeric)
      expect(result.score).to be_between(0, 1)
    end

    it "includes provider classification flags" do
      result = api.email_validation("person@example.com")
      expect([true, false]).to include(result.free)
      expect(result.disposable).to eq(false)
    end

    it "raises when email is nil" do
      expect { api.email_validation(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end
  end

  describe "#phone_validation", vcr: { cassette_name: "communication/phone_validation" } do
    it "returns a PhoneResponse with E.164 and national formats" do
      result = api.phone_validation("0412345678")
      expect(result).to be_a(Checkify::PhoneResponse)
      expect(result.valid).to be(true)
      expect(result.phone).to eq("+61412345678")
      expect(result.phone_national).to be_a(String)
      expect(result.phone_international).to be_a(String)
    end

    it "detects AU country and mobile type" do
      result = api.phone_validation("0412345678")
      expect(result.country).to eq("AU")
      expect(result.type).to eq("mobile")
    end

    it "includes carrier information" do
      result = api.phone_validation("0412345678")
      expect(result.carrier).to be_a(String)
    end

    it "raises when phone is nil" do
      expect { api.phone_validation(nil) }.to raise_error(ArgumentError, /Missing the required parameter/)
    end
  end
end
